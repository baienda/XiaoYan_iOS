//
//  ChatAddressController.m
//  孝颜
//
//  Created by benjamin on 2017/8/15.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "ChatAddressController.h"

#import "BaseContactCell.h"

#import "ContactModel.h"

#import "ContactDataHelper.h"//根据拼音A~Z~#进行排序的tool

@interface ChatAddressController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *_rowArr;//row arr
    NSArray *_sectionArr;//section arr
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *serverDataArr;//数据源
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation ChatAddressController

#pragma mark - dataArr(模拟从服务器获取到的数据)
- (NSArray *)serverDataArr{
    if (!_serverDataArr) {
        _serverDataArr=@[@{@"portrait":@"1",@"name":@"1"},@{@"portrait":@"2",@"name":@"花无缺"},@{@"portrait":@"3",@"name":@"东方不败"},@{@"portrait":@"4",@"name":@"任我行"},@{@"portrait":@"5",@"name":@"逍遥王"},@{@"portrait":@"6",@"name":@"阿离"},@{@"portrait":@"13",@"name":@"百草堂"},@{@"portrait":@"8",@"name":@"三味书屋"},@{@"portrait":@"9",@"name":@"彩彩"},@{@"portrait":@"10",@"name":@"陈晨"},@{@"portrait":@"11",@"name":@"多多"},@{@"portrait":@"12",@"name":@"峨嵋山"},@{@"portrait":@"7",@"name":@"哥哥"},@{@"portrait":@"14",@"name":@"林俊杰"},@{@"portrait":@"15",@"name":@"足球"},@{@"portrait":@"16",@"name":@"58赶集"},@{@"portrait":@"17",@"name":@"搜房网"},@{@"portrait":@"18",@"name":@"欧弟"}];
    }
    return _serverDataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kTableViewBackgroundColor;
    
    self.dataArr=[NSMutableArray array];
    for (NSDictionary *subDic in self.serverDataArr) {
        ContactModel *model=[[ContactModel alloc]initWithDic:subDic];
        [self.dataArr addObject:model];
    }
    _rowArr=[ContactDataHelper getFriendListDataBy:self.dataArr];
    _sectionArr=[ContactDataHelper getFriendListSectionBy:[_rowArr mutableCopy]];
    
    [self addTableView];
}
- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kTableGrayColor;
    _tableView.translatesAutoresizingMaskIntoConstraints = YES;
    //去掉分割线
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //索引
    _tableView.sectionIndexColor = kGrayColor;
    _tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_tableView];
}
#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //section
    return _rowArr.count + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //row
    
    if (section == 0) {
        return 3;
    }else{
        return [_rowArr[section - 1] count];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50* autoLayoutY;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //viewforHeader
    if (section == 0) {
        return nil;
    }else {
        id label = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
        if (!label) {
            label = [[UILabel alloc] init];
            [label setFont:[UIFont systemFontOfSize:14.5f]];
            [label setTextColor:[UIColor grayColor]];
            [label setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];
        }
        [label setText:[NSString stringWithFormat:@"  %@",_sectionArr[section]]];
        return label;
    }
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _sectionArr;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index-1;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1f;
    }else{
        return 22.0* autoLayoutY;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1f;
}
#pragma mark - UITableView dataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            BaseContactCell *cell = [BaseContactCell cell:tableView];
            [cell setName:@"新的朋友"];
            [cell setLoaclAvatar:@"1"];
            return cell;
        }
        if (indexPath.row == 1) {
            BaseContactCell *cell = [BaseContactCell cell:tableView];
            [cell setName:@"添加好友"];
            [cell setLoaclAvatar:@"2"];
            return cell;
        }
        if (indexPath.row == 2) {
            BaseContactCell *cell = [BaseContactCell cell:tableView];
            [cell setName:@"群组"];
            [cell setLoaclAvatar:@"2"];
            return cell;
        }
    }else {
        
        BaseContactCell *cell = [BaseContactCell cell:tableView];
        ContactModel *model=_rowArr[indexPath.section - 1][indexPath.row];
        [cell setAvatar:@"https://n.sinaimg.cn/news/transform/20170807/E6wL-fyitamv6457474.jpg"];
        [cell setName:model.name];
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
@end
