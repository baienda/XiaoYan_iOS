//
//  ColorImageTool.h
//  Meecha
//
//  Created by 王琮 on 16/10/29.
//  Copyright © 2016年 Chatcat. All rights reserved.
//

typedef enum {
    statusNormal = 0,
    statusPressed = 1
} ButtonTpye;

#import <Foundation/Foundation.h>

@interface ColorImageTool : NSObject

+ (UIImage *)getColorImage:(int)sex andType:(ButtonTpye)type;
@end
