//
//  NSString+Array.m
//  shangshaban
//
//  Created by Mr.Li_YLTX on 16/4/28.
//  Copyright © 2016年 yiliantianxia. All rights reserved.
//

#import "NSString+Array.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString(Array)

+ (NSArray *)returnStringArrayWithString:(NSString *)String WithCount:(int)count withSeparateString:(NSString *)separateString
{
    
    NSMutableArray *resultArray = [NSMutableArray array];
    //截掉时间字符串中秒的小数点以及后面6位
    NSString *restStr;
    NSRange restRange;
    NSString *tagStr = String;
    [resultArray removeAllObjects];
    for (int i = 0; ; i++) {
        if (count!=0 && i == count) break;
        NSRange range = [tagStr rangeOfString:separateString];
        if (range.length != 0) { //有&
            long index = range.location;
            restStr = [tagStr substringFromIndex:index];
            if (restStr.length >0) {
                //            MyLog(@"delete:--%@--",deleteStr);
                restRange = [tagStr rangeOfString:restStr];
                //            MyLog(@"deleteRange:--%lu--%lu--",(unsigned long)deleteRange.location, (unsigned long)deleteRange.length);
                if (restRange.length != 0) {
                    NSString *tag = [tagStr stringByReplacingCharactersInRange:restRange withString:@""];
                    if (tag.length >0) {
                        [resultArray addObject:tag];
                    }
                    //去掉最前面的&
                    tagStr = [restStr substringFromIndex:1];
                }
            }
        } else{//无&
            if (tagStr.length>0) {
                [resultArray addObject:tagStr];
            }
            break;
        }
    }
    return resultArray;
}

+ (NSString *)urlValidation:(NSString *)string
{
    NSError *error;

    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                             options:NSRegularExpressionCaseInsensitive
                                               error:&error];

    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];

    for (NSTextCheckingResult *match in arrayOfAllMatches){
            NSString *substringForMatch = [string substringWithRange:match.range];
        
            return substringForMatch;
        }
    return @"NO";
}

+ (NSString *)returnDistanceStringWithDistance:(int)distance
{
    NSString *disStr;
    
//逻辑2
    //if (distance > 1000 || distance == 0) {
        //disStr = [NSString stringWithFormat:@"%.0f",(float)distance/1000.0];
    //}else {
        //disStr = [NSString stringWithFormat:@"%.2f",(float)distance/1000.0];
    //}
    
//逻辑1
    if (distance > 100000) {
        disStr = [NSString stringWithFormat:Localized(@"km_away"),distance/1000];
    } else if (distance > 1000){
        disStr = [NSString stringWithFormat:Localized(@"km_away1"),(float)distance/1000.0];
    }else{
        disStr = [NSString stringWithFormat:Localized(@"km_away_m"),distance];
    }
    //return [NSString stringWithFormat:Localized(@"km_away"), disStr];
    return disStr;
}

