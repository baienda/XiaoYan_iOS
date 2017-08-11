//
//  MineViewController.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "MineViewController.h"

#import "MineBaseCell.h"

#import "FTPopOverMenu.h"


@interface MineViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView     *tableView;
@property(nonatomic, strong)UIImageView     *headerBackView;//头像背景图片
@property(nonatomic, strong)UIImageView     *photoImageView;//头像图片
@property(nonatomic, strong)UIImageView     *leaguerImageView;//会员图片
@property(nonatomic, strong)UILabel         *userNameLabel;//用户名label
@property(nonatomic, strong)UILabel         *introduceLabel;//简介label

@property(nonatomic, strong)UILabel         *allServiceLabel;//总服务时长
@property(nonatomic, strong)UILabel         *allServiceNumLabel;//总服务时长数
@property(nonatomic, strong)UILabel         *allGemLabel;//宝石
@property(nonatomic, strong)UILabel         *allGemNumLabel;//宝石数
@property(nonatomic, strong)UILabel         *xiaoYanLabel;//孝颜币
@property(nonatomic, strong)UILabel         *xiaoYanNumLabel;//孝颜币数
@property(nonatomic, strong)UIView          *tableViewHeaderView;//tableView头部视图
@property(nonatomic, assign)NSInteger       imageHeight;//背景图片的高度

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageHeight = 240;// 背景图片的高度
    
    self.view.backgroundColor = kWhiteColor;
    [self setNavigationBar];
    [self addTableView];
    [self createTableViewHeaderView];
}
- (void)setNavigationBar{
    
    [self setTitleText: Localized(@"我")];
    
    UIButton *cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cityBtn.bounds = CGRectMake(0, 0, 29, 29);
    [cityBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [cityBtn setTitleColor:kGlobalColor forState:UIControlStateNormal];
    cityBtn.titleLabel.font = kFont(14* autoLayoutY);
    [cityBtn addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    cityBtn.tag = 510002;
    UIBarButtonItem *cityItem = [[UIBarButtonItem alloc] initWithCustomView:cityBtn];
    [self setRightBarButtonItem:cityItem];
    
}
- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64 - 49* autoLayoutY) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kTableGrayColor;
    _tableView.translatesAutoresizingMaskIntoConstraints = YES;
    //去掉分割线
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:_tableView];
}
#pragma mark - 创建头视图
- (void)createTableViewHeaderView
{
    _tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SIZE.width, _imageHeight)];
    
    // 背景图
    _headerBackView = [[UIImageView alloc] init];
    _headerBackView.frame = CGRectMake(0, 0, DEVICE_SIZE.width, _imageHeight);
    [_headerBackView setThumbnailWithURL:@"https://n.sinaimg.cn/news/20170808/u1kQ-fyitapv9390785.jpg" completion:nil];
    [_tableViewHeaderView addSubview:_headerBackView];
    
    // 头像
    _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((DEVICE_SIZE.width - 100) / 2, 50, 100, 100)];
    [self.tableViewHeaderView addSubview:self.photoImageView];
    _photoImageView.layer.cornerRadius = 50;
    _photoImageView.layer.masksToBounds = YES;
    [_photoImageView setThumbnailWithURL:@"https://n.sinaimg.cn/news/transform/20170807/E6wL-fyitamv6457474.jpg" completion:nil];
    
    // 用户名
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_photoImageView.frame) + 10, DEVICE_SIZE.width, 20)];
    _userNameLabel.font = [UIFont systemFontOfSize:16];
    _userNameLabel.text = @"JRS";
    _userNameLabel.textAlignment = 1;
    _userNameLabel.textColor = [UIColor whiteColor];
    [_tableViewHeaderView addSubview:self.userNameLabel];
    
    // 简介
    _introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_userNameLabel.frame) + 10, DEVICE_SIZE.width, 20)];
    _introduceLabel.alpha = 0.7;
    _introduceLabel.text = @"他强任他强,我干我的羊";
    _introduceLabel.textAlignment = 1;
    _introduceLabel.font = [UIFont systemFontOfSize:12];
    _introduceLabel.textColor = [UIColor whiteColor];
    [_tableViewHeaderView addSubview:_introduceLabel];
    
    self.tableView.tableHeaderView = _tableViewHeaderView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = self.view.frame.size.width;// 图片的宽度
    CGFloat yOffset = scrollView.contentOffset.y;// 偏移的y值
