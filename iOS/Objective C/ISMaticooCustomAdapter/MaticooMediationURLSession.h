//
//  URLSessionNet.h
//  ApplinsSDK
//
//  Created by Mirinda on 16/5/30.
//  Copyright © 2016年 Mirinda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaticooMediationURLSession : NSObject <NSURLSessionDelegate>

+(instancetype)session;

/**
 @param url
 @param isJson
 @param complete
 @return session
 */
- (NSURLSessionDataTask*)GET:(NSURL *)url isRetJson:(BOOL)isJson completeHandler:(void(^)(id responseObj, NSError *error))complete;

/**
 @param url
 @param complete
 @return session
 */
- (NSURLSessionDataTask*)POST:(NSMutableURLRequest *)url completeHandler:(void(^)(id responseObj, NSError *error))complete;

@end
                  
