//
//  XYViewController.h
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXAlertView.h"
#import "XYNavigationBar.h"
#import "ApiParams.h"
#import "ApiClient.h"
#import "ChatUser.h"
#import "IMCore.h"
#import "UserDefault.h"
#import "UserConfig.h"
#import "CCModel.h"
#import "Common.h"
#import "IMNotice.h"

@protocol NavigationBarAppearance <NSObject>

- (UIBarStyle)requiredNavigationBarStyle;
- (bool)navigationBarShouldBeHidden;

@optional

- (bool)navigationBarHasAction;
- (void)navigationBarAction;
- (void)navigationBarSwipeDownAction;

@optional

- (bool)statusBarShouldBeHidden;
- (UIStatusBarStyle)preferredStatusBarStyle;

@end

typedef enum {
    BackStyleBlack = 0,
    BackStyleWhite = 1
} BackStyle;

typedef void(^accountLoadedBlock)();

@interface XYViewController : UIViewController

@property (nonatomic) bool viewControllerHasEverAppeared;
@property (nonatomic) bool viewControllerIsAppearing;
@property (nonatomic) bool viewControllerIsDisappearing;
@property (nonatomic) bool viewControllerIsAnimatingAppearanceTransition;
@property (nonatomic) bool isFirstInStack;

@property (nonatomic, assign) BOOL isBaseShowReport;

- (void)hideStatusBar:(bool)show;

- (void)setTitleText:(NSString *)titleText;
- (void)setTitleView:(UIView *)titleView;
- (void)setLineColor:(UIColor *)color;
- (void)setHiddenBar:(bool)hidden animated:(bool)animated;
- (void)setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem;
- (void)setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem animated:(BOOL)animated;
- (void)setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem;
- (void)setRightBarButtonItems:(NSArray *)items;
- (void)setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem animated:(BOOL)animated;
- (void)setBackButton:(BackStyle *)backStyle action:(SEL)action;

+ (bool)isWidescreen;

- (void)localizationUpdated;

- (void)pushViewControllerAndRemove:(UIViewController *)viewController animated:(BOOL)flag andBeforeCount:(int)beforeCount;
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)flag;
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag;
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)())completion;
- (void)dismissViewController;
- (void)popViewController;

- (void)alert:(NSString *)message button:(NSString *)button click:(LXAlertClickIndexBlock)click;
- (void)alertLeft:(NSString *)message button:(NSString *)button click:(LXAlertClickIndexBlock)click;
- (void)confirm:(NSString *)message button1:(NSString *)button1 button2:(NSString *)button2 click:(LXAlertClickIndexBlock)click;
- (void)showLoading :(BOOL)isload;
- (void)showLoadingSuccss;
- (void)hideLoading;
- (void)showPageLoading;
- (void)hidePageLoading;

- (void)setUpSuccessHUD;
- (void)setUpSuccessHUD :(NSString*)text;
- (void)setUpErrorHUD :(NSString*)error;

- (BOOL)handlerError:(id)error;

@end
