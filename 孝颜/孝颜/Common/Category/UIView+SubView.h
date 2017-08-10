//
//  UIView+SubView.h
//  shangshaban
//
//  Created by Mr.Li_YLTX on 16/4/28.
//  Copyright © 2016年 yiliantianxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(Subview)

//返回label
+ (UILabel *)returnLabelWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font textAlignment:(NSTextAlignment)alignment inView:(UIView *)superView;

//返回imageview
+ (UIImageView *)returnImageViewWithImageName:(NSString *)imageName inView:(UIView *)superView;


@end