//    NSLog(@"%f",yOffset);
    if (yOffset < 0) {
        CGFloat totalOffset = _imageHeight + ABS(yOffset);
        CGFloat f = totalOffset / _imageHeight;
        self.headerBackView.frame = CGRectMake(- (width * f - width) / 2, yOffset, width * f, totalOffset);// 拉伸后的图片的frame应该是同比例缩放
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 3;
    }else {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50* autoLayoutY;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MineBaseCell *baseCell = [MineBaseCell cell:tableView];
            baseCell.icon.image = [UIImage imageNamed:@"2"];
            baseCell.title.text = Localized(@"我的订单");
            baseCell.underline.hidden = NO;
            return baseCell;
        }
        if (indexPath.row == 1) {
            MineBaseCell *baseCell = [MineBaseCell cell:tableView];
            baseCell.icon.image = [UIImage imageNamed:@"1"];
            baseCell.title.text = Localized(@"我的活动");
            baseCell.underline.hidden = YES;
            return baseCell;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            MineBaseCell *baseCell = [MineBaseCell cell:tableView];
            baseCell.icon.image = [UIImage imageNamed:@"2"];
            baseCell.title.text = Localized(@"聊天");
            baseCell.underline.hidden = NO;
            return baseCell;
        }
        if (indexPath.row == 1) {
            MineBaseCell *baseCell = [MineBaseCell cell:tableView];
            baseCell.icon.image = [UIImage imageNamed:@"1"];
            baseCell.title.text = Localized(@"圈子");
            baseCell.underline.hidden = NO;
            return baseCell;
        }
        if (indexPath.row == 2) {
            
            MineBaseCell *baseCell = [MineBaseCell cell:tableView];
            baseCell.icon.image = [UIImage imageNamed:@"2"];
            baseCell.title.text = Localized(@"通知");
            baseCell.underline.hidden = YES;
            return baseCell;
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            
            MineBaseCell *baseCell = [MineBaseCell cell:tableView];
            baseCell.icon.image = [UIImage imageNamed:@"1"];
            baseCell.title.text = Localized(@"服务队");
            baseCell.underline.hidden = YES;
            return baseCell;
        }
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
    
    if (section == 0) {
        return 10;
    }else
        return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 8.0f;
}
- (void)settingAction:(UIButton *)sender{
    
    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    configuration.textColor = kWhiteColor;
    configuration.textFont = kFont(16* autoLayoutY);
    configuration.tintColor = kBlackColor;
    configuration.borderColor = kBlackColor;
    configuration.textAlignment = NSTextAlignmentLeft;
    [FTPopOverMenu showForSender:sender
                   withMenuArray:@[Localized(@"提醒设置"),Localized(@"修改密码"),Localized(@"分享给好友"),Localized(@"退出登录")]
                      imageArray:@[@"1", @"1", @"1", @"1"]
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           switch (selectedIndex) {
                               case 0:
                                   [self setRemind];
                                   break;
                               case 1:
                                   [self setPassword];
                                   break;
                               case 2:
                                   [self setShare];
                                   break;
                               case 3:
                                   [self setLogOut];
                                   break;
                               default:
                                   break;
                           }
                       } dismissBlock:^{
                       }];
}
- (void)setRemind{
    
    
}
- (void)setPassword{
 
    
}
- (void)setShare{
    
    
}
- (void)setLogOut{
    
    
}

@end
