//
//  NetworkManager.h
//  ApplinsSDK
//
//  Created by Mirinda on 16/5/30.
//  Copyright © 2016年 Mirinda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MaticooMediationNetwork : NSObject <NSURLSessionDelegate>
/**
 @return self
 */
+ (instancetype)manager;

/**
 Post请求

 @param path
 @param params
 @param complete
 @return
 */
+ (id)POST:(NSString *)path parameters:(NSDictionary *)params postCiphertext:(BOOL)isCiphertext completeHandle:(void (^)(id responseObj, NSError* error))complete;

+ (id)POST:(NSString *)path parameters:(NSDictionary *)params completeHandle:(void (^)(id responseObj, NSError* error))complete;
/**
 @param fileURL
 @param image
 */
+(void)getImageFromURL:(NSString *)fileURL img:(void(^)(UIImage *ig))image;
@end
