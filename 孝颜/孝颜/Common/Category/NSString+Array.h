//
//  NSString+Array.h
//  shangshaban
//
//  Created by Mr.Li_YLTX on 16/4/28.
//  Copyright © 2016年 yiliantianxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Array)

//将用分隔字符组合的字符串拆分成单个text的数组
+ (NSArray *)returnStringArrayWithString:(NSString *)String WithCount:(int)count withSeparateString:(NSString *)separateString;

+ (NSString *)urlValidation:(NSString *)string;

//返回距离text
+ (NSString *)returnDistanceStringWithDistance:(int)distance;

//转换时间戳
+ (NSString *)returnNewTime:(NSString *)time;

+ (NSString *)returnTimeDetail:(CGFloat)timeStamp;
//时间戳
+ (NSString *)timeByTimestamp:(CGFloat)timestamp;

+ (NSString *)returnNewTimeCompareCurrentTime:(NSString *)time;
+ (NSString *)returnNewTopicTimeCompareCurrentTime:(NSString *)time;
//在线？
+ (BOOL)isOnLine:(NSString *)time;
//是否为同一天
+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;
//转换时间戳 （刚刚-AMPM-月/日/年 格式）
+ (NSString *)returnNewTimeSecondModo:(CGFloat)timeStamp;
//md5加密
+ (NSString *)md5:(NSString*)input;

//年龄过滤
+ (NSString *)returnAge:(NSString *)age;
//16位颜色转换
+ (UIColor *)returnColor:(NSString *)color;

//计算文本Size
+ (CGSize)returnStringSize:(NSString *)content font:(CGFloat)font MaxWidth:(CGFloat)width;

+ (CGSize)returnStringSizeW:(NSString *)content font:(CGFloat)font MaxHeight:(CGFloat)height;

+ (BOOL)isBlankString:(NSString *)string;

+ (NSString *)returnSpaceString:(NSString*)string;

+ (BOOL)getCurrentTime;

+ (NSString *)timeFormatted:(NSInteger)totalSeconds;
@end
