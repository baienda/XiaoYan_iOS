//
//  NSURL+FormUTF8String.m
//  Meecha
//
//  Created by 王琮 on 16/8/19.
//  Copyright © 2016年 Chatcat. All rights reserved.
//

#import "NSURL+FormUTF8String.h"

@implementation NSURL (FormUTF8String)

//string默认转成UTF8格式 返回url
+ (NSURL *)returnUrlFormUTF8String:(NSString *)str
{
    NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [NSURL URLWithString:url];
}
@end
