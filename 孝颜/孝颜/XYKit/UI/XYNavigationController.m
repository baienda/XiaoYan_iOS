//
//  XYNavigationController.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "XYNavigationController.h"
#import "XYNavigationBar.h"
#import "XYViewController.h"

@interface XYNavigationController ()<UINavigationControllerDelegate>
{
    UITapGestureRecognizer *_dimmingTapRecognizer;
}
// 记录push标志
@property (nonatomic, getter=isPushing) BOOL pushing;

@end

@implementation XYNavigationController

+ (XYNavigationController *)navigationControllerWithRootController:(UIViewController *)controller
{
    return [self navigationControllerWithControllers:[NSArray arrayWithObject:controller]];
}

+ (XYNavigationController *)navigationControllerWithControllers:(NSArray *)controllers
{
    return [self navigationControllerWithControllers:controllers navigationBarClass:[XYNavigationBar class]];
}

+ (XYNavigationController *)navigationControllerWithControllers:(NSArray *)controllers navigationBarClass:(Class)navigationBarClass
{
    XYNavigationController *navigationController = [[XYNavigationController alloc] initWithNavigationBarClass:navigationBarClass toolbarClass:[UIToolbar class]];
    
    bool first = true;
    for (id controller in controllers) {
        if ([controller isKindOfClass:[XYViewController class]]) {
            [(XYViewController *)controller setIsFirstInStack:first];
        }
        first = false;
    }
    [navigationController setViewControllers:controllers];
    
    return navigationController;
}

- (void)setupNavigationBarForController:(UIViewController *)viewController animated:(bool)animated
{
    UIBarStyle barStyle = UIBarStyleDefault;
    bool navigationBarShouldBeHidden = false;
    UIStatusBarStyle statusBarStyle = UIStatusBarStyleBlackOpaque;
    bool statusBarShouldBeHidden = false;
    
    if ([viewController conformsToProtocol:@protocol(NavigationBarAppearance)])
    {
        id<NavigationBarAppearance> appearance = (id<NavigationBarAppearance>)viewController;
        
        barStyle = [appearance requiredNavigationBarStyle];
        navigationBarShouldBeHidden = [appearance navigationBarShouldBeHidden];
        if ([appearance respondsToSelector:@selector(preferredStatusBarStyle)])
            statusBarStyle = [appearance preferredStatusBarStyle];
        if ([appearance respondsToSelector:@selector(statusBarShouldBeHidden)])
            statusBarShouldBeHidden = [appearance statusBarShouldBeHidden];
    }
    
    if (navigationBarShouldBeHidden != self.navigationBarHidden)
    {
        [self setNavigationBarHidden:navigationBarShouldBeHidden animated:animated];
    }
    
    if ([[UIApplication sharedApplication] isStatusBarHidden] != statusBarShouldBeHidden)
        [[UIApplication sharedApplication] setStatusBarHidden:statusBarShouldBeHidden withAnimation:animated ? UIStatusBarAnimationFade : UIStatusBarAnimationNone];
    if ([[UIApplication sharedApplication] statusBarStyle] != statusBarStyle)
        [[UIApplication sharedApplication] setStatusBarStyle:statusBarStyle animated:animated];
}

- (BOOL)shouldAutorotate
{
    return false;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //防止连续push
    if (self.pushing == YES) {
        return;
    } else {
        self.pushing = YES;
    }
    
    if (self.viewControllers.count == 0) {
        if ([viewController isKindOfClass:[XYViewController class]]) {
            [(XYViewController *)viewController setIsFirstInStack:true];
        } else {
            [(XYViewController *)viewController setIsFirstInStack:false];
        }
    }
    
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    _isInControllerTransition = true;
    [super pushViewController:viewController animated:animated];
    _isInControllerTransition = false;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return  [super popToRootViewControllerAnimated:animated];
    
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return [super popToViewController:viewController animated:animated];
    
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    self.pushing = NO;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}


-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    if ( gestureRecognizer == self.interactivePopGestureRecognizer )
    {
        if ( self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0] )
        {
            return NO;
        }
    }
    
    return YES;
}


- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    if (!hidden)
        self.navigationBar.alpha = 1.0f;
    
    [(XYNavigationBar *)self.navigationBar setHiddenState:hidden animated:animated];
    
    [super setNavigationBarHidden:hidden animated:animated];
}

static UIView *findDimmingView(UIView *view)
{
    static NSString *encodedString = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      encodedString = EncodeText(@"VJEjnnjohWjfx", -1);
                  });
    
    if ([NSStringFromClass(view.class) isEqualToString:encodedString])
        return view;
    
    for (UIView *subview in view.subviews)
    {
        UIView *result = findDimmingView(subview);
        if (result != nil)
            return result;
    }
    
    return nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.modalPresentationStyle == UIModalPresentationFormSheet)
    {
        UIView *dimmingView = findDimmingView(self.view.window);
        bool tapSetup = false;
        if (_dimmingTapRecognizer != nil)
        {
            for (UIGestureRecognizer *recognizer in dimmingView.gestureRecognizers)
            {
                if (recognizer == _dimmingTapRecognizer)
                {
                    tapSetup = true;
                    break;
                }
            }
        }
        
        if (!tapSetup)
        {
            _dimmingTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)];
            [dimmingView addGestureRecognizer:_dimmingTapRecognizer];
        }
    }
}

- (void)dimmingViewTapped:(UITapGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateRecognized)
    {
        [self.presentingViewController dismissViewControllerAnimated:true completion:nil];
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //    CGSize screenSize = ScreenSize();
    //    static Class containerClass = nil;
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^
    //                  {
    //                      containerClass = freedomClass(0xf045e5dfU);
    //                  });
    //
    //    for (UIView *view in self.view.subviews)
    //    {
    //        if ([view isKindOfClass:containerClass])
    //        {
    //            CGRect frame = view.frame;
    //
    //            if (ABS(frame.size.width - screenSize.width) < FLT_EPSILON)
    //            {
    //                if (ABS(frame.size.height - screenSize.height + 20) < FLT_EPSILON)
    //                {
    //                    frame.origin.y = frame.size.height - screenSize.height;
    //                    frame.size.height = screenSize.height;
    //                }
    //                else if (frame.size.height > screenSize.height + FLT_EPSILON)
    //                {
    //                    frame.origin.y = 0;
    //                    frame.size.height = screenSize.height;
    //                }
    //            }
    //            else if (ABS(frame.size.width - screenSize.height) < FLT_EPSILON)
    //            {
    //                if (frame.size.height > screenSize.width + FLT_EPSILON)
    //                {
    //                    frame.origin.y = 0;
    //                    frame.size.height = screenSize.width;
    //                }
    //            }
    //
    //            if (ABS(frame.size.height) < FLT_EPSILON)
    //            {
    //                frame.size.height = screenSize.height;
    //            }
    //
    //            if (!CGRectEqualToRect(view.frame, frame))
    //                view.frame = frame;
    //
    //            break;
    //        }
    //    }
}

- (void)viewDidLoad
{
    self.delegate = self;
    
    [super viewDidLoad];
    
    __weak XYNavigationController *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = (id)weakSelf;
        
        self.delegate = weakSelf;
    }
}

- (void)updateControllerLayout:(bool)__unused animated
{
}

@end
