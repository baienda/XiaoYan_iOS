//
//  UserConfig.h
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserConfig : NSObject

+ (void)loadConfig;
+ (void)clearConfig;

+ (BOOL)isLogined;
+ (BOOL)isActivied;

+ (int)getUid;
+ (void)setUid:(int)_uid;

+ (int)getChatId;
+ (void)setChatId:(int)_chatId;

+ (int)getGender;
+ (void)setGender:(int)_gender;

+ (int)getNotif;
+ (void)setNotif:(int)_notif;

+ (BOOL)getHideLocation;
+ (void)setHideLocation:(BOOL)_hasHideLocation;

+ (BOOL)getHasFace;
+ (void)setHasFace:(BOOL)_haseFace;

+ (BOOL)getIsLock;
+ (void)setIsLock:(BOOL)_isLock;

+ (NSString *)getNickname;
+ (void)setNickname:(NSString *)_nickname;

+ (NSString *)getAvatar;
+ (void)setAvatar:(NSString *)_avatar;

+ (NSString *)getChatName;
+ (void)setChatName:(NSString *)_chatName;

+ (NSString *)getChatPassword;
+ (void)setChatPassword:(NSString *)_chatPassword;

+ (BOOL)getHasPassword;
+ (void)setHasPassword:(BOOL)_hasPassword;

+ (NSString *)getTokenU;
+ (void)setTokenU:(NSString *)_token_u;

+ (NSString *)getTokenS;
+ (void)setTokenS:(NSString *)_token_s;

+ (void)setCanPostMessage:(BOOL)value;
+ (void)setCanPostPhoto:(BOOL)value;
+ (void)setCanLogin:(BOOL)value;
+ (void)setCanSayHi:(BOOL)value;
+ (void)setCanPostComment:(BOOL)value;
+ (void)setCanPostNote:(BOOL)value;

+ (BOOL)getCanPostMessage;
+ (BOOL)getCanPostPhoto;
+ (BOOL)getCanLogin;
+ (BOOL)getCanSayHi;
+ (BOOL)getCanPostComment;
+ (BOOL)getCanPostNote;

+ (void)setLocationLat:(NSString *)_lat;
+ (NSString *)getLocationLat;

+ (void)setLocationLng:(NSString *)_lng;
+ (NSString *)getLocationLng;

+ (void)setLocationAddress:(NSString *)_address;
+ (NSString *)getLocationAddress;

+ (void)setLocationSimpAddress:(NSString *)_address;
+ (NSString *)getLocationSimpAddress;

+ (void)setLastLocationUpdataTime:(NSString *)time;
+ (NSString *)getLastLocationUpdataTime;

+ (BOOL)isShakeOpen;

+ (int)getStar;
+ (void)setStar:(int)value;

+ (int)getCanTalk;
+ (void)setCanTalk:(int)value;

+ (BOOL)getFaceCheck;
+ (void)setFaceCheck:(BOOL)value;

+ (BOOL)isCompleted;

@end
