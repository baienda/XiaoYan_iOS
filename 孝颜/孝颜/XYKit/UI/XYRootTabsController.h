//
//  XYRootTabsController.h
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYTabBarDelegate <NSObject>

- (void)tabBarSelectedItem:(int)index;

@end

@interface XYTabBar : UIView

@property (nonatomic, weak) id<XYTabBarDelegate> tabDelegate;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *stripeView;
@property (nonatomic, strong) NSMutableArray *buttonViews;
@property (nonatomic, strong) NSMutableArray *labelViews;
@property (nonatomic, strong) UILabel *unreadBadgeLabel;
@property (nonatomic, strong) UILabel *momentBadgeLabel;
@property (nonatomic) int selectedIndex;
@property (nonatomic, strong) UIImageView* videoIcon;
@property (nonatomic, strong) UIImageView* videoIconCircle;
@property (nonatomic, assign) BOOL videoAnimating;//动画正在执行
- (void)videoIconClick;

@end

@interface XYRootTabsController : UITabBarController<UITabBarControllerDelegate>

@property (nonatomic, strong) XYTabBar *customTabBar;

- (void)localizationUpdated;

- (void)setSelectedIndex:(NSUInteger)selectedIndex;

- (void)setUnreadCount:(int)unreadCount;

- (void)setMomentCount:(int)unreadCount;

@end
