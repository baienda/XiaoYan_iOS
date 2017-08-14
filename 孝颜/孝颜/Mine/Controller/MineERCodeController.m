//
//  MineERCodeController.m
//  孝颜
//
//  Created by benjamin on 2017/8/14.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "MineERCodeController.h"

@interface MineERCodeController ()

@end

@implementation MineERCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kTableViewBackgroundColor;
    [self setNavigationBar];
    [self setERCodeView];
}
- (void)setNavigationBar{
    
    [self setTitleText: Localized(@"我的二维码")];
    [self setBackButton:BackStyleBlack action:@selector(backAction)];
    
}
- (void)backAction {
    
    [self popViewController];
}
- (void)setERCodeView {
    
    UIImageView* erView = [[UIImageView alloc] init];
    erView.image = [UIImage imageNamed:@"2"];
    [self.view addSubview:erView];
    [erView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(250* autoLayoutX);
        make.height.mas_equalTo(250* autoLayoutY);
    }];
    
    UILabel* tipsView = [[UILabel alloc] init];
    tipsView.textColor = kGrayColor;
    tipsView.font = kFont(12* autoLayoutY);
    tipsView.textAlignment = NSTextAlignmentCenter;
    tipsView.text = Localized(@"扫一扫上面的二维码图案，加我好友");
    [self.view addSubview:tipsView];
    [tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kLeadingMargin);
        make.right.mas_equalTo(-kLeadingMargin);
        make.top.mas_equalTo(erView.mas_bottom).mas_offset(30);
    }];
}
@end
