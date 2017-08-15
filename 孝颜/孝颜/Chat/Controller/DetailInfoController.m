//
//  DetailInfoController.m
//  孝颜
//
//  Created by benjamin on 2017/8/15.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "DetailInfoController.h"

@interface DetailInfoController ()

@end

@implementation DetailInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kTableViewBackgroundColor;
    [self setNavigationBar];
}
- (void)setNavigationBar{
    
    [self setTitleText: Localized(@"详细资料")];
    [self setBackButton:BackStyleBlack action:@selector(backAction)];
    
}
- (void)backAction {
    
    [self popViewController];
}
@end
