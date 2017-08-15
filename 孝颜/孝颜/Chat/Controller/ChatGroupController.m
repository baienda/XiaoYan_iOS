//
//  ChatGroupController.m
//  孝颜
//
//  Created by benjamin on 2017/8/15.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "ChatGroupController.h"

@interface ChatGroupController ()

@end

@implementation ChatGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kTableViewBackgroundColor;
    [self setNavigationBar];
}
- (void)setNavigationBar{
    
    [self setTitleText:Localized(@"群组")];
    [self setBackButton:BackStyleBlack action:@selector(backAction)];
    
}
- (void)backAction {
    
    [self popViewController];
}
@end
