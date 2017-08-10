//
//  XYRootViewController.h
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//
#import "XYViewController.h"
#import "XYRootTabsController.h"

#import "CourseViewController.h"
#import "ActivityViewController.h"
#import "VideoViewController.h"
#import "MineViewController.h"

@interface XYRootViewController : XYViewController

@property (nonatomic, strong, readonly) XYRootTabsController *mainTabsController;

@property (nonatomic, strong, readonly) CourseViewController *courseViewController;
@property (nonatomic, strong, readonly) ActivityViewController *activityViewController;
@property (nonatomic, strong, readonly) VideoViewController *videoViewController;
@property (nonatomic, strong, readonly) MineViewController *mineViewController;

- (void)pushContentController:(UIViewController *)contentController;
- (void)replaceContentController:(UIViewController *)contentController;
- (void)popToContentController:(UIViewController *)contentController;
- (void)clearContentControllers;
- (NSArray *)viewControllers;

- (void)loginDone;

@end
