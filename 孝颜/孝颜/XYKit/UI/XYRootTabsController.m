//
//  XYRootTabsController.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "XYRootTabsController.h"
//#import "JHChainableAnimations.h"
//#import "VideoShowViewController.h"

@implementation XYTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        self.multipleTouchEnabled = false;
        self.exclusiveTouch = true;
        
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = kColor(58, 49, 53);
        _backgroundView.frame = self.bounds;
        [self addSubview:_backgroundView];
        
        _stripeView = [[UIView alloc] init];
        _stripeView.backgroundColor = [UIColor clearColor];
        [self addSubview:_stripeView];
        
        _buttonViews = [[NSMutableArray alloc] init];
        
        UIImageView *courseIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2"] highlightedImage:[UIImage imageNamed:@"1"]];
        [self addSubview:courseIcon];
        [_buttonViews addObject:courseIcon];
        
        UIImageView *activityIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2"] highlightedImage:[UIImage imageNamed:@"1"]];
        [self addSubview:activityIcon];
        [_buttonViews addObject:activityIcon];
        
        UIImageView *videoIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2"] highlightedImage:[UIImage imageNamed:@"1"]];
        self.videoIcon = videoIcon;
        [self addSubview:videoIcon];
        [_buttonViews addObject:videoIcon];
        
        
        UIImageView *mineIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2"] highlightedImage:[UIImage imageNamed:@"1"]];
        [self addSubview:mineIcon];
        [_buttonViews addObject:mineIcon];
        
        _labelViews = [[NSMutableArray alloc] init];
        
        NSArray *titles = @[Localized(@"课程"),
                            Localized(@"活动"),
                            Localized(@"视频"),
                            Localized(@"我")];
        
        for (NSString *title in titles)
        {
            UILabel *label = [self createTabLabelWithText:title];
            [self addSubview:label];
            [_labelViews addObject:label];
        }
    }
    return self;
}

- (UIFont *)tabLabelFont
{
    static UIFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      font = kFont(10);
                  });
    
    return font;
}

- (CGFloat)iconVerticalOffset
{
    static CGFloat offset = 0.0f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      offset = 6.0f;
                  });
    
    return offset;
}

- (CGFloat)labelVerticalOffset
{
    static CGFloat offset = 0.0f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      offset = 35 - 0.5f;
                  });
    
    return offset;
}

- (CGFloat)sideIconOffsetForWidth:(CGFloat)width
{
    return 0.0f;
}

- (UILabel *)createTabLabelWithText:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = kColor(131, 130, 136);
    label.highlightedTextColor = kGlobalColor;
    label.font = [self tabLabelFont];
    label.text = text;
    [label sizeToFit];
    return label;
}

- (void)setSelectedIndex:(int)selectedIndex
{
    if (_selectedIndex >= 0 && _selectedIndex < (int)_buttonViews.count)
    {
        ((UIImageView *)[_buttonViews objectAtIndex:_selectedIndex]).highlighted = false;
        ((UILabel *)[_labelViews objectAtIndex:_selectedIndex]).highlighted = false;
    }
    
    _selectedIndex = selectedIndex;
    
    if (_selectedIndex >= 0 && _selectedIndex < (int)_buttonViews.count)
    {
        ((UIImageView *)[_buttonViews objectAtIndex:_selectedIndex]).highlighted = true;
        ((UILabel *)[_labelViews objectAtIndex:_selectedIndex]).highlighted = true;
    }
    
//    if(_selectedIndex == 1 && _unreadBadgeLabel != nil)
//    {
//        _unreadBadgeLabel.hidden = YES;
//    }
//    
//    if(_selectedIndex == 4 && _momentBadgeLabel != nil)
//    {
//        _momentBadgeLabel.hidden = YES;
//    }
//    if (_selectedIndex == 0) {
//        
//        [self videoIconClick];
//    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    int index = MAX(0, MIN((int)_buttonViews.count - 1, (int)([touch locationInView:self].x / (self.frame.size.width / _buttonViews.count))));
//        [self setSelectedIndex:index];
    __strong id<XYTabBarDelegate> delegate = _tabDelegate;
    [delegate tabBarSelectedItem:index];
}

- (void)loadUnreadBadgeView
{
    if (!_unreadBadgeLabel) {
        _unreadBadgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        _unreadBadgeLabel.layer.cornerRadius = 7.5f;
        _unreadBadgeLabel.layer.masksToBounds = YES;
        _unreadBadgeLabel.textColor = [UIColor whiteColor];
        _unreadBadgeLabel.backgroundColor = UIColorRGB(0xF03849);
        _unreadBadgeLabel.font = kFont(10);
        _unreadBadgeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_unreadBadgeLabel];
    }
}

