//
//  VideoTypeDetailController.m
//  孝颜
//
//  Created by benjamin on 2017/8/11.
//  Copyright © 2017年 com.baienda. All rights reserved.
//
/*
 结构：
 视频播放器
 header：webView + view
 评论tableview
 */
#import "VideoTypeDetailController.h"

@interface VideoTypeDetailController ()

@end


@implementation VideoTypeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self setNavigationBar];
    [self setERPlayer];
}
- (void)setNavigationBar {
    
    [self setTitleText:Localized(@"视频分类详情")];
    [self setBackButton:BackStyleBlack action:@selector(backAction)];
    
}
- (void)setERPlayer {
    
//    ERPlayer *player = [ERPlayer new];
//    player.frame = CGRectMake(0, 64, DEVICE_SIZE.width, DEVICE_SIZE.width / 16 * 9);
//    NSURL *viedoUrl = [NSURL URLWithString:@"http://2449.vod.myqcloud.com/2449_22ca37a6ea9011e5acaaf51d105342e3.f20.mp4"];
//    [player setViedoUrl:viedoUrl];
//    [self.view addSubview:player];
    
}
- (void)backAction {
    
    [self popViewController];
}
@end