//转换时间戳
+ (NSString *)returnNewTime:(NSString *)time
{
    NSTimeInterval _interval = [time doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"MM/dd HH:mm"];

    NSString *newTime = [objDateformat stringFromDate:date];
    
    return newTime;
}
+ (NSString *)returnTimeDetail:(CGFloat)timeStamp {

    NSDate *currentDate = [NSDate date];

    NSTimeInterval currentDateStamp = [currentDate timeIntervalSince1970];
 
    double interval = currentDateStamp - timeStamp;

    if (interval < 60) {//小于一分钟
        return [NSString stringWithFormat:Localized(@"second_ago"),interval];
    } else if (interval >= 60 && interval < 60 * 60) {//小于一小时
    
        return [NSString stringWithFormat:Localized(@"minute_ago"),interval/60];
        
    } else if (interval >= 60 * 60 && interval < 60*60*24) {

        return [NSString stringWithFormat:Localized(@"hour_ago"),interval/(60*60)];
        
    } else {
        return [NSString stringWithFormat:Localized(@"day_ago"),interval/(60*60*24)];
    }
    
}
+ (NSString *)returnNewTimeSecondModo:(CGFloat)timeStamp {
    
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    //将当前时间转化为时间戳
    NSTimeInterval currentDateStamp = [currentDate timeIntervalSince1970];
//    MyLog(@"%lf",currentDateStamp);
    //计算时间间隔，即当前时间减去传入的时间
    double interval = currentDateStamp - timeStamp;
    //获取当前时间的小时单位（24小时制）
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"H"];
    int nowHour = [[formatter stringFromDate:currentDate] intValue];
    //获取当前时间的分钟单位
    NSDateFormatter *minFormatter = [NSDateFormatter new];
    [minFormatter setDateFormat:@"m"];
    int nowMinute = [[minFormatter stringFromDate:currentDate] intValue];
    //今天0点的时间戳
    double todayZeroClock = currentDateStamp - 3600 * nowHour - 60 * nowMinute;
    //时间格式化，为输出做准备
    NSDateFormatter *outputFormat = [NSDateFormatter new];
    [outputFormat setDateFormat:@"M/d/Y"];
    NSDateFormatter *outputFormat2 = [NSDateFormatter new];
    [outputFormat2 setDateFormat:@"H:mm aa"];

    //进行条件判断，满足不同的条件返回不同的结果
    if (interval < 20 * 60) {
        //在20分钟之内
        return Localized(@"just_now");
    } else if (todayZeroClock - timeStamp < 0) {
        //一天内
        return [outputFormat2 stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeStamp]];
    } else if ((todayZeroClock  - timeStamp > 0)&&(todayZeroClock - timeStamp <24* 3600)) {
        
//        MyLog(@"%lf",todayZeroClock);
//        MyLog(@"%lf",timeStamp);
        //已经超过一天（昨天）
        return Localized(@"yesterday");
    } else {
        //已经超过两天以上
        return [outputFormat stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeStamp]];
    }
}
//装换时间戳 距离当前时间多久
+ (NSString *)returnNewTimeCompareCurrentTime:(NSString *)time;
{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    //将当前时间转化为时间戳
    NSTimeInterval currentDateStamp = [currentDate timeIntervalSince1970];
    //    MyLog(@"%lf",currentDateStamp);
    //计算时间间隔，即当前时间减去传入的时间
    double interval = currentDateStamp - [time floatValue];
    
    MyLog(@"%lf",currentDateStamp);
    MyLog(@"%lf",[time floatValue]);
    MyLog(@"%lf",interval);
    
    if (interval < 0) {
        
        interval = 0;
    }
    if (interval < 60) {
        return [NSString stringWithFormat:Localized(@"second_ago"),(NSInteger)interval];
    }else {
        double minute = interval/60;
        if (minute < 60) {
            return [NSString stringWithFormat:Localized(@"minute_ago"),(NSInteger)minute];
        }else {
            double hour = minute/60;
            if (hour < 24) {
                return [NSString stringWithFormat:Localized(@"hour_ago"),(NSInteger)hour];
            }else {
                double day = hour/ 24;
                return [NSString stringWithFormat:Localized(@"day_ago"),(NSInteger)day];
            }
        }
    }
}
//帖子时间
+ (NSString *)returnNewTopicTimeCompareCurrentTime:(NSString *)time;
{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    //将当前时间转化为时间戳
    NSTimeInterval currentDateStamp = [currentDate timeIntervalSince1970];
    //    MyLog(@"%lf",currentDateStamp);
    //计算时间间隔，即当前时间减去传入的时间
    double interval = currentDateStamp - [time floatValue];
    
    MyLog(@"%lf",currentDateStamp);
    MyLog(@"%lf",[time floatValue]);
    MyLog(@"%lf",interval);
    
    if (interval < 0) {
        
        interval = 0;
    }
    
    if (interval < 60) {
        return [NSString stringWithFormat:@"%ld%@",(NSInteger)interval,Localized(@"topic_time_suffix_s")];
    }else {
        double minute = interval/60;
        if (minute < 60) {
            return [NSString stringWithFormat:@"%ld%@",(NSInteger)minute,Localized(@"topic_time_suffix_min")];
        }else {
            double hour = minute/60;
            if (hour < 24) {
                return [NSString stringWithFormat:@"%ld%@",(NSInteger)hour,Localized(@"topic_time_suffix_hr")];
            }else {
                double day = hour/ 24;
                return [NSString stringWithFormat:@"%ld%@",(NSInteger)day,Localized(@"topic_time_suffix_day")];
            }
        }
    }
}

