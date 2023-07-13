//
//  ISMaticooCustomRewardedVideo.m
//  IronSourceDemoApp
//
//  Created by root on 2023/7/13.
//  Copyright © 2023 supersonic. All rights reserved.
//

#import "ISMaticooCustomRewardedVideo.h"
#import <MaticooSDK/MATRewardedVideoAd.h>

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
    self.rewardedVideo = [[MATRewardedVideoAd alloc] initWithPlacementID:placementId];
    self.rewardedVideo.delegate = self;
    [self.rewardedVideo loadAd];
    self.iSDelegate = delegate;
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
}

- (void)rewardedVideoAdDidLoad:(MATRewardedVideoAd *)rewardedVideoAd{
    [self.iSDelegate adDidLoad];
}

- (void)rewardedVideoAd:(nonnull MATRewardedVideoAd *)rewardedVideoAd didFailWithError:(nonnull NSError *)error {
    [self.iSDelegate adDidFailToLoadWithErrorType:ISAdapterErrorTypeInternal errorCode:2 errorMessage:error.localizedDescription];
}

- (void)rewardedVideoAd:(nonnull MATRewardedVideoAd *)rewardedVideoAd displayFailWithError:(nonnull NSError *)error {
    [self.iSDelegate adDidFailToShowWithErrorCode:1 errorMessage:error.localizedDescription];
}

- (void)rewardedVideoAdCompleted:(nonnull MATRewardedVideoAd *)rewardedVideoAd {
    [self.iSDelegate adDidEnd];
}

- (void)rewardedVideoAdDidClick:(nonnull MATRewardedVideoAd *)rewardedVideoAd {
    [self.iSDelegate adDidClick];
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
}

@end
