//
//  MATTrackManager.m
//  MaticooSDK
//
//  Created by root on 2023/5/4.
//

#import "MaticooMediationTrackManager.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "MaticooMediationNetwork.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/ASIdentifierManager.h>

#define TIMESTAMP_MS [[NSDate date] timeIntervalSince1970] * 1000
static NSString *logURL = @"";
static NSString *idfa = @"";

@implementation MaticooMediationTrackManager

+(NSString *) buildLogUrl{
    Class requestClass = NSClassFromString(@"MATRequestParameters");
    if(requestClass && [logURL isEqualToString:@""]){
        logURL = ((NSString* (*)(id, SEL))objc_msgSend)((id)requestClass, @selector(buildLogUrl));
    }
    return logURL;
}

+(NSString*) getIDFA{
    if (@available(iOS 14, *)) {
        // iOS14及以上版本需要先请求权限
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            // 获取到权限后，依然使用老方法获取idfa
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
            }
        }];
    } else {
        // iOS14以下版本依然使用老方法
        // 判断在设置-隐私里用户是否打开了广告跟踪
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
        }
    }
    return idfa;
}

+(NSString*) getBundle{
    NSString *bundle = NSBundle.mainBundle.bundleIdentifier;
    if (bundle != nil)
        return bundle;
    return @"";
}

+(NSString*) getShortBundleVersion{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *shortVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    return shortVersion;
}

+ (void)trackMediationInitSuccess{
    Class MATTrackManagerClass = NSClassFromString(@"MATTrackManager");
    SEL trackSelector = NSSelectorFromString(@"trackMediationInitSuccess");
    if ([MATTrackManagerClass respondsToSelector:trackSelector]) {
        ((void (*)(Class, SEL))objc_msgSend)(MATTrackManagerClass, trackSelector);
    }
}

+ (void)trackMediationInitFailed:(NSError*)error{
    Class MATTrackManagerClass = NSClassFromString(@"MATTrackManager");
    SEL trackSelector = NSSelectorFromString(@"trackMediationInitFailed:");
    if ([MATTrackManagerClass respondsToSelector:trackSelector]) {
        ((void (*)(Class, SEL, NSString*))objc_msgSend)(MATTrackManagerClass, trackSelector, error.description);
    }
}

+ (void)trackMediationAdRequest:(NSString*)pid adType:(NSInteger)adtype isAutoRefresh:(BOOL)isAuto{
    Class MATTrackManagerClass = NSClassFromString(@"MATTrackManager");
    SEL trackSelector = NSSelectorFromString(@"trackMediationAdRequest:adType:rid:isAutoRefresh:");
    if ([MATTrackManagerClass respondsToSelector:trackSelector]) {
        NSString *rid = @"";
        ((void (*)(Class, SEL, NSString*, NSInteger, NSString*, NSInteger))objc_msgSend)(MATTrackManagerClass, trackSelector, pid, adtype, rid, isAuto);
    }
}

+ (void)trackMediationAdRequestFilled:(NSString*)pid adType:(NSInteger)adtype{
    Class matTrackManagerClass = NSClassFromString(@"MATTrackManager");
    SEL selector = @selector(trackMediationAdRequestFilled:adType:);
    if ([matTrackManagerClass respondsToSelector:selector]) {
        ((void (*)(Class, SEL, NSString*, NSInteger))objc_msgSend)(matTrackManagerClass, selector, pid, adtype);
    }
}

+ (void)trackMediationAdRequestFailed:(NSString*)pid adType:(NSInteger)adtype msg:(NSString*)msg{
    Class matTrackManagerClass = NSClassFromString(@"MATTrackManager");
    SEL selector = @selector(trackMediationAdRequestFailed:adType:msg:);
    if ([matTrackManagerClass respondsToSelector:selector]) {
        ((void (*)(Class, SEL, NSString*, NSInteger, NSString*))objc_msgSend)(matTrackManagerClass, selector, pid, adtype, msg);
    }
}

+ (void)trackMediationAdShow:(NSString*)pid adType:(NSInteger)adtype{
    Class matTrackManagerClass = NSClassFromString(@"MATTrackManager");
    SEL selector = @selector(trackMediationAdShow:adType:);
    if ([matTrackManagerClass respondsToSelector:selector]) {
        ((void (*)(Class, SEL, NSString*, NSInteger))objc_msgSend)(matTrackManagerClass, selector, pid, adtype);
    }
}

+ (void)trackMediationAdImp:(NSString*)pid adType:(NSInteger)adtype{
    Class matTrackManagerClass = NSClassFromString(@"MATTrackManager");
    SEL selector = @selector(trackMediationAdImp:adType:);
    if ([matTrackManagerClass respondsToSelector:selector]) {
        ((void (*)(Class, SEL, NSString*, NSInteger))objc_msgSend)(matTrackManagerClass, selector, pid, adtype);
    }
}

+ (void)trackMediationAdImpFailed:(NSString*)pid adType:(NSInteger)adtype msg:(NSString*)msg{
    Class matTrackManagerClass = NSClassFromString(@"MATTrackManager");
    SEL selector = @selector(trackMediationAdImpFailed:adType:msg:);
    if ([matTrackManagerClass respondsToSelector:selector]) {
        ((void (*)(Class, SEL, NSString*, NSInteger, NSString*))objc_msgSend)(matTrackManagerClass, selector, pid, adtype, msg);
    }
}

+ (void)trackMediationAdClick:(NSString*)pid adType:(NSInteger)adtype{
    Class matTrackManagerClass = NSClassFromString(@"MATTrackManager");
    SEL selector = @selector(trackMediationAdClick:adType:);
    if ([matTrackManagerClass respondsToSelector:selector]) {
        ((void (*)(Class, SEL, NSString*, NSInteger))objc_msgSend)(matTrackManagerClass, selector, pid, adtype);
    }
}

@end
