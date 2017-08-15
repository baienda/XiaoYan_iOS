//
//  ChatViewController.m
//  孝颜
//
//  Created by benjamin on 2017/8/15.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self setNavigationBar];
}
- (void)setNavigationBar{
    
    [self setTitleText:Localized(@"聊天页面")];
    [self setBackButton:BackStyleBlack action:@selector(backAction)];
}
- (void)backAction {
    
    [self popViewController];
}
@end
