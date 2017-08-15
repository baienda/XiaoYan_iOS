//
//  MBProgressHUD+Add.h
//  孝颜
//
//  Created by benjamin on 2017/8/15.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Add)

+(void)showHudWithTime:(float)time text:(NSString *)text inView:(UIView *)superview;
+(void)showHudWithTime:(float)time text:(NSString *)text inView:(UIView *)superview center:(CGPoint)center;

@end
