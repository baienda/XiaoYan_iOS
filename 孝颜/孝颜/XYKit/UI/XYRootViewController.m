//
//  XYRootViewController.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "XYRootViewController.h"
#import "XYRootTableView.h"
#import "XYNavigationController.h"

@interface XYRootViewController ()
{
    XYRootTableView *_mainView;
    
    XYNavigationController *_masterNavigationController;
    XYNavigationController *_detailNavigationController;
    
    BOOL _hasLoadViewDone;
}

@end

@implementation XYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
