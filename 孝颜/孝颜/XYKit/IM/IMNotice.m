//
//  IMNotice.m
//  孝颜
//
//  Created by benjamin on 2017/8/14.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "IMNotice.h"
#import "UserDefault.h"
#import "SoundTool.h"
#import "ChatUser.h"

@implementation IMNotice

+(BOOL)isAppActived
{
    return [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
}

+(BOOL)canSound
{
    return ![UserDefault getBool:@"SoundClosed"];
}

+(BOOL)canVibrate
{
    return ![UserDefault getBool:@"VibrateClosed"];
}

+(BOOL)canMessage
{
    return ![UserDefault getBool:@"NoticeMessageClosed"];
}

+(BOOL)canMessageDescript
{
    return ![UserDefault getBool:@"NoticeMessageDescriptClosed"];
}

+(void)setCanSound:(BOOL)value
{
    [UserDefault setBool:@"SoundClosed" value:value];
}

+(void)setCanVibrate:(BOOL)value
{
    [UserDefault setBool:@"VibrateClosed" value:value];
}

//+(void)setCanMessage:(BOOL)value
//{
//    [UserDefault setBool:@"NoticeMessageClosed" value:value];
//    if(value == TRUE){
//        [[EMClient sharedClient] getPushNotificationOptionsFromServerWithCompletion:^(EMPushOptions *aOptions, EMError *aError) {
//            if(!aError){
//                aOptions.noDisturbingStartH = 0;
//                aOptions.noDisturbingEndH = 24;
//                aOptions.noDisturbStatus = EMPushNoDisturbStatusDay;
//                [[EMClient sharedClient] updatePushNotificationOptionsToServerWithCompletion:^(EMError *aError) {
//                    if(aError){
//                        
//                    }
//                }];
//            }
//        }];
//        
//    } else {
//        [[EMClient sharedClient] getPushNotificationOptionsFromServerWithCompletion:^(EMPushOptions *aOptions, EMError *aError) {
//            if(!aError){
//                aOptions.noDisturbingStartH = -1;
//                aOptions.noDisturbingEndH = -1;
//                aOptions.noDisturbStatus = EMPushNoDisturbStatusClose;
//                [[EMClient sharedClient] updatePushNotificationOptionsToServerWithCompletion:^(EMError *aError) {
//                    if(aError){
//                        
//                    }
//                }];
//            }
//        }];
//    }
//}
//
//+(void)setCanMessageDescript:(BOOL)value
//{
//    [UserDefault setBool:@"NoticeMessageDescriptClosed" value:value];
//    if(value == TRUE){
//        [[EMClient sharedClient] getPushNotificationOptionsFromServerWithCompletion:^(EMPushOptions *aOptions, EMError *aError) {
//            if(!aError){
//                aOptions.displayStyle = EMPushDisplayStyleSimpleBanner;
//                [[EMClient sharedClient] updatePushNotificationOptionsToServerWithCompletion:^(EMError *aError) {
//                    if(aError){
//                        
//                    }
//                }];
//            }
//        }];
//        
//    } else {
//        [[EMClient sharedClient] getPushNotificationOptionsFromServerWithCompletion:^(EMPushOptions *aOptions, EMError *aError) {
//            if(!aError){
//                aOptions.displayStyle = EMPushDisplayStyleMessageSummary;
//                [[EMClient sharedClient] updatePushNotificationOptionsToServerWithCompletion:^(EMError *aError) {
//                    if(aError){
//                        
//                    }
//                }];
//            }
//        }];
//    }
//}
+(void)sound
{
    if([self isAppActived])
        return;
    
    BOOL isSoundClose = [UserDefault getBool:@"SoundClosed"];
    
    if(isSoundClose)
        return;
    
    SoundTool *sound = [[SoundTool alloc]initForPlayingSoundEffectWith:@"message.wav"];
    [sound play];
}

+(void)vibrate
{
    BOOL isVibrateClose = [UserDefault getBool:@"VibrateClosed"];
    
    if(isVibrateClose)
        return;
    
    SoundTool *vibrate = [[SoundTool alloc]initForPlayingVibrate];
    [vibrate play];
}

+(void)pushContent:(NSString *)content badgeNumber:(int)badgeNumber
{
    if([self isAppActived])
        return;
    
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    if (notification) {
        
        NSDate *now=[NSDate new];
        notification.fireDate=[now dateByAddingTimeInterval:0];//0秒后通知
        notification.repeatInterval=0;//循环次数，kCFCalendarUnitWeekday一周一次
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber = badgeNumber; //应用的红色数字
        notification.soundName= UILocalNotificationDefaultSoundName;//声音，可以换成alarm.soundName = @"myMusic.caf"
        notification.alertBody = content;
        
        notification.alertAction = Localized(@"open");  //提示框按钮
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    
}

//+(void)pushMessage:(EMMessage *)message badgeNumber:(int)badgeNumber
//{
//    if([self isAppActived])
//        return;
//    
//    NSString *content = [[IMCore instance] getMessageDigest:message];
//    
//    [ChatUser getByChatId:message.from completion:^(ChatUser *aUser) {
//        if(aUser != nil){
//            [self pushContent:[NSString stringWithFormat:@"%@: %@",aUser.name, content] badgeNumber:badgeNumber];
//        } else {
//            [self pushContent:content badgeNumber:badgeNumber];
//        }
//    }];
//}
@end
