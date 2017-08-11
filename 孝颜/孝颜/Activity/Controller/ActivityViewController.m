//
//  ActivityViewController.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityDetailsController.h"
#import "SelectCityController.h"

#import "ActivityCell.h"

@interface ActivityViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    BOOL canLoadMoreActivity;
}
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSDictionary* infoDict;

@property (nonatomic, strong) NSMutableArray* activityArray;

@property (nonatomic, assign) int offset;

@end

@implementation ActivityViewController

-(NSMutableArray *)activityArray {
    
    if (!_activityArray) {
        _activityArray = [NSMutableArray array];
    }
    return _activityArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self setNavigationBar];
    [self addTableView];
}
- (void)setNavigationBar{
    
    [self setTitleText: Localized(@"活动")];
    UIButton *cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cityBtn.bounds = CGRectMake(0, 0, 29, 29);
    [cityBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [cityBtn setTitleColor:kGlobalColor forState:UIControlStateNormal];
    cityBtn.titleLabel.font = kFont(14* autoLayoutY);
    [cityBtn addTarget:self action:@selector(cityBtnAction) forControlEvents:UIControlEventTouchUpInside];
    cityBtn.tag = 510002;
    UIBarButtonItem *cityItem = [[UIBarButtonItem alloc] initWithCustomView:cityBtn];
    [self setLeftBarButtonItem:cityItem];
}
- (void)cityBtnAction {
    
    SelectCityController* selectVC = [[SelectCityController alloc] init];
    XYNavigationController *navigation = [XYNavigationController navigationControllerWithControllers:@[selectVC]];
    [self presentViewController:navigation animated:YES];
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
    
    return 390* autoLayoutY;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ActivityCell *activityCell = [ActivityCell cell:tableView];
    [activityCell setImage:@""];
    [activityCell setTitle:Localized(@"孝亲敬老（石家营）")];
    [activityCell setSubTitleAndTime:Localized(@"石家营村委会 | 08月05日 15:30")];
    [activityCell setJoinTitle:NO];
    [activityCell setTag:Localized(@"孝亲敬老")];
    
    return activityCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityDetailsController* detailsVC = [[ActivityDetailsController alloc] init];
    [self pushViewController:detailsVC animated:YES];
}
@end
