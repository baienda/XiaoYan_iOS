//
//  RealNameController.m
//  孝颜
//
//  Created by benjamin on 2017/8/14.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "RealNameController.h"


static CGFloat kTextFieldMargin = 10;
static CGFloat kTextFieldH = 56;

@interface RealNameController ()<UITextFieldDelegate>

@property (nonatomic,strong) UIView *BGView;

@end

@implementation RealNameController

-(UITextField *)mineRealnameTextfield {
    
    if (!_mineRealnameTextfield) {
        _mineRealnameTextfield = [[UITextField alloc] init];
        _mineRealnameTextfield.font = kFont(16* autoLayoutY);
        _mineRealnameTextfield.backgroundColor = [UIColor whiteColor];
        _mineRealnameTextfield.hidden = NO;
        _mineRealnameTextfield.delegate = self;
        [_mineRealnameTextfield becomeFirstResponder];
        _mineRealnameTextfield.returnKeyType = UIReturnKeyDone;
        _mineRealnameTextfield.textAlignment = NSTextAlignmentJustified;
        _mineRealnameTextfield.placeholder = Localized(@"姓名");
        _mineRealnameTextfield.tintColor = kGlobalColor;
        //编辑删除按钮
        _mineRealnameTextfield.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return _mineRealnameTextfield;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = kTableViewBackgroundColor;
    [self setNavigationBar];
    [self addTextfield];
    [self.view addSubview:self.finishBtn];
}
- (void)setNavigationBar{
    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [okBtn addTarget:self action:@selector(relationshipFinishClick) forControlEvents:UIControlEventTouchUpInside];
    self.finishBtn = okBtn;
    self.finishBtn.enabled = YES;
    [self setCustomFinishNavBar:Localized(@"真实名字") rightBtn:okBtn rightTitle:Localized(@"保存")];
    
}
- (void) finishClick {
    
    if ([self isEmpty:self.mineRealnameTextfield.text] == true) {
        MyLog(@"为空，不能发");
        //        [self alert:Localized(@"err_enter_empty") button:Localized(@"ok") click:nil];
        //退出键盘
        [self.mineRealnameTextfield resignFirstResponder];
        
    }else {
        MyLog(@"不为空，能发");
        //block传值
        if (self.SelectArrBlock) {
            
            self.mineRealnameTextfield.text = [self.mineRealnameTextfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            self.SelectArrBlock(self.mineRealnameTextfield.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
        
        //[[EMClient sharedClient] updatePushNotifiationDisplayName:self.mineNicknameTextfield.text completion:nil];
    }
}
- (void)addTextfield {
    
    UIView* textfieldView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight + kHeaderViewHeight + kTextFieldMargin, DEVICE_SIZE.width, kTextFieldH* autoLayoutY)];
    textfieldView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textfieldView];
    
    [textfieldView addSubview:self.mineRealnameTextfield];
    [self.mineRealnameTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kLeadingMargin);
        make.right.mas_equalTo(-kLeadingMargin);
        make.centerY.mas_equalTo(textfieldView.mas_centerY);
        make.height.mas_equalTo(30* autoLayoutY);
    }];
}
#pragma UITextfieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.text.length == 0) {
        self.finishBtn.enabled = YES;
    }else{
        self.finishBtn.enabled = YES;
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //限制textView的输入字符长度
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([newString length] > 30)
    {
        newString = [newString substringToIndex:30];
        textField.text = newString;
        return  NO;
    }
    //点击done时退出键盘
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        //处理点击事件
        MyLog(@"处理点击事件");
        return NO;
    }
    return YES;
}
//刚开始进来时 finishBtn 不能点击
//-(void)viewWillAppear:(BOOL)animated {
//
//    [super viewWillAppear:animated];
//
//    if (self.mineNicknameTextfield.text.length == 0) {
//        self.moreLabel.hidden = NO;
//        self.moreLabel.text = Localized(@"nickname");;
//        self.finishBtn.enabled = NO;
//    }else{
//        self.moreLabel.hidden = YES;
//        self.moreLabel.text = @"";
//        self.finishBtn.enabled = NO;
//    }
//}
#pragma mark - doAction
- (void)relationshipFinishClick {
    
    //处理上传逻辑
}
@end