+ (BOOL )isOnLine:(NSString *)time {
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval currentDateStamp = [currentDate timeIntervalSince1970];
    double interval = currentDateStamp - [time floatValue];
    if (interval < 0) {
        interval = 0;
    }
    if (interval < 60 * 6) {
        return YES;
    }else {
        return NO;
    }
}
+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2 {
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day] == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}
+ (NSString *)timeByTimestamp:(CGFloat)timestamp {
    
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"Asia/Chita"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd aa h:mm"];
    [formatter setTimeZone:zone];
    
    CGFloat thatTime = timestamp;
    NSDate *thatDate = [NSDate dateWithTimeIntervalSince1970:thatTime];
    NSString *thatString = [formatter stringFromDate:thatDate];
    NSDate *nowDate = [NSDate date];
    CGFloat nowTime = [nowDate timeIntervalSince1970];
    
    CGFloat spaceTime = nowTime - thatTime;
    
    if (spaceTime / 60 < 5) {
        return @"刚刚";
    } else if (spaceTime < 60 * 60 * 24) {
        NSString *time = [thatString substringFromIndex:11];
        if ([time hasPrefix:@"PM"]) {
            time = [time stringByReplacingOccurrencesOfString:@"PM" withString:@"下午"];
        }
        if ([time hasPrefix:@"AM"]) {
            time = [time stringByReplacingOccurrencesOfString:@"AM" withString:@"上午"];
        }
        return time;
    } else if (spaceTime < 60 * 60 * 24 * 2) {
        NSString *time = [thatString substringFromIndex:11];
        if ([time hasPrefix:@"PM"]) {
            time = [time stringByReplacingOccurrencesOfString:@"PM" withString:@"昨天下午"];
        }
        if ([time hasPrefix:@"AM"]) {
            time = [time stringByReplacingOccurrencesOfString:@"AM" withString:@"昨天上午"];
        }
        return time;
    } else if (spaceTime < 60 * 60 * 24 * 3) {
        NSString *time = [thatString substringFromIndex:11];
        if ([time hasPrefix:@"PM"]) {
            time = [time stringByReplacingOccurrencesOfString:@"PM" withString:@"前天下午"];
        }
        if ([time hasPrefix:@"AM"]) {
            time = [time stringByReplacingOccurrencesOfString:@"AM" withString:@"前天上午"];
        }
        return time;
    } else if (spaceTime < 60 * 60 * 24 * 4) {
        NSString *time = [thatString substringFromIndex:11];
        if ([time hasPrefix:@"PM"]) {
            time = [time stringByReplacingOccurrencesOfString:@"PM" withString:@"大前天下午"];
        }
        if ([time hasPrefix:@"AM"]) {
            time = [time stringByReplacingOccurrencesOfString:@"AM" withString:@"大前天上午"];
        }
        return time;
    } else if (spaceTime < 60 * 60 * 24 * 365) {
        NSDateFormatter *dateFor = [[NSDateFormatter alloc] init];
        [dateFor setDateFormat:@"M月d日 aa h:mm"];
        [dateFor setTimeZone:zone];
        NSString *time = [dateFor stringFromDate:thatDate];
        time = [time stringByReplacingOccurrencesOfString:@"PM" withString:@"下午"];
        time = [time stringByReplacingOccurrencesOfString:@"AM" withString:@"上午"];
        return time;
    } else {
        NSDateFormatter *dateFor = [[NSDateFormatter alloc] init];
        [dateFor setDateFormat:@"yyyy年M月d日 aa h:mm"];
        [dateFor setTimeZone:zone];
        NSString *time = [dateFor stringFromDate:thatDate];
        time = [time stringByReplacingOccurrencesOfString:@"PM" withString:@"下午"];
        time = [time stringByReplacingOccurrencesOfString:@"AM" withString:@"上午"];
        return time;
    }
}

+ (NSString *)md5:(NSString*)input
{
    const char *cStr = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

+ (NSString *)returnAge:(NSString *)age
{
    int ageInt = [age intValue];
    if (ageInt < 17) {
        return @"17";
    }
    else
    {
        return age;
    }
}
+ (UIColor *)returnColor:(NSString *)color {
    
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


+ (CGSize)returnStringSize:(NSString *)content font:(CGFloat)font MaxWidth:(CGFloat)width
{
    CGSize size = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFont(font * autoLayoutY)} context:nil].size;
    
    return size;
}
+ (CGSize)returnStringSizeW:(NSString *)content font:(CGFloat)font MaxHeight:(CGFloat)height {
    
    CGSize size = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFont(font * autoLayoutY)} context:nil].size;
    
    return size;
}
+ (BOOL) isBlankString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (NSString *)returnSpaceString:(NSString*)string {
    
    NSArray* array = [[NSString stringWithFormat:@"%@",string] componentsSeparatedByString:@","];
    NSString* newString = [NSString string];
    
    for (int i = 0; i< array.count; i++) {
        NSString* tString = [array objectAtIndex:i];
        if (i != 0) {
            tString = [NSString stringWithFormat:@", %@",tString];
        }
        newString = [newString stringByAppendingFormat:@"%@",tString];
    }
    return newString;
}


+ (BOOL)getCurrentTime
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH"];
    int time = [[dateFormatter stringFromDate:currentDate] intValue];

    BOOL hasShake;
    if (time >= 21 && time <= 24) {
        hasShake = YES;
    }
    else
    {
        hasShake = YES;
    }

    return hasShake;
}

+ (NSString *)timeFormatted:(NSInteger)totalSeconds
{
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}
@end
