//
//  ERCodeController.m
//  孝颜
//
//  Created by benjamin on 2017/8/15.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "ERCodeController.h"
#import "DetailInfoController.h"

#import "XYMScanView.h"

@interface ERCodeController ()<XYMScanViewDelegate>
{
    int line_tag;
    UIView *highlightView;
    NSString *scanMessage;
    BOOL isRequesting;
}
@property (nonatomic,weak) XYMScanView *scanV;

@end

@implementation ERCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBlackColor;
    [self setNavigationBar];
}
- (void)setNavigationBar{
    
    [self setTitleText: Localized(@"二维码")];
    [self setBackButton:BackStyleBlack action:@selector(backAction)];
    [self setERCode];
    
}
- (void)backAction {
    
    [self popViewController];
}
- (void)setERCode {
    
    XYMScanView *scanV = [[XYMScanView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_SIZE.width, DEVICE_SIZE.height - 64)];
    scanV.delegate = self;
    [self.view addSubview:scanV];
    _scanV = scanV;
}
#pragma mark - XYMScanViewDelegate
-(void)getScanDataString:(NSString*)scanDataString{
    
    NSLog(@"二维码内容：%@",scanDataString);
    DetailInfoController * infoVC = [[DetailInfoController alloc] init];
//    infoVC.scanDataString = scanDataString;
    [self.navigationController pushViewController:infoVC animated:YES];
}
@end
