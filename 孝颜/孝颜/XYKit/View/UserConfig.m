//
//  UserConfig.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "UserConfig.h"
#import "UserDefault.h"

@implementation UserConfig

int uid;
int chatId;
int gender;
int notif;
NSString *nickname;
NSString *avatar;
BOOL hasPassword;
BOOL hasHideLocation;
BOOL hasFace;
NSString *chat_username;
NSString *chat_password;

NSString *token_u;
NSString *token_s;

BOOL canPostMessage;
BOOL canPostPhoto;
BOOL canLogin;
BOOL canSayHi;
BOOL canPostComment;
BOOL canPostNote;
BOOL isLock;

NSString *lat;
NSString *lng;
NSString *address;
NSString *simpAddress;

int star;

int canTalk;

BOOL faceCheck;

NSString *lastLocationUpdataTime;


+ (void)loadConfig
{
    uid = [UserDefault getInt:@"user_uid"];
    chatId = [UserDefault getInt:@"chat_id"];
    gender = [UserDefault getInt:@"user_gender"];
    notif = [UserDefault getInt:@"user_notif"];
    nickname = [UserDefault getString:@"user_nickname"];
    avatar = [UserDefault getString:@"user_avatar"];
    hasPassword = [UserDefault getBool:@"user_hasPwd"];
    hasHideLocation = [UserDefault getBool:@"uers_hasHideLocation"];
    hasFace = [UserDefault getBool:@"uers_hasFace"];
    chat_username = [UserDefault getString:@"chat_username"];
    chat_password = [UserDefault getString:@"chat_password"];
    token_u = [UserDefault getString:@"token_u"];
    token_s = [UserDefault getString:@"token_s"];
    isLock = [UserDefault getBool:@"user_isLock"];
    
    canPostNote = true;
    canPostMessage = true;
    canPostComment = true;
    canPostPhoto = true;
    canSayHi = true;
    canLogin = true;
    
    lat = [UserDefault getString:@"user_lat"];
    lng = [UserDefault getString:@"user_lng"];
    address = [UserDefault getString:@"user_address"];
    simpAddress = [UserDefault getString:@"user_simpAddress"];
    
    star = [UserDefault getInt:@"user_star"];
    canTalk = [UserDefault getInt:@"user_canTalk"];
    faceCheck = [UserDefault getBool:@"user_faceCheck"];
    
    lastLocationUpdataTime = [UserDefault getString:@"user_locationUpdataTime"];
}

