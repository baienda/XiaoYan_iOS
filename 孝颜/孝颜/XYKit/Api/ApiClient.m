//
//  ApiClient.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "ApiClient.h"
#import "HttpClient.h"
#import "ApiParams.h"
#import "UserConfig.h"

@implementation ApiClient

+ (void)doSignin:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParam:(AuthParams *)params
{
    [HttpClient post:@"passport/signin" params:[params buildSigninParams] success:^(id JSON, NSString *baseUrl) {
        [UserConfig setTokenU:JSON[@"data"][@"u"]];
        [UserConfig setTokenS:JSON[@"data"][@"s"]];
        if (success == nil) return ;
        success(JSON);
    } failure:^(id error, NSString *baseUrl) {
        if (failure == nil) return ;
        failure(error);
    }];
}

+ (void)doSigninByFB:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParam:(AuthParams *)params
{
    [HttpClient post:@"passport/signin" params:[params buildFacebookParams] success:^(id JSON, NSString *baseUrl) {
        [UserConfig setTokenU:JSON[@"data"][@"u"]];
        [UserConfig setTokenS:JSON[@"data"][@"s"]];
        if (success == nil) return ;
        success(JSON);
    } failure:^(id error, NSString *baseUrl) {
        if (failure == nil) return ;
        failure(error);
    }];
}

+ (void)doSms:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParam:(AuthParams *)params
{
    [HttpClient post:@"passport/sendsms" params:[params buildSMSParams] success:^(id JSON, NSString *baseUrl) {
        if (success == nil) return ;
        success(JSON);
    } failure:^(id error, NSString *baseUrl) {
        if (failure == nil) return ;
        failure(error);
    }];
}

+ (void)doUpdateLocation:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParam:(LocationParams *)params
{
    [HttpClient post:@"location/update" params:[params buildParams] success:^(id JSON, NSString *baseUrl) {
        if (success == nil) return ;
        success(JSON);
    } failure:^(id error, NSString *baseUrl) {
        if (failure == nil) return ;
        failure(error);
    }];
}

+ (void)getNearbyList:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParam:(NearbyListParams *)params
{
    [HttpClient post:@"location/nearby" params:[params buildParams] success:^(id JSON, NSString *baseUrl) {
        if (success == nil) return ;
        success(JSON);
    } failure:^(id error, NSString *baseUrl) {
        if (failure == nil) return ;
        failure(error);
    }];
}

+ (void)getGeoIp:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure
{
    [HttpClient postAllBaseUrl:@"help/geoip" params:nil success:^(id JSON, NSString *baseUrl) {
        if (success == nil) return ;
        success(JSON);
    } failure:^(id error, NSString *baseUrl) {
        if (failure == nil) return ;
        failure(error);
    }];
}

+ (void)getAccountInfo:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure
{
    [HttpClient post:@"account/index" params:nil success:^(id JSON, NSString *baseUrl) {
        if (success == nil) return ;
        success(JSON);
    } failure:^(id error, NSString *baseUrl) {
        if (failure == nil) return ;
        failure(error);
    }];
}

+ (void)doChatUser:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure
{
    [HttpClient post:@"user/to_chatuser" params:nil success:^(id JSON, NSString *baseUrl) {
        if (success == nil) return ;
        success(JSON);
    } failure:^(id error, NSString *baseUrl) {
        if (failure == nil) return ;
        failure(error);
    }];
}

+ (void)updateAvatar:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParam:(AvatarParams *)params image:(UIImage *)image
{
    [HttpClient uploadImage:image path:@"user/avatar" params:[params buildParams] progress:nil success:^(id JSON, NSString *baseUrl) {
        if (success == nil) return ;
        success(JSON);
    } failure:^(id error, NSString *baseUrl) {
        if (failure == nil) return ;
        failure(error);
    }];
}

