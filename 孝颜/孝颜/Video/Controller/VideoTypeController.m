//
//  VideoTypeController.m
//  孝颜
//
//  Created by benjamin on 2017/8/11.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "VideoTypeController.h"

@interface VideoTypeController ()

@end

@implementation VideoTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self setNavigationBar];
}
- (void)setNavigationBar{
    
    [self setTitleText:Localized(@"视频分类")];
    [self setBackButton:BackStyleBlack action:@selector(backAction)];
    
}
- (void)backAction {
    
    [self popViewController];
}
@end
