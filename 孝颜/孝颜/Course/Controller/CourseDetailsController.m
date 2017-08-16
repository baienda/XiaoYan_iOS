//
//  CourseDetailsController.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "CourseDetailsController.h"

@interface CourseDetailsController ()

@property (nonatomic, strong)UIScrollView* baseScrollview;

@end

@implementation CourseDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self setNavigationBar];
//    [self setBaseScrollView];
//    [self addBaseView];
}
- (void)setNavigationBar{
    
    [self setTitleText: Localized(@"课程详情")];
    [self setBackButton:BackStyleBlack action:@selector(backAction)];
    
}
- (void)backAction {
    
    [self popViewController];
}
@end
