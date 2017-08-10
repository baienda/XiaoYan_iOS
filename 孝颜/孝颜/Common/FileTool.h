//
//  FileTool.h
//  Meecha
//
//  Created by 王琮 on 16/8/3.
//  Copyright © 2016年 Chatcat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileTool : NSObject

@property (nonatomic,copy) NSString *emotionWords;

+ (void)setCookie;

+ (NSArray *)getEmotionEngPath;
+ (NSArray *)getEmotionChsPath;
+ (NSArray *)getEmotionTaiPath;

- (NSString *)showLocalEmotionWords:(NSString *)str;

+ (NSDictionary *)countryCode;
@end
