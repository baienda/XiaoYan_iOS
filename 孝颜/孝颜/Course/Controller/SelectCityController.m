//
//  SelectCityController.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "SelectCityController.h"
#import "SelectCityCell.h"

@interface SelectCityController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSDictionary* infoDict;

@property (nonatomic, strong) NSMutableArray* cityArray;

@end

@implementation SelectCityController

-(NSMutableArray *)cityArray {
    
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self addTableView];
    
}
-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}
- (void)setNavigationBar
{
    [self setTitleText:Localized(@"课程")];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.bounds = CGRectMake(0, 0, 29, 29);
    [backBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [backBtn setTitleColor:kGlobalColor forState:UIControlStateNormal];
    backBtn.titleLabel.font = kFont(14* autoLayoutY);
    [backBtn addTarget:self action:@selector(dissmissBtnAction) forControlEvents:UIControlEventTouchUpInside];
    backBtn.tag = 510002;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [self setLeftBarButtonItem:backItem];
}
- (void)dissmissBtnAction {
    
    [self dismissViewController];
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
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40* autoLayoutY;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SelectCityCell *hotCell = [SelectCityCell cell:tableView];
    NSString* city;
    if (indexPath.row == 0) {
        city = Localized(@"北京");
    }else {
        city = Localized(@"上海");
    }
    [hotCell setTitle:city];
    
    return hotCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44* autoLayoutY;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SIZE.width, 44*autoLayoutY)];
    customView.backgroundColor = kTableGrayColor;

    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = kSecondTitleColor;
    headerLabel.font = kFont(12* autoLayoutY);
    headerLabel.text = Localized(@"热门城市");

    [customView addSubview:headerLabel];
    
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kLeadingMargin);
        make.centerY.mas_equalTo(customView.mas_centerY);
        make.width.mas_equalTo(200* autoLayoutY);
    }];
    return customView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissViewController];
}
@end
