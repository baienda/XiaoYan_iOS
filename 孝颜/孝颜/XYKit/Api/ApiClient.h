//
//  ApiClient.h
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiParams.h"
#import "HttpClient.h"

@interface ApiClient : NSObject
+ (void)doSignin:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParam:(AuthParams *)params;
+ (void)doSigninByFB:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParam:(AuthParams *)params;
+ (void)doUpdateLocation:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParam:(LocationParams *)params;
+ (void)getNearbyList:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParam:(NearbyListParams *)params;
+ (void)getGeoIp:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure;
+ (void)doSms:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParam:(AuthParams *)params;
+ (void)getAccountInfo:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure;
+ (void)doChatUser:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure;
+ (void)updateAvatar:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParam:(AvatarParams *)params image:(UIImage *)image;
+ (void)updatePhoto:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParam:(PhotoParams *)params image:(UIImage *)image;
//更改用户信息
+ (void)updataInfoSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParam:
(ProfileParams *)params;
//设置密码
+ (void)setPasswordSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParam:
(PasswordParams *)params;
+ (void)getProfileInfoSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParams:(OnlyUidParams *)params;
+ (void)ProfileMiniSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParams:(OnlyUidParams *)params;
//举报
+ (void)reportUserSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParams:(ReportParams *)params;
//拉黑
+ (void)balckUserSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParams:(OnlyUidParams *)params;
//profile喜欢
+ (void)upLoadProfileLikeSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParams:(ProfileLike *)params;
//好友列表
+ (void)getFriendListSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParams:(OnlyUidParams *)params;
//好友动态列表
+ (void)getMomentsListSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParams:(OffsetParams *)params;
//用户查询/contact/search
+ (void)searchUserListSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure andParams:(SearchResultParams *)params;

@end
