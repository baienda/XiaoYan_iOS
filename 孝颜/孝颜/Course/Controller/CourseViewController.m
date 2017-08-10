//
//  CourseViewController.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "CourseViewController.h"
#import "SelectCityController.h"
#import "CourseDetailsController.h"

@interface CourseViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    BOOL canLoadMoreCourse;
}
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSDictionary* infoDict;

@property (nonatomic, strong) NSMutableArray* mineCourseArray;
@property (nonatomic, strong) NSMutableArray* hotCourseArray;

@property (nonatomic, assign) int offset;

@end

@implementation CourseViewController

- (NSMutableArray *)mineCourseArray
{
    if (!_mineCourseArray) {
        _mineCourseArray = [NSMutableArray array];
    }
    return _mineCourseArray;
}
-(NSMutableArray *)hotCourseArray {
    
    if (!_hotCourseArray) {
        _hotCourseArray = [NSMutableArray array];
    }
    return _hotCourseArray;
}

- (void) refresh {
    
    self.offset = 0;
    canLoadMoreCourse = YES;
    [self addTableView];
    [self initCourseData];
}
- (void)onActived {
    
    self.offset = 0;
    canLoadMoreCourse = YES;
    [self addTableView];
    [self initCourseData];
}
-(void)loadView {
    
    [super loadView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.offset = 0;
    canLoadMoreCourse = YES;
    [self setNavigationBar];
    [self addTableView];
    [self initCourseData];

}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}
- (void)initCourseData {
    
    
}
- (void)initCourseData:(BOOL)beginingRefresh :(BOOL)shouldRemoveArray {
    
}
- (void)setNavigationBar
{
    [self setTitleText:Localized(@"课程")];
    
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
    
    [self presentViewController:selectVC animated:YES];
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
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(initCourseData)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    //上拉加载更多
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.stateLabel.hidden = YES;
    self.tableView.mj_footer = footer;

    //加载本地缓存数据
//    [self addCacheLocalDataList];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else {
        return 17;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 78* autoLayoutY;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HotCourseCell *hotCell = [HotCourseCell cell:tableView];
    [hotCell setImage:@""];
    [hotCell setTitle:Localized(@"儿童创意功课")];
    [hotCell setSubTitle:Localized(@"孝颜总部")];
    [hotCell setTime:Localized(@"05月28日-05月28日")];
    [hotCell setJoinTitle:NO];
    
    return hotCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44* autoLayoutY;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        return 8.0f;
    }else {
        return 0.1f;
    }
    return 0.1f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SIZE.width, 44*autoLayoutY)];
    customView.backgroundColor = kTableGrayColor;
    
    UIButton* bottonView = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottonView setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [bottonView setBackgroundImage:[UIImage imageWithColor:kSelectorColor] forState:UIControlStateHighlighted];
    if (section == 0) {
        [bottonView addTarget:self action:@selector(recommendAllClick) forControlEvents:UIControlEventTouchUpInside];
    }else {
        [bottonView addTarget:self action:@selector(recommendArticleClick) forControlEvents:UIControlEventTouchUpInside];
    }
    [customView addSubview:bottonView];
    [bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44* autoLayoutY);
        make.bottom.mas_equalTo(0);
    }];
    
    UIImageView*icon = [[UIImageView alloc] init];
    if (section == 0) {
        icon.image = [UIImage imageNamed:@"1"];
    }else {
        icon.image = [UIImage imageNamed:@"2"];
    }
    [bottonView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottonView.mas_centerY);
        make.left.mas_equalTo(kLeadingMargin);
        make.width.mas_equalTo(26* autoLayoutX);
        make.height.mas_equalTo(26* autoLayoutY);
    }];
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = kSecondTitleColor;
    headerLabel.font = kFont(16* autoLayoutY);
    [bottonView addSubview:headerLabel];
    
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(icon.mas_right).offset(10);
        make.centerY.mas_equalTo(bottonView.mas_centerY);
        make.width.mas_equalTo(200* autoLayoutY);
    }];
    
    if (section == 0) {
        headerLabel.text = Localized(@"我的课程");
    }else {
        headerLabel.text = Localized(@"热门课程");
    }
    return customView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        MyLog(@"我的课程");
        
    }else {
        CourseDetailsController* detailsVC = [[CourseDetailsController alloc] init];
        [self pushViewController:detailsVC animated:YES];
    }
}
@end
