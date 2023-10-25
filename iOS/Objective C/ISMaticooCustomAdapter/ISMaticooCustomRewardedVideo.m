//
//  ISMaticooCustomRewardedVideo.m
//  IronSourceDemoApp
//
//  Created by root on 2023/7/13.
//  Copyright © 2023 supersonic. All rights reserved.
//

#import "ISMaticooCustomRewardedVideo.h"
#import <MaticooSDK/MATRewardedVideoAd.h>
#import "MaticooMediationTrackManager.h"

@interface ISMaticooCustomRewardedVideo () <MATRewardedVideoAdDelegate>
@property (nonatomic, strong) MATRewardedVideoAd *rewardedVideo;
@property (nonatomic, weak) id<ISRewardedVideoAdDelegate> iSDelegate;
@end

@implementation ISMaticooCustomRewardedVideo
- (void)loadAdWithAdData:(nonnull ISAdData *)adData
                delegate:(nonnull id<ISRewardedVideoAdDelegate>)delegate
{
    NSString *placementId = [adData getString:@"placement_id"];
    if (placementId == nil){
        [delegate adDidFailToLoadWithErrorType:ISAdapterErrorTypeInternal errorCode:1 errorMessage:@"zMaticoo Adapter RV Error: placementId is nil"];
        return;
    }
    self.iSDelegate = delegate;
    [MaticooMediationTrackManager trackMediationAdRequest:placementId adType:REWARDEDVIDEO isAutoRefresh:NO];
    self.rewardedVideo = [[MATRewardedVideoAd alloc] initWithPlacementID:placementId];
    self.rewardedVideo.delegate = self;
    [self.rewardedVideo loadAd];
}

- (BOOL)isAdAvailableWithAdData:(nonnull ISAdData *)adData {
    if (self.rewardedVideo){
        return [self.rewardedVideo isReady];
    }else{
        return NO;
    }
}

- (void)showAdWithViewController:(nonnull UIViewController *)viewController
                          adData:(nonnull ISAdData *)adData
                        delegate:(nonnull id<ISRewardedVideoAdDelegate>)delegate {
    if (![self.rewardedVideo isReady]){
        [delegate adDidFailToShowWithErrorCode:ISAdapterErrorInternal
                                        errorMessage:@"zMaticoo Adapter Error : rv is not ready"];
        return;
    }
    [self.rewardedVideo showAdFromViewController:viewController];
    [MaticooMediationTrackManager trackMediationAdShow:self.rewardedVideo.placementID adType:REWARDEDVIDEO];
}

- (void)rewardedVideoAdDidLoad:(MATRewardedVideoAd *)rewardedVideoAd{
    [self.iSDelegate adDidLoad];
    [MaticooMediationTrackManager trackMediationAdRequestFilled:rewardedVideoAd.placementID adType:REWARDEDVIDEO];
}

- (void)rewardedVideoAd:(nonnull MATRewardedVideoAd *)rewardedVideoAd didFailWithError:(nonnull NSError *)error {
    [self.iSDelegate adDidFailToLoadWithErrorType:ISAdapterErrorTypeInternal errorCode:2 errorMessage:error.localizedDescription];
    [MaticooMediationTrackManager trackMediationAdRequestFailed:rewardedVideoAd.placementID adType:REWARDEDVIDEO];
}

- (void)rewardedVideoAd:(nonnull MATRewardedVideoAd *)rewardedVideoAd displayFailWithError:(nonnull NSError *)error {
    [self.iSDelegate adDidFailToShowWithErrorCode:1 errorMessage:error.localizedDescription];
    [MaticooMediationTrackManager trackMediationAdImpFailed:rewardedVideoAd.placementID adType:REWARDEDVIDEO];
}

- (void)rewardedVideoAdCompleted:(nonnull MATRewardedVideoAd *)rewardedVideoAd {
    [self.iSDelegate adDidEnd];
    //For XCTest
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 2, 2)];
    closeBtn.backgroundColor = [UIColor blackColor];
    closeBtn.accessibilityIdentifier = @"ad_closeBtn";
    [closeBtn setTitle:@"x" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [closeBtn addTarget:self action:@selector(closeButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [rewardedVideoAd.modalViewController.view addSubview: closeBtn];
}

//For XCTest
- (void)closeButtonTouchDown:(UIButton*)btn {
    [self.rewardedVideo.modalViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)rewardedVideoAdDidClick:(nonnull MATRewardedVideoAd *)rewardedVideoAd {
    [self.iSDelegate adDidClick];
    [MaticooMediationTrackManager trackMediationAdClick:rewardedVideoAd.placementID adType:REWARDEDVIDEO];
}

- (void)rewardedVideoAdDidClose:(nonnull MATRewardedVideoAd *)rewardedVideoAd {
    [self.iSDelegate adDidClose];
}

- (void)rewardedVideoAdReward:(nonnull MATRewardedVideoAd *)rewardedVideoAd {
    [self.iSDelegate adRewarded];
}

- (void)rewardedVideoAdStarted:(nonnull MATRewardedVideoAd *)rewardedVideoAd {
    [self.iSDelegate adDidStart];
}

- (void)rewardedVideoAdWillClose:(nonnull MATRewardedVideoAd *)rewardedVideoAd {
    
}

- (void)rewardedVideoAdWillLogImpression:(nonnull MATRewardedVideoAd *)rewardedVideoAd {
    [self.iSDelegate adDidOpen];
    [self.iSDelegate adDidShowSucceed];
    [MaticooMediationTrackManager trackMediationAdImp:rewardedVideoAd.placementID adType:REWARDEDVIDEO];
}

@end