- (void)loadMomentBadgeView
{
    if (!_momentBadgeLabel) {
        _momentBadgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        _momentBadgeLabel.layer.cornerRadius = 7.5f;
        _momentBadgeLabel.layer.masksToBounds = YES;
        _momentBadgeLabel.textColor = [UIColor whiteColor];
        _momentBadgeLabel.backgroundColor = UIColorRGB(0xF03849);
        _momentBadgeLabel.font = kFont(10);
        _momentBadgeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_momentBadgeLabel];
    }
}

- (NSString *)formatNumbers:(int)count
{
    NSString *text = nil;
    
    if (count < 1000)
        text = [[NSString alloc] initWithFormat:@"%d", count];
    else if (count < 1000000)
        text = [[NSString alloc] initWithFormat:@"%dK", count / 1000];
    else
        text = [[NSString alloc] initWithFormat:@"%dM", count / 1000000];
    return text;
}

- (void)setUnreadCount:(int)unreadCount
{
    if (unreadCount <= 0 && _unreadBadgeLabel == nil)
        return;
    
    if(_selectedIndex == 1)
        return;
    
    [self loadUnreadBadgeView];
    
    if (unreadCount <= 0)
        _unreadBadgeLabel.hidden = YES;
    else
    {
        _unreadBadgeLabel.hidden = NO;
        NSString *text = [NSString stringWithFormat:@"%d", unreadCount];
        if(unreadCount > 99){
            text = @"99+";
        }
        _unreadBadgeLabel.text = text;
        
        CGRect labelFrame = _unreadBadgeLabel.frame;
        labelFrame.origin.x = ceilf(3 * self.frame.size.width / 10 + 5);
        labelFrame.origin.y = ceilf(4);
        _unreadBadgeLabel.frame = labelFrame;
        
        CGSize titleSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFont(10)} context:nil].size;
        if(titleSize.width < 7) titleSize.width = 7;
        _unreadBadgeLabel.bounds = CGRectMake(0, 0, titleSize.width + 8, 15);
    }
}

- (void)setMomentCount:(int)momentCount
{
    if (momentCount <= 0 && _momentBadgeLabel == nil)
        return;
    
    if(_selectedIndex == 2)
        return;
    
    [self loadMomentBadgeView];
    
    if (momentCount <= 0)
        _momentBadgeLabel.hidden = YES;
    else
    {
        _momentBadgeLabel.hidden = NO;
        NSString *text = [NSString stringWithFormat:@"%d",momentCount];
        if(momentCount > 99){
            text = @"99+";
        }
        _momentBadgeLabel.text = text;
        
        CGRect labelFrame = _momentBadgeLabel.frame;
        labelFrame.origin.x = ceilf(9 * self.frame.size.width / 10);
        labelFrame.origin.y = ceilf(4);
        _momentBadgeLabel.frame = labelFrame;
        
        CGSize titleSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFont(10)} context:nil].size;
        if(titleSize.width < 7) titleSize.width = 7;
        _momentBadgeLabel.bounds = CGRectMake(0, 0, titleSize.width + 8, 15);
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize viewSize = self.frame.size;
    
    _backgroundView.frame = CGRectMake(0, 0, viewSize.width, viewSize.height);
    CGFloat stripeHeight = 0.5f;
    _stripeView.frame = CGRectMake(0, -stripeHeight, viewSize.width, stripeHeight);
    
    float indicatorWidth = floorf((float)viewSize.width / _buttonViews.count);
    if (((int)indicatorWidth) % 2 != 0)
        indicatorWidth -= 1;
    
    float paddingLeft = floorf((float)(viewSize.width - indicatorWidth * _buttonViews.count) / 2);
    float additionalWidth = 0;
    float additionalOffset = 0;
    if (_selectedIndex == 0 || _selectedIndex == 2)
        additionalWidth += paddingLeft + 1;
    if (_selectedIndex == 0)
        additionalOffset += -paddingLeft - 1;
    
    CGFloat iconVerticalOffset = [self iconVerticalOffset];
    CGFloat labelVerticalOffset = [self labelVerticalOffset];
    
    int index = -1;
    for (UIView *iconView in _buttonViews)
    {
        index++;
        
        CGFloat horizontalOffset = 0.0f;
        if (index == 0 || index == 2)
            horizontalOffset = [self sideIconOffsetForWidth:viewSize.width] * (index == 0 ? 1 : -1);
        
        CGRect frame = iconView.frame;
        frame.origin.x = paddingLeft + index * indicatorWidth + floorf((float)(indicatorWidth - frame.size.width) / 2) + horizontalOffset;
        frame.origin.y = iconVerticalOffset;
        
        iconView.frame = frame;
        
        //        if (index == 1)
        //        {
        //            if (_unreadBadgeContainer != nil)
        //            {
        //                CGRect unreadBadgeContainerFrame = _unreadBadgeContainer.frame;
        //                unreadBadgeContainerFrame.origin.x = frame.origin.x + frame.size.width - 9;
        //                unreadBadgeContainerFrame.origin.y = 2;
        //                _unreadBadgeContainer.frame = unreadBadgeContainerFrame;
        //            }
        //        }
        //
        //        if (index == 2)
        //        {
        //            if (_momentBadgeContainer != nil)
        //            {
        //                CGRect momentBadgeContainerFrame = _momentBadgeContainer.frame;
        //                momentBadgeContainerFrame.origin.x = frame.origin.x + frame.size.width - 9;
        //                momentBadgeContainerFrame.origin.y = 2;
        //                _momentBadgeContainer.frame = momentBadgeContainerFrame;
        //            }
        //        }
        
        //视频
//        if (index == 2) {
//            CGRect frame = CGRectMake((DEVICE_SIZE.width - 36)/2, (49 - 36)/2, 36, 36);
//            iconView.frame = frame;
//            
//            self.videoIconCircle.frame = CGRectMake(3, 3, 30, 30);
//        }
        UILabel *labelView = [_labelViews objectAtIndex:index];
        
        CGRect labelFrame = labelView.frame;
        labelFrame.origin.x = paddingLeft + index * indicatorWidth + floorf((float)(indicatorWidth - labelFrame.size.width) / 2) + horizontalOffset;
        labelFrame.origin.y = labelVerticalOffset;
        labelView.frame = labelFrame;
//
//        //视频
//        if (index == 2) {
//            CGRect frame = CGRectMake(0, 0, 0, 0);
//            labelView.bounds = frame;
//            labelView.center = self.center;
//        }
    }
}

