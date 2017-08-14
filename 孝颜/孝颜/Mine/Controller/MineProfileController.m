//
//  MineProfileController.m
//  孝颜
//
//  Created by benjamin on 2017/8/11.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "MineProfileController.h"
#import "NicknameController.h"
#import "RealNameController.h"

#import "MineProfileCell.h"

@interface MineProfileController ()<UITableViewDataSource, UITableViewDelegate,UIActionSheetDelegate>

@property(nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong) NSDictionary* infoDict;

@property (nonatomic, copy) NSString* nickName;
@property (nonatomic, copy) NSString* pushNickName;
@property (nonatomic, copy) NSString* realName;
@property (nonatomic, copy) NSString* pushRealName;

@end

@implementation MineProfileController

- (NSDictionary *)infoDict
{
    if (!_infoDict) {
        _infoDict = [NSDictionary dictionary];
    }
    return _infoDict;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kTableViewBackgroundColor;
    [self setNavigationBar];
    //测试
    self.nickName = @"大力出奇迹";
    self.realName = @"苗天宇";
    [self addTableView];
}
- (void)setNavigationBar{
    
    [self setTitleText: Localized(@"个人信息")];
    [self setBackButton:BackStyleBlack action:@selector(backAction)];
    
}
- (void)backAction {
    
    [self popViewController];
}
- (void)initNickNameData {
    
    MyLog(@"上传到服务器");
//    ProfileParams* params = [ProfileParams alloc];
//    params.nickname = self.nickName;
//    [ApiClient upDateProfileSuccess:^(id JSON) {
//        
//        MyLog(@"%@",JSON);
//        
//        [self setUpSuccessHUD];
//        
//#pragma mark - 通知MineBaseVC刷新UI
//        NSNotification * notice = [NSNotification notificationWithName:@"mineBaseInitDataNotice" object:nil userInfo:nil];
//        //发送消息
//        [[NSNotificationCenter defaultCenter]postNotification:notice];
//        
//        //保存nick到本地
//        NSString* avatar = [[NSUserDefaults standardUserDefaults]objectForKey:kUserDefaultsEMExtKey][@"avatar"];
//        NSDictionary* newDict = [NSDictionary dictionaryWithObjectsAndKeys:avatar,@"avatar",self.nickName,@"nickname",nil];
//        [[NSUserDefaults standardUserDefaults] setObject:newDict forKey:kUserDefaultsEMExtKey];
//        
//#pragma mark - 通知localMineVC刷新UI
//        NSNotification * notice2 = [NSNotification notificationWithName:@"localMineInitDataNotice" object:nil userInfo:nil];
//        //发送消息
//        [[NSNotificationCenter defaultCenter]postNotification:notice2];
//        
//#pragma mark - 通知LocalVC刷新UI
//        NSNotification * notice3 = [NSNotification notificationWithName:@"nearbyInitDataNotice" object:nil userInfo:nil];
//        //发送消息
//        [[NSNotificationCenter defaultCenter]postNotification:notice3];
//        
//        //首页下拉刷新逻辑
//        [[NSUserDefaults standardUserDefaults]setObject:@(YES) forKey:kUserDefaultsRefreshStatus];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//        
//    } andFailure:^(id error) {
//        if([self handlerError:error] == FALSE){}
//    } andParams:params];
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
        //昵称逻辑判断
        if (self.nickName == nil || self.nickName == NULL) {
            cell.subTitleView.text = self.infoDict[@"nickname"];
        }else {
            cell.subTitleView.text = self.nickName;
        }
        self.pushNickName = cell.subTitleView.text;
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
        //姓名逻辑判断
        if (self.realName == nil || self.realName == NULL) {
            cell.subTitleView.text = self.infoDict[@"realname"];
        }else {
            cell.subTitleView.text = self.realName;
        }
        self.pushRealName = cell.subTitleView.text;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    if (indexPath.row == 0) {
        //修改头像
        [self actionSheetAction];
    }
    if (indexPath.row == 1) {
        //昵称
        [self nicknameAction];
    }
    if (indexPath.row == 2) {
        //真实姓名
        [self realnameAction];
    }
    if (indexPath.row == 3) {
        //社区
        [self communityAction];
    }
    if (indexPath.row == 5) {
        //二维码
        [self erCodeAction];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 8.0f;
}
#pragma mark - Action
- (void)actionSheetAction {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"修改头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;//默认风格，灰色背景，白色文字
    [actionSheet showInView:self.view];
}
- (void)nicknameAction {
    
    NicknameController* nickVC = [[NicknameController alloc] init];
    WS(weakSelf);
    nickVC.SelectArrBlock = ^(NSString *text){
        MyLog(@"%@",text);
        weakSelf.nickName = text;
        [weakSelf.tableView reloadData];
//        [weakSelf initNickNameData];
    };
    nickVC.mineNicknameTextfield.text = [NSString stringWithFormat:@"%@",self.pushNickName];
    
    [self pushViewController:nickVC animated:YES];

}
- (void)realnameAction {
    
    RealNameController* nameVC = [[RealNameController alloc] init];
    WS(weakSelf);
    nameVC.SelectArrBlock = ^(NSString *text){
        MyLog(@"%@",text);
        weakSelf.realName = text;
        [weakSelf.tableView reloadData];
//        [weakSelf initNickNameData];
    };
    nameVC.mineRealnameTextfield.text = [NSString stringWithFormat:@"%@",self.pushRealName];
    
    [self pushViewController:nameVC animated:YES];
}
- (void)communityAction {
    
    
}
- (void)erCodeAction {
    
    
}
#pragma mark - UIActionSheetDelegate
//根据被点击的按钮做出反应，0对应destructiveButton，之后的button依次排序
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        //拍照
    }
    else if (buttonIndex == 2) {
        //相册
    }
}
@end
