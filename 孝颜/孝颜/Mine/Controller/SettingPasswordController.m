//
//  SettingPasswordController.m
//  孝颜
//
//  Created by benjamin on 2017/8/14.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "SettingPasswordController.h"
#import "NSString+Array.h"

static CGFloat kTextFieldMargin = 10;
static CGFloat kTextFieldH = 56;

@interface SettingPasswordController ()<UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UIView *BGView;
@property (nonatomic, strong) UIButton* pwdPerView;
@property (nonatomic, strong) UIButton* againPwdPerView;

@end

@implementation SettingPasswordController
-(UITextField *)pwdTextfield {
    
    if (!_pwdTextfield) {
        _pwdTextfield = [[UITextField alloc] init];
        _pwdTextfield.font = kFont(16* autoLayoutY);
        _pwdTextfield.backgroundColor = [UIColor whiteColor];
        _pwdTextfield.hidden = NO;
        _pwdTextfield.delegate = self;
        [_pwdTextfield becomeFirstResponder];
        _pwdTextfield.returnKeyType = UIReturnKeyNext;
        _pwdTextfield.textAlignment = NSTextAlignmentJustified;
        //密码样式
        _pwdTextfield.secureTextEntry = YES;
        _pwdTextfield.placeholder = Localized(@"请输入新密码");
    }
    return _pwdTextfield;
}
-(UITextField *)againPwdTextfield {
    
    if (!_againPwdTextfield) {
        _againPwdTextfield = [[UITextField alloc] init];
        _againPwdTextfield.font = kFont(16* autoLayoutY);
        _againPwdTextfield.backgroundColor = [UIColor whiteColor];
        _againPwdTextfield.hidden = NO;
        _againPwdTextfield.delegate = self;
        [_againPwdTextfield becomeFirstResponder];
        _againPwdTextfield.returnKeyType = UIReturnKeyNext;
        _againPwdTextfield.textAlignment = NSTextAlignmentJustified;
        //密码样式
        _againPwdTextfield.secureTextEntry = YES;
        _againPwdTextfield.placeholder = Localized(@"请再次确认新密码");
    }
    return _againPwdTextfield;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kTableViewBackgroundColor;
    [self setNavigationBar];
    [self addTextfield];
}
- (void)setNavigationBar{
    
    [self setTitleText: Localized(@"设置新密码")];
    [self setBackButton:BackStyleBlack action:@selector(backAction)];
    
}
- (void)backAction {
    
    [self popViewController];
}
- (void) addTextfield {
    
#pragma mark 父view
    
    UIView* textfieldView1 = [[UIView alloc] initWithFrame:CGRectMake(kLeadingMargin, kStatusBarHeight + kHeaderViewHeight + kTextFieldMargin, DEVICE_SIZE.width - 2* kLeadingMargin, kTextFieldH* autoLayoutY)];
    textfieldView1.backgroundColor = [UIColor whiteColor];
    textfieldView1.layer.masksToBounds = YES;
    textfieldView1.layer.cornerRadius = 2;
    
//    textfieldView1.layer.shadowOpacity = 0.5;// 阴影透明度
//    textfieldView1.layer.shadowColor = kBlackColor.CGColor;// 阴影的颜色
//    textfieldView1.layer.shadowRadius = 3;// 阴影扩散的范围控制
//    textfieldView1.layer.shadowOffset = CGSizeMake(3, 0);// 阴影的范围
    
    [self.view addSubview:textfieldView1];
    
    UILabel* pwdLabel = [[UILabel alloc] init];
    pwdLabel.textColor = kTitleColor;
    pwdLabel.font = kFont(16* autoLayoutY);
    pwdLabel.textAlignment = NSTextAlignmentCenter;
    pwdLabel.text = Localized(@"设置新密码");
    [textfieldView1 addSubview:pwdLabel];
    [pwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kLeadingMargin);
        make.centerY.mas_equalTo(textfieldView1.mas_centerY);
        make.height.mas_equalTo(25* autoLayoutY);
        make.width.mas_equalTo(85* autoLayoutX);
    }];
    
    UIButton* pwdPerView = [UIButton buttonWithType:UIButtonTypeCustom];
    [pwdPerView setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [pwdPerView addTarget:self action:@selector(pwdPerViewAction) forControlEvents:UIControlEventTouchUpInside];
    pwdPerView.selected = YES;
    self.pwdPerView = pwdPerView;
    [textfieldView1 addSubview:pwdPerView];
    [pwdPerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kLeadingMargin);
        make.centerY.mas_equalTo(textfieldView1.mas_centerY);
        make.width.mas_equalTo(25* autoLayoutX);
        make.height.mas_equalTo(20* autoLayoutY);
    }];
    
    [textfieldView1 addSubview:self.pwdTextfield];
    [self.pwdTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(pwdLabel.mas_right).mas_offset(kLeadingMargin);
        make.right.mas_equalTo(pwdPerView.mas_left).mas_offset(-kLeadingMargin);
        make.centerY.mas_equalTo(textfieldView1.mas_centerY);
        make.height.mas_equalTo(30* autoLayoutY);
    }];
    
    
    UIView* textfieldView2 = [[UIView alloc] init];
    textfieldView2.backgroundColor = [UIColor whiteColor];
    textfieldView2.layer.masksToBounds = YES;
    textfieldView2.layer.cornerRadius = 2;
    [self.view addSubview:textfieldView2];
    [textfieldView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textfieldView1.mas_bottom).mas_offset(kTextFieldMargin);
        make.left.mas_equalTo(kLeadingMargin);
        make.right.mas_equalTo(-kLeadingMargin);
        make.height.mas_equalTo(kTextFieldH* autoLayoutY);
    }];
    
    UILabel* againPwdLabel = [[UILabel alloc] init];
    againPwdLabel.textColor = kTitleColor;
    againPwdLabel.font = kFont(16* autoLayoutY);
    againPwdLabel.textAlignment = NSTextAlignmentCenter;
    againPwdLabel.text = Localized(@"设置新密码");
    [textfieldView2 addSubview:againPwdLabel];
    [againPwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kLeadingMargin);
        make.centerY.mas_equalTo(textfieldView2.mas_centerY);
        make.height.mas_equalTo(25* autoLayoutY);
        make.width.mas_equalTo(85* autoLayoutX);
    }];
    
    UIButton* againPwdPerView = [UIButton buttonWithType:UIButtonTypeCustom];
    [againPwdPerView setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [againPwdPerView addTarget:self action:@selector(againPwdPerViewAction) forControlEvents:UIControlEventTouchUpInside];
    againPwdPerView.selected = YES;
    self.againPwdPerView = againPwdPerView;
    [textfieldView2 addSubview:againPwdPerView];
    [againPwdPerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kLeadingMargin);
        make.centerY.mas_equalTo(textfieldView2.mas_centerY);
        make.width.mas_equalTo(25* autoLayoutX);
        make.height.mas_equalTo(20* autoLayoutY);
    }];
    
    [textfieldView2 addSubview:self.againPwdTextfield];
    [self.againPwdTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(againPwdLabel.mas_right).mas_offset(kLeadingMargin);
        make.right.mas_equalTo(againPwdPerView.mas_left).mas_offset(-kLeadingMargin);
        make.centerY.mas_equalTo(textfieldView2.mas_centerY);
        make.height.mas_equalTo(30* autoLayoutY);
    }];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 2;
    [btn setTitle:Localized(@"完成") forState:UIControlStateNormal];
    btn.titleLabel.font = kFont(16* autoLayoutY);

    [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(finishClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"finishBtnHlight"] forState:UIControlStateHighlighted];
    self.finishBtn = btn;

    [self.view addSubview:btn];

    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textfieldView2.mas_bottom).offset(kTextFieldMargin);
        make.left.mas_equalTo(kLeadingMargin);
        make.right.mas_equalTo(-kLeadingMargin);
        make.height.mas_equalTo(kTextFieldH* autoLayoutY);
    }];
}
#pragma mark - doAction
- (void)pwdPerViewAction {
    
    if (self.pwdPerView.selected) {
        [self.pwdPerView setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
        self.pwdPerView.selected = NO;
        self.pwdTextfield.secureTextEntry = YES;
    }else {
        [self.pwdPerView setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
        self.pwdPerView.selected = YES;
        self.pwdTextfield.secureTextEntry = NO;
    }
}
- (void)againPwdPerViewAction {
    
    if (self.againPwdPerView.selected) {
        [self.againPwdPerView setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
        self.againPwdPerView.selected = NO;
        self.againPwdTextfield.secureTextEntry = YES;
    }else {
        [self.againPwdPerView setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
        self.againPwdPerView.selected = YES;
        self.againPwdTextfield.secureTextEntry = NO;
    }
}
-(void)finishClick {
    
    
}
@end
