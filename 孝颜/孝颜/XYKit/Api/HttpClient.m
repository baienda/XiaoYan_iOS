//
//  HttpClient.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//
#import "HttpClient.h"

#import "Meecha-Swift.h"
#import "UFileAPIUtils.h"
#import "UFileAPI.h"
#import "UserConfig.h"
#import "UserDefault.h"

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

static NSString *tempBaseURL;

@implementation HttpClient

+ (NSArray *)getAllBaseUrl
{
    NSArray *urls = @[@"http://mobile.chatcat.co/", @"http://sg.meecha.net/", @"http://th.meecha.net/"];
    return urls;
}

+ (NSString *)getBaseUrl
{
    //手动指定到测试环境
    if([UserDefault getBool:@"IS_IN_TEST"] == YES){
        return @"http://test.mobile.chatcat.co/";
    }
    
    //开发环境
#ifdef DEBUG
    return @"http://dev.mobile.chatcat.co/";
#else
    if(tempBaseURL != nil && tempBaseURL.length > 0){
        return tempBaseURL;
    }
    
    NSString *defaultURL = [UserDefault getString:@"API_BASE_URL"];
    if(defaultURL != nil && defaultURL.length > 0){
        tempBaseURL = defaultURL;
        return tempBaseURL;
    }
    
    return [self getAllBaseUrl][0];
#endif
}

+ (BOOL)isInTest
{
    return [UserDefault getBool:@"IS_IN_TEST"] == YES;
}

+ (void)setInTest:(BOOL)isTest{
    [UserDefault setBool:@"IS_IN_TEST" value:isTest];
}

+ (NSMutableDictionary *)formatParams:(NSDictionary *)params
{
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    [allParams setObject:timeSp forKey:@"_"];
    if (params) {
        [allParams setDictionary:params];
    }
    return allParams;
}

+ (void)post:(NSString *)path params:(NSDictionary *)params success:(HttpBaseSuccessBlock)success failure:(HttpBaseFailureBlock)failure;
{
    [self post:[self getBaseUrl] path:path params:params success:success failure:failure];
}

//用于检测最快的请求节点
+ (void)postAllBaseUrl:(NSString *)path params:(NSDictionary *)params success:(HttpBaseSuccessBlock)success failure:(HttpBaseFailureBlock)failure;
{
#ifdef DEBUG
    [self post:[self getBaseUrl] path:path params:params success:success failure:failure];
#else
    __block BOOL handled = false;
    
    HttpBaseSuccessBlock allSuccessBlock = ^(id json, NSString *baseURL){
        
        if(handled == YES){
            MyLog(@"%@ is slow.", baseURL);
            return;
        }
        
        handled = YES;
        tempBaseURL = baseURL;
        [UserDefault setString:@"API_BASE_URL" value:baseURL];
        
        if(success != nil){
            success(json, baseURL);
        }
    };
    
    HttpBaseFailureBlock allFailureBlock = ^(id error, NSString *baseURL){
        
        if(handled == YES){
            return;
        }
        
        if(failure != nil){
            failure(error, baseURL);
        }
    };
    
    NSArray *urls = [self getAllBaseUrl];
    for(int i = 0 ; i < urls.count; i++){
        [self post:urls[i] path:path params:params success:allSuccessBlock failure:allFailureBlock];
    }
#endif
}

+ (void)post:(NSString *)baseUrl path:(NSString *)path params:(NSDictionary *)params success:(HttpBaseSuccessBlock)success failure:(HttpBaseFailureBlock)failure;
{
    MyLog(@"Request: %@%@", baseUrl, path);
    [AppDelegateInstance refreshNetworkStatus];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    NSMutableDictionary *allparams = [self formatParams:params];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    
    manager.requestSerializer.timeoutInterval = 60.;
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *ua = [AppDelegateInstance getUA];
    NSString *wifi = @"0";
    if([AppDelegateInstance getNetworkStatus] == 2){
        wifi = @"1";
    }
    NSString *ccDevice = [NSString stringWithFormat:@"%@&wifi=%@", ua, wifi];
    [manager.requestSerializer setValue:ccDevice forHTTPHeaderField:@"X-Cc-Device"];
    
    CCLocation *location = [AppDelegateInstance getLocation];
    NSString *ccLocation = [NSString stringWithFormat:@"longitude=%@&latitude=%@", location.longitude, location.latitude];
    [manager.requestSerializer setValue:ccLocation forHTTPHeaderField:@"X-Cc-Location"];
    
    //取出保存的U和S
    NSString *cookie = [NSString stringWithFormat:@"u=%@; s=%@", [UserConfig getTokenU], [UserConfig getTokenS]];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    
    [manager POST:path parameters:allparams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
        if(success == nil) return;
        if ([responseObject[@"errno"]intValue2] == 0) {
            MyLog(@"Success------------%@", path);
            success(responseObject, baseUrl);
        } else {
            NSString *eventName = [NSString stringWithFormat:@"API_ERROR_%d", [responseObject[@"errno"]intValue2]];
            [CrashlyticsKit logEvent:eventName];
            
            MyLog(@"Error------------%@", path);
            failure(responseObject, baseUrl);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
        
        [CrashlyticsKit recordError:error];
        
        if(failure ==nil)return ;
        NSInteger code = 1;
        NSString *message = @"Network connect fialed";
        if(error != nil)
        {
            MyLog(@"HTTP Error %ld", (long)error.code);
            if(error.code == -1009){
                code = 1;
            } else if(error.code != 401 || error.code != 403){
                code = 500;
            }
            message = error.description;
        }
        
        NSMutableDictionary *errorDict = [NSMutableDictionary dictionary];
        [errorDict setObject:@(code) forKey:@"errno"];
        [errorDict setObject:message forKey:@"message"];
        failure(errorDict, baseUrl);
    }];
    
}


