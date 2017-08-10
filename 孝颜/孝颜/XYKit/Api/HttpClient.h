//
//  HttpClient.h
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>


typedef void (^HttpSuccessBlock)(id JSON);
typedef void (^HttpFailureBlock)(id error);
typedef void (^HttpProgressBlock)(float percent);

typedef void (^HttpBaseSuccessBlock)(id JSON, NSString *baseURL);
typedef void (^HttpBaseFailureBlock)(id error, NSString *baseURL);
typedef void (^HttpBaseProgressBlock)(float percent, NSString *baseURL);

@interface HttpClient : NSObject

+ (BOOL)isInTest;
+ (void)setInTest:(BOOL)isTest;

+ (void)postAllBaseUrl:(NSString *)path params:(NSDictionary *)params success:(HttpBaseSuccessBlock)success failure:(HttpBaseFailureBlock)failure;

+ (void)post:(NSString *)path
      params:(NSDictionary *)params
					success:(HttpBaseSuccessBlock)success
					failure:(HttpBaseFailureBlock)failure;

+ (void)uploadImage:(UIImage *)image
               path:(NSString *)path
             params:(NSDictionary *)params
           progress:(HttpBaseProgressBlock)progress
            success:(HttpBaseSuccessBlock)success
            failure:(HttpBaseFailureBlock)failure;
+ (void)uploadUcloudImage:(UIImage *)image
                   params:(NSDictionary *)params
                 progress:(HttpBaseProgressBlock)progress
                  success:(HttpBaseSuccessBlock)success
                  failure:(HttpBaseFailureBlock)failure;
//上传.mp4文件到uclould
+ (void)uploadUcloudVideo:(NSString *)localVideoPath
                   params:(NSDictionary *)params
                 progress:(HttpBaseProgressBlock)progress
                  success:(HttpBaseSuccessBlock)success
                  failure:(HttpBaseFailureBlock)failure;

@end
