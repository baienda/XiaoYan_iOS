//
//  XYNavigationBar.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "XYNavigationBar.h"
#import "XYRootTableView.h"

#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

#import <CoreMotion/CoreMotion.h>

@interface CCNavigationBarLayer : CALayer

@end

@implementation CCNavigationBarLayer

@end

#pragma mark -

@interface CCFixView : UIActivityIndicatorView

@end

@implementation CCFixView

- (void)setAlpha:(CGFloat)__unused alpha
{
    [super setAlpha:0.02f];
}

@end
@interface XYNavigationBar () <UIGestureRecognizerDelegate>
{
    bool _shouldAddBackgdropBackgroundInitialized;
    bool _shouldAddBackgdropBackground;
}

@property (nonatomic, strong) UIView *backgroundContainerView;
@property (nonatomic, strong) UIView *statusBarBackgroundView;
@property (nonatomic, strong) UIView *barBackgroundView;
@property (nonatomic, strong) UIView *stripeView;

@property (nonatomic) bool hiddenState;

@property (nonatomic) bool contractBackgroundContainer;

@end

@implementation XYNavigationBar

+ (Class)layerClass
{
    return [CCNavigationBarLayer class];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self != nil)
    {
        [self commonInit:WhiteNavigationBarStyle];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit:WhiteNavigationBarStyle];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame barStyle:(NavigationBarStyle)barStyle
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit:barStyle];
    }
    return self;
}

- (void)commonInit:(NavigationBarStyle)barStyle
{
    
    if (iosMajorVersion() >= 7 && [XYViewController isWidescreen] && [CMMotionActivityManager isActivityAvailable])
    {
        CCFixView *activityIndicator = [[CCFixView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.alpha = 0.02f;
        [self addSubview:activityIndicator];
        [activityIndicator startAnimating];
    }
    
    CGFloat backgroundOverflow = iosMajorVersion() >= 7 ? 20.0f : 0.0f;
    
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:[UIImage new]];
    
    if (barStyle == WhiteNavigationBarStyle)
    {
        _backgroundContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, -backgroundOverflow, self.bounds.size.width, backgroundOverflow + self.bounds.size.height)];
        _backgroundContainerView.userInteractionEnabled = false;
        [super insertSubview:_backgroundContainerView atIndex:0];
        
        _barBackgroundView = [[UIView alloc] init];
        _barBackgroundView.backgroundColor = [UIColor whiteColor];
        _barBackgroundView.frame = _backgroundContainerView.bounds;
        [_backgroundContainerView addSubview:_barBackgroundView];
        
        _stripeView = [[UIView alloc] init];
        _stripeView.backgroundColor = UIColorRGB(0xE5E5E5);
        [_backgroundContainerView addSubview:_stripeView];
        
        self.tintColor = [UIColor whiteColor];
        self.barStyle = UIBarStyleBlackOpaque;
    }
    
    if(barStyle == TransparentNavigationBarStyle){
        self.tintColor = [UIColor clearColor];
        self.barStyle = UIBarStyleBlackOpaque;
    }
    
    if (iosMajorVersion() < 7)
    {
        _contractBackgroundContainer = true;
        _progressView = [[UIView alloc] init];
        self.translucent = true;
    }
    
    [self setBackgroundColor:[UIColor clearColor]];
    
}

- (void)dealloc
{
}

- (void)layoutSubviews
{
    if (_backgroundContainerView != nil)
    {
        CGFloat backgroundOverflow = iosMajorVersion() >= 7 ? 20.0f : 0.0f;
        _backgroundContainerView.frame = CGRectMake(0, -backgroundOverflow, self.bounds.size.width, backgroundOverflow + self.bounds.size.height);
        
        if (_barBackgroundView != nil)
            _barBackgroundView.frame = _backgroundContainerView.bounds;
    }
    
    if (_stripeView != nil)
    {
        float stripeHeight = [[UIScreen mainScreen] scale] > 1.5f ? 0.5f : 1.0f;
        _stripeView.frame = CGRectMake(0, _backgroundContainerView.bounds.size.height - stripeHeight, _backgroundContainerView.bounds.size.width, stripeHeight);
    }
    
    [super layoutSubviews];
}

- (void)setCenter:(CGPoint)center
{
    bool shouldFix = (iosMajorVersion() >= 7);
    if (shouldFix && [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
        shouldFix = [[[[self superview] superview] superview] isKindOfClass:[XYRootTableView class]];
    
    if (shouldFix && center.y <= self.frame.size.height / 2)
        center.y = center.y + 20.0f;
    
    [super setCenter:center];
    
    if (_statusBarBackgroundView != nil && _statusBarBackgroundView.superview != nil)
    {
        _statusBarBackgroundView.frame = CGRectMake(0, -self.frame.origin.y, self.frame.size.width, 20);
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if (_statusBarBackgroundView != nil && _statusBarBackgroundView.superview != nil)
    {
        _statusBarBackgroundView.frame = CGRectMake(0, -self.frame.origin.y, self.frame.size.width, 20);
    }
}

- (void)setHiddenState:(bool)hidden animated:(bool)animated
{
    if (animated)
    {
        if (_hiddenState != hidden)
        {
            if (iosMajorVersion() < 7)
            {
                _hiddenState = hidden;
                
                if (_statusBarBackgroundView == nil)
                {
                    _statusBarBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, -self.frame.origin.y, self.frame.size.width, 20)];
                    _statusBarBackgroundView.backgroundColor = [UIColor blackColor];
                }
                else
                    _statusBarBackgroundView.frame = CGRectMake(0, -self.frame.origin.y, self.frame.size.width, 20);
                
                [self addSubview:_statusBarBackgroundView];
                
                [UIView animateWithDuration:0.3 animations:^
                 {
                     _progressView.alpha = hidden ? 0.0f : 1.0f;
                 } completion:^(BOOL finished)
                 {
                     if (finished)
                         [_statusBarBackgroundView removeFromSuperview];
                 }];
            }
        }
        else
        {
            _progressView.alpha = hidden ? 0.0f : 1.0f;
        }
    }
    else
    {
        _hiddenState = hidden;
        
        _progressView.alpha = hidden ? 0.0f : 1.0f;
    }
}

- (void)setLineColor:(UIColor *)color
{
    _stripeView.backgroundColor = color;
}

- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index
{
    [super insertSubview:view atIndex:MIN((int)self.subviews.count, MAX(index, 2))];
}
@end