//视频动画
//- (void)videoIconClick {
//    
//    if (self.videoAnimating) {
//        return;
//    }else {
//        self.videoAnimating = YES;
//        [self startVideoAni];
//    }
//}
//- (void)startVideoAni {
//    
//    
//    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5/*延迟执行时间*/ * NSEC_PER_SEC));
//    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//        [self startVideo];
//    });
//    
//}
//- (void)startVideo {
//    
//    //压缩
//    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        self.videoIconCircle.transform = CGAffineTransformMakeScale(0.6, 0.6);
//    } completion:^(BOOL finished) {
//        //左移
//        [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            self.videoIconCircle.frame = CGRectMake(0, 9, 18, 18);
//        } completion:^(BOOL finished) {
//            //右移
//            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
//                self.videoIconCircle.frame = CGRectMake(36 - (0 + 18), 9, 18, 18);
//            } completion:^(BOOL finished) {
//                //下压
//                [UIView animateWithDuration:0.05 delay:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
//                    self.videoIconCircle.frame = CGRectMake(36 - (0 + 18), 18, 18, 0.1);
//                } completion:^(BOOL finished) {
//                    //返回
//                    [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
//                        self.videoIconCircle.frame = CGRectMake(36 - (0 + 18), 9, 18, 18);
//                    } completion:^(BOOL finished) {
//                        //移中
//                        [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
//                            self.videoIconCircle.frame = CGRectMake(9, 9, 18, 18);
//                        } completion:^(BOOL finished) {
//                            //下压
//                            [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
//                                self.videoIconCircle.frame = CGRectMake(9, 18, 18, 0.1);
//                            } completion:^(BOOL finished) {
//                                //返回
//                                [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
//                                    self.videoIconCircle.frame = CGRectMake(9, 9, 18, 18);
//                                } completion:^(BOOL finished) {
//                                    //下压
//                                    [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
//                                        self.videoIconCircle.frame = CGRectMake(9, 18, 18, 0.1);
//                                    } completion:^(BOOL finished) {
//                                        //返回
//                                        [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
//                                            self.videoIconCircle.frame = CGRectMake(9, 9, 18, 18);
//                                        } completion:^(BOOL finished) {
//                                            //放大
//                                            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
//                                                self.videoIconCircle.transform = CGAffineTransformMakeScale(1, 1);
//                                            } completion:^(BOOL finished) {
//                                                self.videoAnimating = NO;
//                                            }];
//                                        }];
//                                    }];
//                                }];
//                            }];
//                        }];
//                    }];
//                }];
//            }];
//        }];
//    }];
//}
@end


