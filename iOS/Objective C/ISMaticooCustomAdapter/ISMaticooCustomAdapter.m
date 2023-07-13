//
//  ISMaticooCustomAdapter.m
//  IronSourceDemoApp
//
//  Created by root on 2023/7/13.
//  Copyright © 2023 supersonic. All rights reserved.
//

#import "ISMaticooCustomAdapter.h"
#import <MaticooSDK/MaticooAds.h>

@implementation ISMaticooCustomAdapter

- (void)init:(ISAdData *)adData delegate:(id<ISNetworkInitializationDelegate>)delegate {
    NSString* appKey = [adData getString:@"app_key"];
    if (appKey == nil){
        [delegate onInitDidFailWithErrorCode:ISAdapterErrorMissingParams errorMessage:@"zMaticoo Adapter Error: app key is empty"];
    }
    [[MaticooAds shareSDK] initSDK:appKey onSuccess:^() {
            NSLog(@"Init Success");
            [delegate onInitDidSucceed];
        } onError:^(NSError* error) {
            NSLog(@"Init Failed %@", error.localizedDescription);
            [delegate onInitDidFailWithErrorCode:ISAdapterErrorMissingParams errorMessage:error.localizedDescription];
    }];
 }

- (NSString *) networkSDKVersion {
   return @"1.2.1";
}

- (NSString *) adapterVersion {
    return @"1.0.0";
}

@end
