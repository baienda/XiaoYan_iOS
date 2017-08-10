//
//  UIView+animation.m
//  shangshaban
//
//  Created by Mr.wc on 16/4/21.
//  Copyright © 2016年 yiliantianxia. All rights reserved.
//

#import "UIView+animation.h"
//#import "ChatAlertView.h"

@implementation UIView(Animation)

+ (void)AnimationShowView:(UIView *)view
{
    [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [view.layer setValue:@(0) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.03 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [view.layer setValue:@(1.1) forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.09 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [view.layer setValue:@(1.2) forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.03 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [view.layer setValue:@(1.3) forKeyPath:@"transform.scale"];
                } completion:^(BOOL finished) {
                  
                }];
            }];
        }];
    }];
}

+ (void)BigAnimationShowView:(UIView *)view completed:(CompletedBlock)completed
{
    [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [view.layer setValue:@(1.3) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [view.layer setValue:@(1.2) forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [view.layer setValue:@(1.15) forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [view.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                } completion:^(BOOL finished) {
                    
                    completed();
                    
                }];
            }];
        }];
    }];
}

+ (void)SmallAnimationShowView:(UIView *)view completed:(CompletedBlock)completed
{
    [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [view.layer setValue:@(1.2) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [view.layer setValue:@(1.15) forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [view.layer setValue:@(1.1) forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [view.layer setValue:@(1) forKeyPath:@"transform.scale"];
                } completion:^(BOOL finished) {
                    
                    completed();
                    
                }];
            }];
        }];
    }];
}

+ (void)simpleAnimationShowView:(UIView *)view
{
    [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [view.layer setValue:@(0) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.16 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [view.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {

        }];
    }];
}

+ (void)simpleAnimationShowView:(UIView *)view completed:(CompletedBlock)completed
{
    [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [view.layer setValue:@(0) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.16 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [view.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {

            completed();
            
        }];
    }];
}

//定时帧动画
+ (void)AnimationShowView:(UIView *)view containerView:(UIView *)container
{

    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        view.transform = CGAffineTransformTranslate(container.transform, 0, 1);

        [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    
            view.transform = CGAffineTransformTranslate(container.transform, 0, -1);

        } completion:^(BOOL finished) {
            
        }];
    
    } completion:^(BOOL finished) {
        
    }];
    
}

//旋转动画
+ (void)RotateAnimationShowView:(UIView *)view
{
    view.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        view.transform = CGAffineTransformMakeRotation(360);
        
    } completion:^(BOOL finished) {
       
        [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            view.transform = CGAffineTransformMakeRotation(360);
            
        } completion:^(BOOL finished) {
            
//            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                
//                view.transform = CGAffineTransformMakeRotation(270);
//                
//            } completion:^(BOOL finished) {
//                
//                [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                    
//                    view.transform = CGAffineTransformMakeRotation(360);
//                    
//                } completion:^(BOOL finished) {
//                    
//                    
//                }];
//                
//            }];
            
        }];
        
    }];
 


    [UIView animateWithDuration:0.3 delay:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        view.transform = CGAffineTransformMakeRotation(45);
        
    } completion:^(BOOL finished) {
        
      
    }];
    
    [UIView animateWithDuration:0.3 delay:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        view.transform = CGAffineTransformMakeRotation(45);
        
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.3 delay:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        view.transform = CGAffineTransformMakeRotation(45);
        
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.3 delay:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        view.transform = CGAffineTransformMakeRotation(45);
        
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.3 delay:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        view.transform = CGAffineTransformMakeRotation(45);
        
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.3 delay:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        view.transform = CGAffineTransformMakeRotation(45);
        
    } completion:^(BOOL finished) {
        
    }];
    
}

