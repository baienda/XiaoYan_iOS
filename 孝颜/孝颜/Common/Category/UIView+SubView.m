//
//  UIView+SubView.m
//  shangshaban
//
//  Created by Mr.Li_YLTX on 16/4/28.
//  Copyright © 2016年 yiliantianxia. All rights reserved.
//

#import "UIView+SubView.h"

@implementation UIView(Subview)


+ (UILabel *)returnLabelWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font textAlignment:(NSTextAlignment)alignment inView:(UIView *)superView
{
    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = text;
    lbl.font = font;
    lbl.textAlignment = alignment;
    lbl.textColor = color;
    [superView addSubview:lbl];
    
    return lbl;
}

+ (UIImageView *)returnImageViewWithImageName:(NSString *)imageName inView:(UIView *)superView
{
    UIImageView *image = [[UIImageView alloc] init];
    image.image = [UIImage imageNamed:imageName];
    [superView addSubview:image];
    return image;
}

@end