+ (void)uploadImage:(UIImage *)image
               path:(NSString *)path
             params:(NSDictionary *)params
           progress:(HttpBaseProgressBlock)progress
            success:(HttpBaseSuccessBlock)success
            failure:(HttpBaseFailureBlock)failure
{
    MyLog(@"Request: %@", path);
    [AppDelegateInstance refreshNetworkStatus];
    
    //生成随机10位字符串
    char Namedata[10];
    for (int x=0;x< 10; Namedata[x++] = (char)('A' + (arc4random_uniform(26))));
    NSString *key = [[NSString alloc] initWithBytes:Namedata length:10 encoding:NSUTF8StringEncoding];
    
    NSString *imgHeight = [NSString stringWithFormat:@"%f",image.size.height];
    NSString *imgWidth = [NSString stringWithFormat:@"%f",image.size.width];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currentDateStr = [df stringFromDate:[NSDate date]];
    key = [NSString stringWithFormat:@"u_a_%@_%@.jpg",currentDateStr,key];
    
    File *imageFile = [[File alloc] initFromKeys:kUcloudPublicKey privateKey:kUcloudPrivateKey bucket:kUcloudBucket];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.9);
    
    NSString *itMd5 = [UFileAPIUtils calcMD5ForData:imageData];
    NSString *auth = [imageFile calcKeyWithHttpMethod:@"PUT" key:key contentMd5:itMd5 contentType:@"image/jpeg"];
    //NSString *auth = [imageFile calcKey:@"PUT" key:key contentMd5:itMd5 contentType:@"image/jpeg"];
    
    [imageFile.ufileSDK putFile:key authorization:auth option:@{kUFileSDKOptionMD5:itMd5,kUFileSDKOptionFileType:@"image/jpeg"} data:imageData progress:^(NSProgress * _Nonnull progress) {
        
    } success:^(NSDictionary * _Nonnull response) {
        
        NSMutableDictionary *allparams = [self formatParams:params];
        
        [allparams setObject:imgHeight forKey:@"height"];
        [allparams setObject:imgWidth forKey:@"width"];
        [allparams setObject:key forKey:@"filename"];
        
        [self post:path params:allparams success:^(id JSON, NSString* baseURL) {
            if (success == nil) return ;
            success(JSON, baseURL);
        } failure:^(id error, NSString* baseURL) {
            if (failure == nil) return ;
            failure(error, baseURL);
        }];
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
+ (void)uploadUcloudImage:(UIImage *)image
                   params:(NSDictionary *)params
                 progress:(HttpBaseProgressBlock)progress
                  success:(HttpBaseSuccessBlock)success
                  failure:(HttpBaseFailureBlock)failure {
    
    
    [AppDelegateInstance refreshNetworkStatus];
    
    NSString* key = [params objectForKey:@"filename"];
    
    File *imageFile = [[File alloc] initFromKeys:kUcloudPublicKey privateKey:kUcloudPrivateKey bucket:kUcloudBucket];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.9);
    
    NSString *itMd5 = [UFileAPIUtils calcMD5ForData:imageData];
    NSString *auth = [imageFile calcKeyWithHttpMethod:@"PUT" key:key contentMd5:itMd5 contentType:@"image/jpeg"];
    
    [imageFile.ufileSDK putFile:key authorization:auth option:@{kUFileSDKOptionMD5:itMd5,kUFileSDKOptionFileType:@"image/jpeg"} data:imageData progress:^(NSProgress * _Nonnull progress) {
    } success:^(NSDictionary * _Nonnull response) {
        success(response, nil);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
+ (void)uploadUcloudVideo:(NSString *)localVideoPath
                   params:(NSDictionary *)params
                 progress:(HttpBaseProgressBlock)progress
                  success:(HttpBaseSuccessBlock)success
                  failure:(HttpBaseFailureBlock)failure {
    
    [AppDelegateInstance refreshNetworkStatus];
    
    NSString* key = [params objectForKey:@"filename"];
    
    File *imageFile = [[File alloc] initFromKeys:kUcloudPublicKey privateKey:kUcloudPrivateKey bucket:kUcloudBucket];
    
    NSData *videoData = [NSData dataWithContentsOfFile:localVideoPath];
    
    NSString *itMd5 = [UFileAPIUtils calcMD5ForData:videoData];
    NSString *auth = [imageFile calcKeyWithHttpMethod:@"PUT" key:key contentMd5:itMd5 contentType:@"video/mp4"];
    
    [imageFile.ufileSDK putFile:key authorization:auth option:@{kUFileSDKOptionMD5:itMd5,kUFileSDKOptionFileType:@"video/mp4"} data:videoData progress:^(NSProgress * _Nonnull progress) {
    } success:^(NSDictionary * _Nonnull response) {
        success(response, nil);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
@end
