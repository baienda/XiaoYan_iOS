//
//  UIView+animation.h
//  shangshaban
//
//  Created by Mr.wc on 16/4/21.
//  Copyright © 2016年 yiliantianxia. All rights reserved.
//

typedef void (^CompletedBlock)(void);

#import <UIKit/UIKit.h>

@interface UIView(Animation)

//弱弱的弹窗动画
+ (void)simpleAnimationShowView:(UIView *)view;

//弱弱的弹窗动画 带回调
+ (void)simpleAnimationShowView:(UIView *)view completed:(CompletedBlock)completed;

//弹窗动画
+ (void)AnimationShowView:(UIView *)view;

+ (void)BigAnimationShowView:(UIView *)view completed:(CompletedBlock)completed;

+ (void)SmallAnimationShowView:(UIView *)view completed:(CompletedBlock)completed;

//定时帧动画
+ (void)AnimationShowView:(UIView *)view containerView:(UIView *)container;

//旋转动画
+ (void)RotateAnimationShowView:(UIView *)view;

//弹出动画
+ (void)AlertAnimationShowView:(UIView *)view isOpen:(BOOL)open;


#pragma mark 摇一摇动画

+ (void)ShakeAnimationShowView:(UIView *)view;

//放大动画
+ (void)ShakeBigAnimationShowView:(UIView *)view;

+ (void)CircleAnimationShowView:(UIView *)view;
+ (void)CircleToZeroAnimationShowView:(UIView *)view;

+ (void)LocalShakeAnimationShowView:(UIView *)view;

+ (void)LocalShakeScaleBigAnimation:(UIView *)view;

+ (void)LocalShakeScaleSmallAnimation:(UIView *)view;
@end
