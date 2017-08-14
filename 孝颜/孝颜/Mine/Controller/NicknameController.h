//
//  NicknameController.h
//  孝颜
//
//  Created by benjamin on 2017/8/14.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "XYViewController.h"

@interface NicknameController : XYViewController

@property (nonatomic , strong) UITextField* mineNicknameTextfield;
@property (nonatomic , strong) UIButton * finishBtn;

@property (nonatomic ,copy) void (^SelectArrBlock)(NSString *text);

@end
