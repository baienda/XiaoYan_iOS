//
//  NSDate+time.m
//  shangshaban
//
//  Created by Mr.Li_YLTX on 16/5/4.
//  Copyright © 2016年 yiliantianxia. All rights reserved.
//

#import "NSDate+time.h"

@implementation NSDate(time)

+ (NSString *)returnTimeStringWithTimeString:(NSString *)timeString outputFormat:(NSString *)outputFormat inputFormat:(NSString *)inputFormat
{
    //1.将时间字符串转为NSDate对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = inputFormat;
    //使字符串能够在任何语言环境下解析
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [fmt dateFromString:timeString];
    //MyLog(@"%@", date);
    
    fmt.dateFormat = outputFormat;
    return [fmt stringFromDate:date];
}

@end
