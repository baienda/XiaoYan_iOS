//
//  IMNotice.h
//  孝颜
//
//  Created by benjamin on 2017/8/14.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMNotice : NSObject

+(BOOL)isAppActived;

+(BOOL)canSound;
+(BOOL)canVibrate;

+(void)setCanVibrate:(BOOL)value;
+(void)setCanSound:(BOOL)value;

+(void)sound;
+(void)vibrate;
//+(void)pushMessage:(EMMessage *)message badgeNumber:(int)badgeNumber;
+(void)pushContent:(NSString *)content badgeNumber:(int)badgeNumber;

+(BOOL)canMessage;
+(BOOL)canMessageDescript;

+(void)setCanMessage:(BOOL)value;
+(void)setCanMessageDescript:(BOOL)value;

@end
