//
//  XYRootTableView.h
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYRootTableView : UIView


@property (nonatomic) bool fullScreenDetail;
@property (nonatomic, strong) UIView *masterView;
@property (nonatomic, strong) UIView *detailView;

- (CGRect)rectForDetailViewForFrame:(CGRect)frame;

@end