#pragma mark -

@interface CCTabsContainerSubview : UIView

@end

@implementation CCTabsContainerSubview

- (void)layoutSubviews
{
    CGSize screenSize = ScreenSize();
    
    for (UIView *subview in self.subviews)
    {
        subview.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, screenSize.height);
    }
}

@end

#pragma mark -

@interface XYRootTabsController () <UITabBarControllerDelegate, XYTabBarDelegate>
{
    int _unreadCount;
    int _momentCount;
    NSTimeInterval _lastSameIndexTapTime;
    int _tapsInSuccession;
}


@end

@implementation XYRootTabsController

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        self.delegate = self;
        
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)])
            [self setAutomaticallyAdjustsScrollViewInsets:false];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
}

- (CGFloat)tabBarHeight
{
    static CGFloat height = 0.0f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      height = 49.0f;
                  });
    
    return height;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _customTabBar = [[XYTabBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - [self tabBarHeight], self.view.frame.size.width, [self tabBarHeight])];
    _customTabBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _customTabBar.tabDelegate = self;
    [self.view insertSubview:_customTabBar aboveSubview:self.tabBar];
    
    //_customTabBar.alpha = 0.5f;
    
    self.tabBar.hidden = true;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (UIBarStyle)requiredNavigationBarStyle
{
    if (self.selectedViewController == nil)
        return UIBarStyleDefault;
    else if ([self.selectedViewController conformsToProtocol:@protocol(NavigationBarAppearance)])
        return [(id<NavigationBarAppearance>)self.selectedViewController requiredNavigationBarStyle];
    else
        return UIBarStyleDefault;
}

- (bool)navigationBarShouldBeHidden
{
    if (self.selectedViewController == nil)
        return false;
    else if ([self.selectedViewController conformsToProtocol:@protocol(NavigationBarAppearance)])
        return [(id<NavigationBarAppearance>)self.selectedViewController navigationBarShouldBeHidden];
    else
        return false;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.view layoutIfNeeded];
    
    [super viewWillAppear:animated];
}

- (BOOL)tabBarController:(UITabBarController *)__unused tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (viewController == self.selectedViewController) {
        return NO;
    } else {
        return YES;
    }
}
- (void)tabBarSelectedItem:(int)index
{
    if ((int)self.selectedIndex != index)
    {
        if ([self tabBarController:self shouldSelectViewController:[self.viewControllers objectAtIndex:index]]) {
            [self setSelectedIndex:index];
        }
    }
    else
    {
        //todo
        //if ([self.selectedViewController respondsToSelector:@selector(scrollToTopRequested)])
        //    [self.selectedViewController performSelector:@selector(scrollToTopRequested)];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    
    [_customTabBar setSelectedIndex:(int)selectedIndex];
}

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated
{
    [super setViewControllers:viewControllers animated:animated];
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
}

- (void)setUnreadCount:(int)unreadCount
{
    _unreadCount = unreadCount;
    [_customTabBar setUnreadCount:unreadCount];
}

- (void)setMomentCount:(int)unreadCount;
{
    _momentCount = unreadCount;
    [_customTabBar setMomentCount:unreadCount];
}

- (void)localizationUpdated
{
    _customTabBar.tabDelegate = nil;
    [_customTabBar removeFromSuperview];
    
    _customTabBar = [[XYTabBar alloc] initWithFrame:CGRectMake(0, DEVICE_SIZE.height - [self tabBarHeight], DEVICE_SIZE.width, [self tabBarHeight])];
    _customTabBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _customTabBar.tabDelegate = self;
    [self.view insertSubview:_customTabBar aboveSubview:self.tabBar];
    
    [_customTabBar setSelectedIndex:(int)self.selectedIndex];
    [_customTabBar setUnreadCount:_unreadCount];
    //[_customTabBar setMomentCount:_momentCount];
    
    for (XYViewController *controller in self.viewControllers)
    {
        [controller localizationUpdated];
    }
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    [super dismissViewControllerAnimated:flag completion:completion];
    [self.navigationController setToolbarHidden:true animated:false];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                                       toViewController:(UIViewController *)toVC
{
    for (int i = 0; i < tabBarController.viewControllers.count; i ++) {
        if (fromVC == [tabBarController.viewControllers objectAtIndex:i]) {
            
            [[NSUserDefaults standardUserDefaults]setObject:@(i) forKey:kUserDefaultsToPaperBeforeIndex];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
    }
    
    return nil;
}
@end
