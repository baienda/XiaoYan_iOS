//
//  CourseDetailsController.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "CourseDetailsController.h"

@interface CourseDetailsController ()

@property (nonatomic, strong)UIScrollView* baseScrollview;

@property (nonatomic, strong)UIView* baseView;
@property (nonatomic, strong)UIImage* imageView;
@property (nonatomic, strong)UIView* contentView;
@property (nonatomic, strong)UILabel* titleView;
@property (nonatomic, strong)UIView* lineView1;
@property (nonatomic, strong)UILabel* timeView;
@property (nonatomic, strong)UILabel* loactionView;
@property (nonatomic, strong)UILabel* moneyTypeView;
@property (nonatomic, strong)UIView* lineView2;

@property (nonatomic, strong)UIButton* teleBtn;
@property (nonatomic, strong)UIButton* locaBtn;

@property (nonatomic, assign)CGFloat imageHeight;
@property (nonatomic, assign)CGFloat titleViewHeight;//标题高
@property (nonatomic, assign)CGFloat contentHeight;//标题下面高
@property (nonatomic, assign)CGFloat iconHeight;

@end

@implementation CourseDetailsController

-(UILabel *)titleView {
    
    if (!_titleView) {
        _titleView = [[UILabel alloc] init];
        _titleView.font = kFontBold(16* autoLayoutY);
        _titleView.textColor = kTitleColor;
    }
    return _titleView;
}
-(UILabel *)timeView {
    
    if (!_timeView) {
        _timeView = [[UILabel alloc] init];
        _timeView.font = kFont(12* autoLayoutY);
        _timeView.textColor = kTitleColor;
        _timeView.textAlignment = NSTextAlignmentLeft;
    }
    return _timeView;
}
-(UILabel *)loactionView {
    
    if (!_loactionView) {
        _loactionView = [[UILabel alloc] init];
        _loactionView.font = kFont(12* autoLayoutY);
        _loactionView.textColor = kTitleColor;
        _loactionView.textAlignment = NSTextAlignmentLeft;
    }
    return _loactionView;
}
-(UILabel *)moneyTypeView {
    
    if (!_moneyTypeView) {
        _moneyTypeView = [[UILabel alloc] init];
        _moneyTypeView.font = kFont(12* autoLayoutY);
        _moneyTypeView.textColor = kTitleColor;
        _moneyTypeView.textAlignment = NSTextAlignmentLeft;
    }
    return _moneyTypeView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self setNavigationBar];
    [self setItemSize];
    [self setBaseScrollView];
    [self addBaseView];
}
- (void)setNavigationBar{
    
    [self setTitleText: Localized(@"课程详情")];
    [self setBackButton:BackStyleBlack action:@selector(backAction)];
    
}
- (void)setItemSize {
    
    self.imageHeight = DEVICE_SIZE.width / 16 * 9;
    self.titleViewHeight = 50* autoLayoutY;
    self.contentHeight = 150* autoLayoutY;
    self.iconHeight = 35* autoLayoutY;
}
- (void)setBaseScrollView {
    
    self.baseScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64)];
    self.baseScrollview.backgroundColor = kColor(247, 247, 247);
    self.baseScrollview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.baseScrollview];
}
- (void)addBaseView {
    
}
- (void)backAction {
    
    [self popViewController];
}
@end
