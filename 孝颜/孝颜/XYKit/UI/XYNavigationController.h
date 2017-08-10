//
//  XYNavigationController.h
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PresentationStyleDefault = 0,
    PresentationStyleRootInPopover = 1,
    PresentationStyleChildInPopover = 2,
    PresentationStyleInFormSheet = 3
} NavigationControllerPresentationStyle;

@interface XYNavigationController : UINavigationController

@property (nonatomic) bool isInControllerTransition;
@property (nonatomic) NavigationControllerPresentationStyle presentationStyle;

- (void)setupNavigationBarForController:(UIViewController *)viewController animated:(bool)animated;

+ (XYNavigationController *)navigationControllerWithControllers:(NSArray *)controllers;

+ (XYNavigationController *)navigationControllerWithRootController:(UIViewController *)controller;

+ (XYNavigationController *)navigationControllerWithControllers:(NSArray *)controllers navigationBarClass:(Class)navigationBarClass;

@end