+ (void)clearConfig
{
    [UserDefault setInt:@"user_uid" value:0];
    [UserDefault setInt:@"chat_id" value:0];
    [UserDefault setInt:@"user_gender" value:0];
    [UserDefault setString:@"user_notif" value:@"0"];
    [UserDefault setString:@"user_nickname" value:@""];
    [UserDefault setString:@"user_avatar" value:@""];
    [UserDefault setBool:@"user_hasPwd" value:FALSE];
    [UserDefault setBool:@"uers_hasHideLocation" value:FALSE];
    [UserDefault setBool:@"uers_hasFace" value:0];
    [UserDefault setString:@"chat_username" value:@""];
    [UserDefault setString:@"chat_password" value:@""];
    [UserDefault setString:@"token_u" value:@""];
    [UserDefault setString:@"token_s" value:@""];
    [UserDefault setString:@"user_lat" value:@""];
    [UserDefault setString:@"user_lng" value:@""];
    [UserDefault setString:@"user_address" value:@""];
    [UserDefault setString:@"user_simpAddress" value:@""];
    [UserDefault setBool:@"user_isLock" value:0];
    [UserDefault setInt:@"user_star" value:0];
    [UserDefault setInt:@"chatUnreadNum" value:0];
    [UserDefault setInt:@"user_canTalk" value:0];
    [UserDefault setBool:@"user_faceCheck" value:NO];
    [UserDefault setString:@"user_locationUpdataTime" value:@""];
    
#pragma mark - 清空本地筛选缓存
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"localGenderState"];
    [[NSUserDefaults standardUserDefaults] setObject:@"18" forKey:@"localSliderMinAge"];
    [[NSUserDefaults standardUserDefaults] setObject:@"59" forKey:@"localSliderMaxAge"];
    [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:@"sayHiCount"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (BOOL)isLogined
{
    return uid > 0;
}

+ (BOOL)isActivied
{
    return avatar.length > 0;
}

+ (int)getUid
{
    return uid;
}

+ (void)setUid:(int)_uid
{
    [UserDefault setInt:@"user_uid" value:_uid];
    uid = _uid;
}
+ (int)getChatId
{
    return chatId;
}

+ (void)setChatId:(int)_chatId
{
    [UserDefault setInt:@"chat_id" value:_chatId];
    chatId = _chatId;
}

+ (int)getGender
{
    return gender;
}

+ (void)setGender:(int)_gender
{
    [UserDefault setInt:@"user_gender" value:_gender];
    gender = _gender;
}


+ (int)getNotif
{
    return notif;
}

+ (void)setNotif:(int)_notif
{
    [UserDefault setInt:@"user_notif_count" value:_notif];
    notif = _notif;
}

+ (BOOL)getHideLocation {
    
    return hasHideLocation;
}
+ (void)setHideLocation:(BOOL)_hasHideLocation {
    
    [UserDefault setBool:@"uers_hasHideLocation" value:_hasHideLocation];
    hasHideLocation = _hasHideLocation;
}
+ (BOOL)getHasFace {
    
    return hasFace;
}
+ (void)setHasFace:(BOOL)_haseFace {
    
    [UserDefault setBool:@"uers_hasFace" value:_haseFace];
    hasFace = _haseFace;
}
+ (NSString *)getNickname
{
    return nickname ? nickname : @"";
}

+ (void)setNickname:(NSString *)_nickname
{
    [UserDefault setString:@"user_nickname" value:_nickname];
    nickname = _nickname;
}

+ (NSString *)getAvatar
{
    return avatar ? avatar : @"";
}

+ (void)setAvatar:(NSString *)_avatar
{
    [UserDefault setString:@"user_avatar" value:_avatar];
    avatar = _avatar;
}

+ (NSString *)getChatName
{
    return chat_username;
}

+ (void)setChatName:(NSString *)_chatName
{
    [UserDefault setString:@"chat_username" value:_chatName];
    chat_username = _chatName;
}

+ (NSString *)getChatPassword
{
    return chat_password;
}

+ (void)setChatPassword:(NSString *)_chatPassword
{
    [UserDefault setString:@"chat_password" value:_chatPassword];
    chat_password = _chatPassword;
}

+ (BOOL)getHasPassword
{
    return hasPassword;
}

+ (void)setHasPassword:(BOOL)_hasPassword
{
    [UserDefault setBool:@"user_hasPwd" value:_hasPassword];
    hasPassword = _hasPassword;
}
+ (BOOL)getIsLock {
    
    return isLock;
}
+ (void)setIsLock:(BOOL)_isLock {
    
    [UserDefault setBool:@"user_isLock" value:_isLock];
    isLock= _isLock;
}

+ (NSString *)getTokenU
{
    return token_u;
}

+ (void)setTokenU:(NSString *)_token_u
{
    [UserDefault setString:@"token_u" value:_token_u];
    token_u = _token_u;
}

+ (NSString *)getTokenS
{
    return token_s;
}

+ (void)setTokenS:(NSString *)_token_s
{
    [UserDefault setString:@"token_s" value:_token_s];
    token_s = _token_s;
}


+ (void)setCanPostMessage:(BOOL)value
{
    canPostMessage = value;
}
+ (void)setCanPostPhoto:(BOOL)value
{
    canPostPhoto = value;
}
+ (void)setCanLogin:(BOOL)value
{
    canLogin = value;
}
+ (void)setCanSayHi:(BOOL)value
{
    canSayHi = value;
}
+ (void)setCanPostComment:(BOOL)value
{
    canPostComment = value;
}
+ (void)setCanPostNote:(BOOL)value
{
    canPostNote = value;
}

+ (BOOL)getCanPostMessage
{
    return canPostMessage;
}
+ (BOOL)getCanPostPhoto
{
    return canPostPhoto;
}
+ (BOOL)getCanLogin
{
    return canLogin;
}
+ (BOOL)getCanSayHi
{
    return canSayHi;
}
+ (BOOL)getCanPostComment
{
    return canPostComment;
}
+ (BOOL)getCanPostNote
{
    return canPostNote;
}

+ (void)setLocationLat:(NSString *)_lat
{
    [UserDefault setString:@"user_lat" value:_lat];
    lat = _lat;
}

+ (NSString *)getLocationLat
{
    return lat;
}

+ (void)setLocationLng:(NSString *)_lng
{
    [UserDefault setString:@"user_lng" value:_lng];
    lng = _lng;
}

+ (NSString *)getLocationLng
{
    return lng;
}

+ (void)setLocationAddress:(NSString *)_address
{
    [UserDefault setString:@"user_address" value:_address];
    address = _address;
}

+ (NSString *)getLocationAddress
{
    return address;
}

+ (void)setLocationSimpAddress:(NSString *)_address
{
    [UserDefault setString:@"user_SimpAddress" value:_address];
    simpAddress = _address;
}

+ (NSString *)getLocationSimpAddress
{
    return simpAddress;
}

+ (void)setLastLocationUpdataTime:(NSString *)time
{
    [UserDefault setString:@"user_locationUpdataTime" value:time];
    lastLocationUpdataTime = time;
}

+ (NSString *)getLastLocationUpdataTime
{
    return lastLocationUpdataTime;
}

+ (BOOL)isShakeOpen
{
    return YES;
}

+ (int)getStar
{
    return star;
}
+ (void)setStar:(int)value
{
    [UserDefault setInt:@"user_star" value:value];
    star = value;
}

+ (int)getCanTalk
{
    return canTalk;
}
+ (void)setCanTalk:(int)value
{
    [UserDefault setInt:@"user_canTalk" value:value];
    canTalk = value;
}

+ (BOOL)getFaceCheck
{
    return faceCheck;
}
+ (void)setFaceCheck:(BOOL)value
{
    [UserDefault setBool:@"user_faceCheck" value:value];
    faceCheck = value;
}

+ (BOOL)isCompleted
{
    return [self getAvatar].length > 0 && [self getNickname].length > 0;
}

@end
