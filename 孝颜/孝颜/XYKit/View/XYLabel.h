//
//  XYLabel.h
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYLabel : UILabel

@property (nonatomic, assign) UIEdgeInsets textInsets; // 控制字体与控件边界的间隙

- (id)initWithContent:(NSString *)content;
- (void)attrWithContent:(NSString *)content textColor:(UIColor*)textColor font:(UIFont*)font lineSpacing:(CGFloat)lineSpacing numberOfLines:(NSInteger)numberOfLines textAlignment:(NSTextAlignment)textAlignment;

@end
