//
//  VideoViewController.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoTypeController.h"
#import "VideoTypeDetailController.h"

#import "VideoHotTypeCell.h"
#import "VideoHotTypeHeaderView.h"

#import "VideoNewsModel.h"

#import "JKScrollFocus.h"

@interface VideoViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)JKScrollFocus *scroller;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self setNavigationBar];
    //添加网格视图
    [self setCollectionView];
    
    //轮播
//    [self setJKScrollFocus];
}
- (void)setNavigationBar{
    
    [self setTitleText: Localized(@"视频")];
}
- (void)setCollectionView {
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat itemWidth =(DEVICE_SIZE.width- 3)/2;
    CGFloat itemHeight = (DEVICE_SIZE.width- 3)/2;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    flowLayout.minimumLineSpacing = 3.0f;
    flowLayout.minimumInteritemSpacing = 0.0f;
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    self.collectionView.backgroundColor = kBuleColor;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_SIZE.width, DEVICE_SIZE.height - 64) collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.scrollEnabled = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:@"VideoHotTypeCell" bundle:nil] forCellWithReuseIdentifier:@"VideoHotTypeCell"];
    [self.collectionView registerClass:[VideoHotTypeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"VideoHotTypeHeaderView"];
    
    [self.view addSubview:self.collectionView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(initVidepData)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
}
- (void)setJKScrollFocus{
    
    JKScrollFocus* scroller = [[JKScrollFocus alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SIZE.width, 200* autoLayoutY)];
    NSMutableArray *firstArray = [NSMutableArray array];
    NSArray *imageAray = @[@"https://n.sinaimg.cn/news/transform/20170810/YtpF-fyixiar9015795.jpg",
                           @"https://n.sinaimg.cn/news/transform/20170810/ifsv-fyixhyw6769798.jpg",
                           @"https://n.sinaimg.cn/news/transform/20170807/E6wL-fyitamv6457474.jpg",
                           @"https://n.sinaimg.cn/news/20170808/u1kQ-fyitapv9390785.jpg"];
    NSArray *titleArray = @[@"轮播title0",@"轮播title11",@"轮播title22",@"轮播title33"];
    NSArray *subTitleArray = @[@"轮播title0",@"轮播title11",@"轮播title22",@"轮播title33"];
    //造假数据
    for (int i=0;i<[imageAray count];i++) {
        VideoNewsModel *n = [[VideoNewsModel alloc]init];
        n.imageURL = [imageAray objectAtIndex:i];
        n.title = [titleArray objectAtIndex:i];
        n.subTitle = [subTitleArray objectAtIndex:i];
        [firstArray addObject:n];
    }
    
    scroller.items = firstArray;
    scroller.autoScroll = YES;
#pragma mark - 轮播图点击回调 -
    [scroller didSelectJKScrollFocusItem:^(id item,NSInteger index) {
        NSLog(@"click %ld,item:%@",index,item);
        VideoTypeDetailController* detailVC = [[VideoTypeDetailController alloc] init];
        [self pushViewController:detailVC animated:YES];
    }];
    [scroller downloadJKScrollFocusItem:^(id item, UIImageView *currentImageView) {
        VideoNewsModel *n = item;
        [currentImageView setThumbnailWithURL:n.imageURL completion:nil];
    }];
    [scroller titleForJKScrollFocusItem:^NSString *(id item, UILabel *currentLabel) {
        VideoNewsModel *n = item;
        return n.title;
    }];
    self.scroller = scroller;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VideoHotTypeCell *cell=(VideoHotTypeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"VideoHotTypeCell" forIndexPath:indexPath];
    [cell.photo setThumbnailWithURL:@"https://n.sinaimg.cn/news/20170808/u1kQ-fyitapv9390785.jpg" completion:nil];
    cell.title.text = @"#社区活动";
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    VideoHotTypeCell *cell = (VideoHotTypeCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    //执行动画
//    [cell setAni];
    
    VideoTypeController* typeVC = [[VideoTypeController alloc] init];
    [self pushViewController:typeVC animated:YES];
    
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView =nil;
    
    if (kind ==UICollectionElementKindSectionHeader) {
        //定制头部视图的内容
        VideoHotTypeHeaderView *headerV = (VideoHotTypeHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"VideoHotTypeHeaderView"forIndexPath:indexPath];
        [self setJKScrollFocus];
        [headerV addSubview:self.scroller];
        reusableView = headerV;
    }
    return reusableView;
}
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize headerSize = CGSizeMake(DEVICE_SIZE.width, 200* autoLayoutY + 40* autoLayoutY);
    return headerSize;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 14;
}
@end