+ (void)AlertAnimationShowView:(UIView *)view isOpen:(BOOL)open
{
    if (open) {
        view.alpha = 0;
        [UIView animateWithDuration:.2f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            view.frame = CGRectMake(0, 64, DEVICE_SIZE.width, 180);
            view.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
    else
    {
        view.alpha = 1;
        [UIView animateWithDuration:.15f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            view.frame = CGRectMake(0, -180, DEVICE_SIZE.width, 180);
            view.alpha = 0;
        } completion:^(BOOL finished) {
            
        }];

    }
}


#pragma mark 摇一摇

+ (void)ShakeAnimationShowView:(UIView *)view
{
    CALayer *layer = view.layer;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 2.0f;
    animation.cumulative = YES;
    animation.values = [NSArray arrayWithObjects:
                        [NSNumber numberWithFloat:-M_PI / 4.0],
                        [NSNumber numberWithFloat:M_PI / 18.0],
                        [NSNumber numberWithFloat:-M_PI / 12.0],
                        [NSNumber numberWithFloat:M_PI / 36.0],
                        [NSNumber numberWithFloat:0],nil];
    
    //    animation.keyTimes = [NSArray arrayWithObjects:
    //                          [NSNumber numberWithFloat:0.6],
    //                          [NSNumber numberWithFloat:0.5],
    //                          [NSNumber numberWithFloat:0.4],
    //                          [NSNumber numberWithFloat:0.3],
    //                          [NSNumber numberWithFloat:0.2],nil];
    //    animation.timingFunctions = [NSArray arrayWithObjects:
    //                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],	// from keyframe 1 to keyframe 2
    //                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], nil];	// from keyframe 2 to keyframe 3
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    
    [layer addAnimation:animation forKey:@"shakeAnimation"];
}

+ (void)ShakeBigAnimationShowView:(UIView *)view
{
    [UIView animateWithDuration:0 delay:0.15 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [view.layer setValue:@(0) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.06 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [view.layer setValue:@(1.2) forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.18 delay:0.04 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [view.layer setValue:@(0.9) forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.06 delay:0.04 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [view.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                } completion:^(BOOL finished) {
                    
                }];
            }];
        }];
    }];
}

+ (void)CircleAnimationShowView:(UIView *)view
{
    CALayer *layer = view.layer;
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue =  [NSNumber numberWithFloat:M_PI * 2.0];
    rotationAnimation.duration = 1.5f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    
    [layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

+ (void)CircleToZeroAnimationShowView:(UIView *)view
{
    CALayer *layer = view.layer;
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue =  @(0);
    rotationAnimation.duration = 3;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    
    [layer addAnimation:rotationAnimation forKey:@"CircleToZeroAnimation"];
}


+ (void)LocalShakeAnimationShowView:(UIView *)view
{
    CALayer *layer = view.layer;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 1.4f;
    animation.cumulative = YES;
    animation.values = [NSArray arrayWithObjects:
                        [NSNumber numberWithFloat:-M_PI / 12.0],
                        [NSNumber numberWithFloat:M_PI / 12.0],
                        [NSNumber numberWithFloat:-M_PI / 12.0],
                        [NSNumber numberWithFloat:M_PI / 12.0],
                        [NSNumber numberWithFloat:-M_PI / 12.0],
                        [NSNumber numberWithFloat:M_PI / 12.0],
                        [NSNumber numberWithFloat:-M_PI / 12.0],
                        [NSNumber numberWithFloat:M_PI / 12.0],
                        [NSNumber numberWithFloat:-M_PI / 12.0],
                        [NSNumber numberWithFloat:M_PI / 12.0],
                        [NSNumber numberWithFloat:0],nil];
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    
    [layer addAnimation:animation forKey:@"shakeAnimation"];
}

+ (void)LocalShakeScaleBigAnimation:(UIView *)view
{
    [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [view.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.16 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [view.layer setValue:@(1.3) forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            
        }];
    }];
}

+ (void)LocalShakeScaleSmallAnimation:(UIView *)view
{
    [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [view.layer setValue:@(1.3) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.16 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [view.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            
        }];
    }];
}

@end
