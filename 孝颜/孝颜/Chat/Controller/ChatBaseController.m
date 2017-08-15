//
//  ChatBaseController.m
//  孝颜
//
//  Created by benjamin on 2017/8/15.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "ChatBaseController.h"
#import "DialogListController.h"
#import "ChatAddressController.h"
#import "ERCodeController.h"

@interface ChatBaseController ()

@property (nonatomic, strong) DialogListController *dialogListComtroller;

@property (nonatomic, strong) ChatAddressController *chatAddressController;

@property (nonatomic, strong) XYViewController *currentVC;

@property (nonatomic, assign) NSInteger index;

@end

@implementation ChatBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kTableViewBackgroundColor;
    [self setNavigationBar];
    
    self.dialogListComtroller = [[DialogListController alloc] init];
    self.dialogListComtroller.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
    [self addChildViewController:_dialogListComtroller];
    
    self.chatAddressController = [[ChatAddressController alloc] init];
    self.chatAddressController.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
    [self addChildViewController:_chatAddressController];
    
    //设置默认控制器为dialogListComtroller
    self.currentVC = self.dialogListComtroller;
    [self.view addSubview:self.dialogListComtroller.view];

}
- (void)setNavigationBar {
    
    [self setTitleView:[self setupSegment]];
    [self setBackButton:BackStyleBlack action:@selector(backAction)];
    
    //二维码
    UIButton *erCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    erCodeBtn.bounds = CGRectMake(0, 0, 29, 29);
    [erCodeBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [erCodeBtn setTitleColor:kGlobalColor forState:UIControlStateNormal];
    erCodeBtn.titleLabel.font = kFont(14* autoLayoutY);
    [erCodeBtn addTarget:self action:@selector(eRCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    erCodeBtn.tag = 510003;
    UIBarButtonItem *erCodeItem = [[UIBarButtonItem alloc] initWithCustomView:erCodeBtn];
    [self setRightBarButtonItem:erCodeItem];
    
}
- (void)backAction {
    
    [self popViewController];
}
- (void)eRCodeAction :(UIButton *)sender{
    
    ERCodeController* erVC = [[ERCodeController alloc] init];
    [self pushViewController:erVC animated:YES];
}
/**
 *  初始化segmentControl
 */
- (UISegmentedControl *)setupSegment{
    NSArray *items = @[@"聊天", @"通讯录"];
    UISegmentedControl *sgc = [[UISegmentedControl alloc] initWithItems:items];
    [sgc setWidth:70* autoLayoutX forSegmentAtIndex:0];
    [sgc setWidth:70* autoLayoutX forSegmentAtIndex:1];
    NSDictionary *dic = @{
                          //1.设置字体样式:例如黑体,和字体大小
                          NSFontAttributeName:[UIFont systemFontOfSize:11]};
    [sgc setTitleTextAttributes:dic forState:UIControlStateNormal];
    sgc.tintColor = kBlackColor;
    //默认选中的位置
    sgc.selectedSegmentIndex = 0;
    //监听点击
    [sgc addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    return sgc;
}

- (void)segmentChange:(UISegmentedControl *)sgc{
    //NSLog(@"%ld", sgc.selectedSegmentIndex);
    self.index = sgc.selectedSegmentIndex;
    switch (sgc.selectedSegmentIndex) {
        case 0:
            [self replaceFromOldViewController:self.chatAddressController toNewViewController:self.dialogListComtroller];
            break;
        case 1:
            [self replaceFromOldViewController:self.dialogListComtroller toNewViewController:self.chatAddressController];
            break;
        default:
            break;
    }
}
/**
 *  实现控制器的切换
 *
 *  @param oldVc 当前控制器
 *  @param newVc 要切换到的控制器
 */
- (void)replaceFromOldViewController:(XYViewController *)oldVc toNewViewController:(XYViewController *)newVc{
    /**
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController    当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options              动画效果(渐变,从下往上等等,具体查看API)UIViewAnimationOptionTransitionCrossDissolve
     *  animations            转换过程中得动画
     *  completion            转换完成
     */
    [self addChildViewController:newVc];
    [self transitionFromViewController:oldVc toViewController:newVc duration:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newVc didMoveToParentViewController:self];
            [oldVc willMoveToParentViewController:nil];
            [oldVc removeFromParentViewController];
            self.currentVC = newVc;
        }else{
            self.currentVC = oldVc;
        }
    }];
}
@end
