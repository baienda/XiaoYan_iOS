//
//  VideoViewController.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "VideoViewController.h"

#import "VideoNewsModel.h"

#import "JKScrollFocus.h"



@interface VideoViewController ()

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self setNavigationBar];
    //轮播
    [self setJKScrollFocus];
}
- (void)setNavigationBar{
    
    [self setTitleText: Localized(@"视频")];
}
- (void)setJKScrollFocus {
    
    JKScrollFocus *scroller = [[JKScrollFocus alloc] initWithFrame:CGRectMake(0, 64, DEVICE_SIZE.width, 200)];
    //imageArray 也可以传入网络图片地址数组
    //这里我使用SDWebImage进行加载网络图片,可以使用自己的方法
    
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
    [scroller didSelectJKScrollFocusItem:^(id item,NSInteger index) {
        NSLog(@"click %ld,item:%@",index,item);
    }];
    [scroller downloadJKScrollFocusItem:^(id item, UIImageView *currentImageView) {
        VideoNewsModel *n = item;
        [currentImageView setThumbnailWithURL:n.imageURL completion:nil];
    }];
    [scroller titleForJKScrollFocusItem:^NSString *(id item, UILabel *currentLabel) {
        VideoNewsModel *n = item;
        return n.title;
    }];
    [self.view addSubview:scroller];
}

@end
