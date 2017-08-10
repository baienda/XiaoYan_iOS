//
//  NSURL+FormUTF8String.h
//  Meecha
//
//  Created by 王琮 on 16/8/19.
//  Copyright © 2016年 Chatcat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (FormUTF8String)

//string默认转成UTF8格式 返回url
+ (NSURL *)returnUrlFormUTF8String:(NSString *)str;
@end
