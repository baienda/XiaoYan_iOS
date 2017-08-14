//
//  SettingRemindController.m
//  孝颜
//
//  Created by benjamin on 2017/8/14.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "SettingRemindController.h"

#import "SettingTextCell.h"
#import "SettingSwitchCell.h"

#import "IMNotice.h"

@interface SettingRemindController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation SettingRemindController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kTableViewBackgroundColor;
    [self setNavigationBar];
    [self addTableView];
}
- (void)setNavigationBar{
    
    [self setTitleText: Localized(@"消息通知")];
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
    _tableView.backgroundColor = kTableViewBackgroundColor;
    _tableView.translatesAutoresizingMaskIntoConstraints = YES;
    //去掉分割线
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:_tableView];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40* autoLayoutY;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        SettingTextCell *cell = [SettingTextCell cell:tableView];
        cell.titleView.text = Localized(@"新消息通知");
        //系统通知状态
        UIUserNotificationSettings *userNotificationSetting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if( userNotificationSetting.types == UIUserNotificationTypeNone )
        {
            //表示系统当前的通知开关是打开的
            cell.subTitleView.text = Localized(@"已关闭");
        }else{
            cell.subTitleView.text = Localized(@"已开启");
        }
        return cell;
    }
    if (indexPath.section == 1) {
        SettingSwitchCell *cell = [SettingSwitchCell cell:tableView];
        cell.titleView.text = Localized(@"聊天音效");
        [cell.switchView addTarget:self action:@selector(noticeSwitchIsChanged:) forControlEvents:UIControlEventValueChanged];
        
        if ([IMNotice canMessage]) {
            
            [cell.switchView setOn:NO animated:YES];
        }else{
            [cell.switchView setOn:YES animated:YES];
        }
        return cell;
    }
    if (indexPath.section == 2) {
        SettingSwitchCell *cell = [SettingSwitchCell cell:tableView];
        cell.titleView.text = Localized(@"通知声音");
        [cell.switchView addTarget:self action:@selector(soundSwitchIsChanged:) forControlEvents:UIControlEventValueChanged];
        
        if ([IMNotice canSound]) {
            
            [cell.switchView setOn:NO animated:YES];
        }else{
            [cell.switchView setOn:YES animated:YES];
        }
        return cell;
    }
    if (indexPath.section == 3) {
        SettingSwitchCell *cell = [SettingSwitchCell cell:tableView];
        cell.titleView.text = Localized(@"通知振动");
        [cell.switchView addTarget:self action:@selector(vibrateSwitchIsChanged:) forControlEvents:UIControlEventValueChanged];
        
        if ([IMNotice canVibrate]) {
            
            [cell.switchView setOn:NO animated:YES];
        }else{
            [cell.switchView setOn:YES animated:YES];
        }
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 70* autoLayoutY;

}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView* customView = [[UIView alloc] init];
    customView.frame = CGRectMake(0, 0, DEVICE_SIZE.width, 70* autoLayoutY);
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = kColor(169, 169, 179);
    headerLabel.font = kFont(14* autoLayoutY);
    headerLabel.numberOfLines = 0;
    headerLabel.textAlignment = NSTextAlignmentLeft;
    [customView addSubview:headerLabel];
    
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(customView.mas_top).offset(13);
        make.left.mas_equalTo(customView.mas_left).offset(kLeadingMargin);
        make.right.mas_equalTo(customView.mas_right).offset(-kLeadingMargin);
    }];
    
    if (section == 0){
        headerLabel.text = Localized(@"如果你要关闭或开启孝颜的新消息通知，请在iPhone的“设置“-”通知“功能中，找到应用程序孝颜更改。");
    }else if (section == 1){
        headerLabel.text = Localized(@"开启时，将在聊天时播放发送消息和接受消息的提示音。");
    }else if (section == 2){
        headerLabel.text = Localized(@"开启时，在其他页面接受消息时将播放提示音。");
    }else if (section == 3){
        headerLabel.text = Localized(@"开启时，在其他页面收到消息时将振动一下。");
    }
    return customView;
}
#pragma mark - Action -
- (void)noticeSwitchIsChanged:(UISwitch *)paramSender{
    
    [IMNotice setCanMessage:[IMNotice canMessage]];
}
- (void)soundSwitchIsChanged:(UISwitch *)paramSender{
    
    [IMNotice setCanSound:[IMNotice canSound]];
}
- (void)vibrateSwitchIsChanged:(UISwitch *)paramSender{
    
    [IMNotice setCanVibrate:[IMNotice canVibrate]];
}

@end