+ (void)updatePhoto:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParam:(PhotoParams *)params image:(UIImage *)image
{
    [HttpClient uploadImage:image path:@"photo/upload" params:[params buildParams] progress:nil success:^(id JSON, NSString *baseUrl) {
        if (success == nil) return ;
        success(JSON);
    } failure:^(id error, NSString *baseUrl) {
        if (failure == nil) return ;
        failure(error);
    }];
}
+ (void)updataInfoSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParam:(ProfileParams *)params
{
    [HttpClient post:@"profile/update" params:[params buildParams] success:^(id JSON, NSString *baseUrl) {
        if (success == nil) return ;
        success(JSON);
    } failure:^(id error, NSString *baseUrl) {
        if (failure == nil) return ;
        failure(error);
    }];
}
+ (void)setPasswordSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParam:(PasswordParams *)params
{
    [HttpClient post:@"account/repasswd" params:[params buildParams] success:^(id JSON, NSString *baseUrl) {
        if (success == nil) return ;
        success(JSON);
    } failure:^(id error, NSString *baseUrl) {
        if (failure == nil) return ;
        failure(error);
    }];
}
+ (void)getProfileInfoSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParams:(OnlyUidParams *)params;
{
    [HttpClient post:@"profile/info" params:[params buildParams] success:^(id JSON, NSString *baseUrl) {
        if (success == nil) return ;
        success(JSON);
    } failure:^(id error, NSString *baseUrl) {
        if (failure == nil) return ;
        failure(error);
    }];
}
+ (void)ProfileMiniSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParams:(OnlyUidParams *)params;
{
    [HttpClient post:@"profile/infomini" params:[params buildParams] success:^(id JSON, NSString *baseUrl) {
        if (success == nil) return ;
        success(JSON);
    } failure:^(id error, NSString *baseUrl) {
        if (failure == nil) return ;
        failure(error);
    }];
}
+ (void)reportUserSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParams:(ReportParams *)params
{
    [HttpClient post:@"/help/report" params:[params buildParams]success:^(id JSON, NSString *baseUrl) {
        if (success == nil) return ;
        success(JSON);
    } failure:^(id error, NSString *baseUrl) {
        if (failure == nil) return ;
        failure(error);
    }];
}
+ (void)balckUserSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParams:(OnlyUidParams *)params
{
    [HttpClient post:@"/account/black_user_add" params:[params buildParams] success:^(id JSON, NSString *baseUrl) {
        if (success == nil) return ;
        success(JSON);
    } failure:^(id error, NSString *baseUrl) {
        if (failure == nil) return ;
        failure(error);
    }];
}
+ (void)upLoadProfileLikeSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParams:(ProfileLike *)params {
    
    [HttpClient post:@"/profile/like" params:[params buildParams] success:^(id JSON, NSString *baseUrl) {
        if (success == nil) return ;
        success(JSON);
    } failure:^(id error, NSString *baseUrl) {
        if (failure == nil) return ;
        failure(error);
    }];
}
+ (void)getFriendListSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParams:(OnlyUidParams *)params
{
    [HttpClient post:@"friend/list" params:[params buildParams] success:^(id JSON, NSString *baseUrl) {
        if (success == nil) return ;
        success(JSON);
    } failure:^(id error, NSString *baseUrl) {
        if (failure == nil) return ;
        failure(error);
    }];
}
+ (void)getMomentsListSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParams:(OffsetParams *)params;
{
    [HttpClient post:@"/moment/list" params:[params buildParams] success:^(id JSON, NSString *baseUrl) {
        if (success == nil) return ;
        success(JSON);
    } failure:^(id error, NSString *baseUrl) {
        if (failure == nil) return ;
        failure(error);
    }];
}
+ (void)searchUserListSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParams:(SearchResultParams *)params
{
    [HttpClient post:@"/contact/search" params:[params buildParams] success:^(id JSON, NSString *baseUrl) {
        if (success == nil) return ;
        success(JSON);
    } failure:^(id error, NSString *baseUrl) {
        if (failure == nil) return ;
        failure(error);
    }];
}
@end
