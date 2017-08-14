//
//  SelectCommunityController.m
//  孝颜
//
//  Created by benjamin on 2017/8/14.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "SelectCommunityController.h"

#import "CommunityCell.h"

@interface SelectCommunityController ()<UITableViewDataSource, UITabBarDelegate>

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation SelectCommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kTableViewBackgroundColor;
    [self setNavigationBar];
    [self addTableView];
    
}
- (void)setNavigationBar{
    
    [self setTitleText: Localized(@"选择社区")];
    [self setBackButton:BackStyleBlack action:@selector(backAction)];
    
}
- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 20, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kTableGrayColor;
    _tableView.translatesAutoresizingMaskIntoConstraints = YES;
    //去掉分割线
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:_tableView];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50* autoLayoutY;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CommunityCell *cell = [CommunityCell cell:tableView];
    [cell setTitle:Localized(@"水光十色")];
    [cell setSubTitle:Localized(@"北京 北京市 顺义区")];
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //执行逻辑
    if (self.SelectArrBlock) {
        self.SelectArrBlock(@"回调");
    }
    [self popViewController];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 8.0f;
}
#pragma mark - diAction -
- (void)backAction {
    
    [self popViewController];
}
@end
