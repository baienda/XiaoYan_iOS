//
//  MineProfileController.m
//  孝颜
//
//  Created by benjamin on 2017/8/11.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "MineProfileController.h"

#import "MineProfileCell.h"

@interface MineProfileController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation MineProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kTableViewBackgroundColor;
    [self setNavigationBar];
    [self addTableView];
}
- (void)setNavigationBar{
    
    [self setTitleText: Localized(@"个人信息")];
    [self setBackButton:BackStyleBlack action:@selector(backAction)];
    
}
- (void)backAction {
    
    [self popViewController];
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
    
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 50* autoLayoutY;
    }else
        return 40* autoLayoutY;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        MineProfileCell *cell = [MineProfileCell cell:tableView];
        cell.titleView.text = Localized(@"头像");
        cell.subTitleView.hidden = YES;
        cell.qrView.hidden = YES;
        cell.arrowView.hidden = YES;
        cell.upLine.hidden = NO;
        cell.downLine.hidden = NO;
        cell.iconView.hidden = NO;
        [cell.iconView setThumbnailWithURL:@"https://n.sinaimg.cn/news/transform/20170807/E6wL-fyitamv6457474.jpg" completion:nil];
        cell.subTitleTrailing.constant = 40;
        return cell;
    }
    if (indexPath.row == 1) {
        MineProfileCell *cell = [MineProfileCell cell:tableView];
        cell.titleView.text = Localized(@"昵称");
        cell.subTitleView.text = @"haha";
        cell.subTitleView.hidden = NO;
        cell.qrView.hidden = YES;
        cell.arrowView.hidden = NO;
        cell.upLine.hidden = YES;
        cell.downLine.hidden = NO;
        cell.iconView.hidden = YES;
        cell.subTitleTrailing.constant = 40;
        return cell;
    }
    if (indexPath.row == 2) {
        MineProfileCell *cell = [MineProfileCell cell:tableView];
        cell.titleView.text = Localized(@"真实姓名");
        cell.subTitleView.text = @"苗天宇";
        cell.subTitleView.hidden = NO;
        cell.qrView.hidden = YES;
        cell.arrowView.hidden = NO;
        cell.upLine.hidden = YES;
        cell.downLine.hidden = NO;
        cell.iconView.hidden = YES;
        cell.subTitleTrailing.constant = 40;
        return cell;
    }
    if (indexPath.row == 3) {
        MineProfileCell *cell = [MineProfileCell cell:tableView];
        cell.titleView.text = Localized(@"我的社区");
        cell.subTitleView.text = @"水光十色";
        cell.subTitleView.hidden = NO;
        cell.qrView.hidden = YES;
        cell.arrowView.hidden = NO;
        cell.upLine.hidden = YES;
        cell.downLine.hidden = NO;
        cell.iconView.hidden = YES;
        cell.subTitleTrailing.constant = 40;
        return cell;
    }
    if (indexPath.row == 4) {
        MineProfileCell *cell = [MineProfileCell cell:tableView];
        cell.titleView.text = Localized(@"孝颜账号");
        cell.subTitleView.text = @"17610996693";
        cell.subTitleView.hidden = NO;
        cell.qrView.hidden = YES;
        cell.arrowView.hidden = YES;
        cell.upLine.hidden = YES;
        cell.downLine.hidden = NO;
        cell.iconView.hidden = YES;
        cell.subTitleTrailing.constant = 15;
        return cell;
    }
    if (indexPath.row == 5) {
        
        MineProfileCell *cell = [MineProfileCell cell:tableView];
        cell.titleView.text = Localized(@"我的二维码");
        cell.subTitleView.hidden = YES;
        cell.qrView.hidden = NO;
        cell.arrowView.hidden = NO;
        cell.upLine.hidden = YES;
        cell.downLine.hidden = NO;
        cell.iconView.hidden = YES;
        cell.subTitleTrailing.constant = 40;
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    if (indexPath.section == 0) {
    //        if (indexPath.row == 0) {
    //
    //        }
    //        if (indexPath.row == 1) {
    //
    //        }
    //    }
    //    if (indexPath.section == 1) {
    //        if (indexPath.row == 0) {
    //
    //        }
    //        if (indexPath.row == 1) {
    //
    //        }
    //        if (indexPath.row == 2) {
    //
    //        }
    //    }
    //    if (indexPath.section == 2) {
    //        if (indexPath.row == 0) {
    //
    //        }
    //    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 8.0f;
}
@end
