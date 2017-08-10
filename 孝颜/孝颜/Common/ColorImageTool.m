//
//  ColorImageTool.m
//  Meecha
//
//  Created by 王琮 on 16/10/29.
//  Copyright © 2016年 Chatcat. All rights reserved.
//

#import "ColorImageTool.h"

@implementation ColorImageTool

+ (UIImage *)getColorImage:(int)sex andType:(ButtonTpye)type
{
    UIColor *color;
    if (sex == 1) {
        if (type == statusNormal) {
            color = kBuleColor;
        }
        else
        {
            color = kBuleHighlightColor;
        }
    }
    else
    {
        if (type == statusNormal) {
            color = kGlobalColor;
        }else
        {
            color = kGlobalHighlightColor;
        }
    }
    CGSize imageSize = CGSizeMake(DEVICE_SIZE.width, 60);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *colorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return colorImg;
}
@end
