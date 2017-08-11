//
//  VideoTypeController.m
//  孝颜
//
//  Created by benjamin on 2017/8/11.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "VideoTypeController.h"
#import "VideoTypeDetailController.h"

#import "VideoTypeCell.h"

@interface VideoTypeController ()<UITableViewDataSource, UITableViewDelegate>
{
    BOOL canLoadMoreActivity;
}
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSDictionary* infoDict;

@property (nonatomic, strong) NSMutableArray* activityArray;

@property (nonatomic, assign) int offset;

@end

@implementation VideoTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self setNavigationBar];
    [self addTableView];
}
- (void)setNavigationBar{
    
    [self setTitleText:Localized(@"视频分类")];
    [self setBackButton:BackStyleBlack action:@selector(backAction)];
    
}
- (void)backAction {
    
    [self popViewController];
}
- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kTableGrayColor;
    _tableView.translatesAutoresizingMaskIntoConstraints = YES;
    //去掉分割线
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:_tableView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(initActivityData)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    //上拉加载更多
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(initActivityData)];
    footer.stateLabel.hidden = YES;
    self.tableView.mj_footer = footer;
    
    //加载本地缓存数据
    //    [self addCacheLocalDataList];
}
- (void)initActivityData {
    
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 17;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200* autoLayoutY;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    VideoTypeCell *videoTypeCell = [VideoTypeCell cell:tableView];
    [videoTypeCell setImage:@"https://n.sinaimg.cn/news/20170808/u1kQ-fyitapv9390785.jpg"];
    [videoTypeCell setTitle:Localized(@"礼仪弟子规课程（石家营）")];
    [videoTypeCell setSubTitle:Localized(@"#孝颜文化 / 1..")];
    
    return videoTypeCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoTypeDetailController* detailsVC = [[VideoTypeDetailController alloc] init];
    [self pushViewController:detailsVC animated:YES];
}

@end
