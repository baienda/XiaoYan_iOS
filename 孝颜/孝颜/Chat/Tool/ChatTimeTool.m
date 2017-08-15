//
//  ChatTimeTool.m
//  shangshaban
//
//  Created by yiliantianxia on 16/3/15.
//  Copyright © 2016年 yiliantianxia. All rights reserved.
//

#import "ChatTimeTool.h"

@implementation ChatTimeTool
+(NSString *)timeStr:(long long)timestamp{
    //currentDate 2016-03-15 16:28:09 +0000
    //msgDate 2016-03-15 10:36:22 +0000
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //获取当前的时间
    NSDate *currentDate = [NSDate date];
    
    // 获取年，月，日
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    NSInteger currentYear = components.year;
    NSInteger currentMonth = components.month;
    NSInteger currentDay = components.day;
    //    MyLog(@"currentYear %ld",components.year);
    //    MyLog(@"currentMonth %ld",components.month);
    //    MyLog(@"currentDay %ld",components.day);
    
    
    //获取消息发送时间
    NSDate *msgDate = [NSDate dateWithTimeIntervalSince1970:timestamp/1000.0];
    // 获取年，月，日
    components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:msgDate];
    CGFloat msgYead = components.year;
    CGFloat msgMonth = components.month;
    CGFloat msgDay = components.day;
    //    MyLog(@"msgYear %ld",components.year);
    //    MyLog(@"msgMonth %ld",components.month);
    //    MyLog(@"msgDay %ld",components.day);
    
    
    //判断:
    /*今天：(HH:mm)
     *昨天: (昨天 HH:mm)
     *昨天以前:（2016-03-15 15:27）
     */
    NSString *returnTime;
    
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    if (currentYear == msgYead && currentMonth == msgMonth && currentDay == msgDay)
    {//今天
        dateFmt.dateFormat = @"HH:mm";
        returnTime = [dateFmt stringFromDate:msgDate];
    }
    else if(currentYear == msgYead && currentMonth == msgMonth && currentDay - 1 == msgDay)
    {//昨天
//        dateFmt.dateFormat = @"HH:mm";
//        returnTime = [NSString stringWithFormat:@"%@ %@", Localized(@"yesterday"),[dateFmt stringFromDate:msgDate]];
        returnTime = [NSString stringWithFormat:@"%@", Localized(@"yesterday")];
    }else
    {//昨天以前
        dateFmt.dateFormat = @"MM/dd/yy";
        returnTime = [dateFmt stringFromDate:msgDate];
        if ([returnTime isEqualToString:@"01/01/70"]) {
            returnTime = Localized(@"just_now");
        }
    }

    return returnTime;
}

@end
