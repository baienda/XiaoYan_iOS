//
//  AppDelegate.h
//  孝颜
//
//  Created by benjamin on 2017/8/9.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#ifdef DEBUG
//调试状态
//#define kApiBaseURL @"http://mobile.chatcat.co/" //上线服务器
//#define kApiBaseURL @"http://test.mobile.chatcat.co/" //测试服务器
#else
//发布状态
//#define kApiBaseURL @"http://mobile.chatcat.co/" //上线服务器
#endif

#ifdef DEBUG
//调试状态
#define kHyphenatePushService @"DevelopmentPush"

#else
//发布状态
#define kHyphenatePushService @"Push"

#endif

//#define kUcloudPublicKey @"IEr5xBQg4UbL4BQTRmR+eFzX2M7j0w2Dha4c7N8FB3Uk0xh0lhS+qw=="
//#define kUcloudPrivateKey @"6cd1fe90bd2e22790e2ec70d980619d539c3b3e9"
//#define kUcloudBucket @"chatcat"
//
//#define kHyphenatePushServiceDevelopment = @"MeechaDevelopmentPush";     // push service certificate name for development
//#define kHyphenatePushServiceProduction = @"MeechaPush";
#import <UIKit/UIKit.h>
#import "XYRootViewController.h"
#import "XYNavigationController.h"

//通知
static NSString *NoticeLocationRequested = @"NoticeLocationRequested";
static NSString *NoticeLocationAppActived = @"NoticeLocationAppActived";
static NSString *NoticeLocationAppBackground = @"NoticeLocationAppBackground";
static NSString *NoticeNewMessage = @"NoticeNewMessage";
static NSString *NoticeUserChanged = @"NoticeUserChanged";
static NSString *NoticeRefreshNearby = @"NoticeRefreshNearby";

static NSString *ShakeMessageNotice = @"ShakeMessageNotice";
static NSString *ShakeMessagelikeNotice = @"ShakeMessagelikeNotice";

static NSString *CallHangUpNotice = @"CallHangUpNotice";
static NSString *ReceiveCallNotice = @"ReceiveCallNotice";
static NSString *ReceiveCallAcceptNotice = @"ReceiveCallAcceptNotice";
static NSString *ReceiveCallEndNotice = @"ReceiveCallEndNotice";

@class AppDelegate;
extern AppDelegate *AppDelegateInstance;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIApplication *application;
@property (nonatomic, strong) XYRootViewController *rootController;
@property (nonatomic, strong) XYNavigationController *loginNavigationController;

@property float autoLayOutX;
@property float autoLayOutY;

- (void)initAPNS;
- (void)requestLocation;
- (BOOL)isLocationed;
- (BOOL)hasLocationRequested;
- (void)updateLocationTime;

- (void)ddEvent:(NSString *)name;
//- (void)ddError:(NSString *)name;

+ (NSString *)documentsPath;

-(void)doLogout;

- (NSString *)getUUid;
- (NSString *)getUA;
- (NSString *)getLanguage;
- (NSInteger)getNetworkStatus;
- (void)refreshNetworkStatus;
//- (CCLocation *)getLocation;

@end

