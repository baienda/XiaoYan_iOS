//
//  NSDate+time.h
//  shangshaban
//
//  Created by Mr.Li_YLTX on 16/5/4.
//  Copyright © 2016年 yiliantianxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(time)

//返回时间自定义格式的时间字符串
+ (NSString *)returnTimeStringWithTimeString:(NSString *)timeString outputFormat:(NSString *)outputFormat inputFormat:(NSString *)inputFormat ;

@end
