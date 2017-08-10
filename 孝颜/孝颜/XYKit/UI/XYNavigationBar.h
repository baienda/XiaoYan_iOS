//
//  XYNavigationBar.h
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYNavigationController.h"

typedef enum {
    WhiteNavigationBarStyle = 0,
    TransparentNavigationBarStyle = 1
} NavigationBarStyle;

@class NavigationController;

@interface XYNavigationBar : UINavigationBar

@property (nonatomic, strong) UIView *progressView;

- (id)initWithFrame:(CGRect)frame barStyle:(NavigationBarStyle)barStyle;

- (void)setHiddenState:(bool)hidden animated:(bool)animated;

- (void)setLineColor:(UIColor *)color;

@end
