
//
//  Common.h
//  liaomao
//
//  Created by Mr.wc on 16/8/1.
//  Copyright © 2016年 wc. All rights reserved.
//
#import "AppDelegate.h"

//定义的全屏尺寸（包含状态栏）
#define DEVICE_BOUNDS [[UIScreen mainScreen] bounds]
#define DEVICE_SIZE [[UIScreen mainScreen] bounds].size
#define DEVICE_OS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//AppDelegate
#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define autoLayoutX ((AppDelegate *)[[UIApplication sharedApplication] delegate]).autoLayOutX
#define autoLayoutY ((AppDelegate *)[[UIApplication sharedApplication] delegate]).autoLayOutY


//日志输出宏定义
#ifdef DEBUG
//调试状态
#define MyLog(...) NSLog(__VA_ARGS__)
#else
//发布状态
#define MyLog(...)
#endif

//获得RGB颜色
#define kColorAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define kColorPoint(r, g, b) [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:1]
#define kColorRGBSame(rgb) kColor(rgb, rgb, rgb)

#define kGlobalColor kColor(255, 35, 125)
#define kGlobalHighlightColor kColor(205, 25, 100)
#define kSelectGobalColor kColor(205,25,100)
#define kGlobalColorAlpha kColorAlpha(255, 35, 125, 0.9)

#define kBuleColor kColor(0, 158, 255)
#define kBuleHighlightColor kColor(0, 126, 204)
#define kRedColor kColor(255, 0, 0)
#define kWhiteColor kColor(255, 255, 255)
#define kBlackColor kColor(0, 0, 0)


#define kTitleColor UIColorRGB(0x242427)//标题和名字
#define kTextColor UIColorRGB(0x494951)//正文
#define kSecondTitleColor UIColorRGB(0x8F9098)
#define kGrayColor UIColorRGB(0xB8B3B4)

#define kBackGroundColor kColor(247, 247, 247)
#define kButtonColor UIColorRGB(0x2d2d34)

#define kLineColor kColor(229, 229, 229)
#define kSelectorColor kColor(229, 229, 229)

#define kTableGrayColor kColor(247, 247, 247)

#define kMomentCommentColor kColor(184, 178, 180)
#define kMomentZanColor kColor(0, 163, 255)
#define kArticleNameColor kColor(189, 64, 115)
#define kUcloudBaseUrl @""

#define UIColorRGB(rgb) ([[UIColor alloc] initWithRed:(((rgb >> 16) & 0xff) / 255.0f) green:(((rgb >> 8) & 0xff) / 255.0f) blue:(((rgb) & 0xff) / 255.0f) alpha:1.0f])
#define UIColorRGBA(rgb,a) ([[UIColor alloc] initWithRed:(((rgb >> 16) & 0xff) / 255.0f) green:(((rgb >> 8) & 0xff) / 255.0f) blue:(((rgb) & 0xff) / 255.0f) alpha:a])

#define checkStringNull(Str) (Str) == [NSNull null] || (Str) == nil ? @”” : [NSString stringWithFormat:@”%@”, (Str)]

//全局弱饮用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


//系统默认字体
#define kFont(n) [UIFont systemFontOfSize:n]
#define kFontBold(n) [UIFont boldSystemFontOfSize:n]
#define kHeaderTitleFont kFontBold(18 * autoLayoutY)

//状态栏高度
#define kStatusBarHeight 20
#define kLeadingMargin 15
//navGationHeight
#define kHeaderViewHeight 44
#define kCustonButtonHeight 46*autoLayoutY
#define kCustonButtonWidth 160*autoLayoutX

//阅后即焚延迟时间
#define kFireChatTime 5.f

//判断app版本
#define kIsEnterPrise [[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUserTypeIsEnterPrise] boolValue]

//是否登录
#define kIsLogin [[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsIsLoginKey] boolValue]

//edit profile 是否允许编辑性别
#define kIsFirstLogin [[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsIsFirstLoginKey] boolValue]
//nearby是否显示tip_nearby_welcome
#define kIsWelcomeKey [[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsIsWelcomeTipKey] boolValue]
//nearby 是否第一次显示edit profile alert
#define kIsFirstTimeEditProfileKey [[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsIsEditProfileFirstTimeKey] boolValue]
//话题第一次返回话题列表
#define kIsFirstTimeTopicArticleKey [[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsIsFirstTimeTopicArticleKey] boolValue]
//创建群组引导
#define kIsFirstTimeCreateGroupKey [[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsIsFirstTimeCreateGroupKey] boolValue]
//第一次发帖气泡
#define kIsFirstTimeTopicBubbleKey [[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsIsFirstTimeTopicBubbleKey] boolValue]
//第一次纸条气泡
#define kIsFirstTimeNoteBubbleKey [[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsIsFirstTimeNoteBubbleKey] boolValue]

//第一次profile点赞
#define kIsFirstTimeProfileLikeKey [[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsIsFirstTimeProfileLikeKey] boolValue]
//第一次激活统计
#define kIsFirstOpenKey [[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultskIsFirstOpenKey] boolValue]


#pragma mark - userdefaultsKeys

#define kUserDefaultsLastActivedTime @"kUserDefaultsLastActivedTime" //上次打开主界面的时间

#define kUserDefaultsLocationRequested @"kUserDefaultsLocationRequest" //判断是否请求过经纬度权限

#define kUserDefaultsRefreshStatus @"kUserDefaultsRefreshStatus" //刷新状态
#define kUserDefaultsSecondRefresh @"kUserDefaultsSecondRefresh" //第二次刷新

#define kUserDefaultsUUID @"kUserDefaultsUUID" //UUID

#define kUserDefaultsLanguage @"kUserDefaultsLanguage" //Language

#define kUserDefaultsNetStatus @"kUserDefaultsNetStatus" //网络状态

#define kUserDefaultsCookies @"kUserDefaultsCookies" //cookie

#define kUserDefaultsCookieUKey @"kUserDefaultsCookieUKey"  //Cookie U
#define kUserDefaultsCookieSKey @"kUserDefaultsCookieSKey"  //Cookie S

#define kUserDefaultsIsLoginKey @"kUserDefaultsIsLoginKey"  //是否登录
#define kUserDefaultsIsFirstLoginKey @"kUserDefaultsIsFirstLoginKey"  //是否第一次登录
#define kUserDefaultsIsWelcomeTipKey @"kUserDefaultsIsWelcomeTipKey"  //nearby是否显示tip_nearby_welcome
#define kUserDefaultsIsEditProfileFirstTimeKey @"kUserDefaultsIsEditProfileFirstTimeKey"
#define kUserDefaultskIsFirstOpenKey @"kUserDefaultskIsFirstOpenKey"  //注册出现
#define kUserDefaultsIsFirstTimeTopicArticleKey @"kUserDefaultsIsFirstTimeTopicArticleKey"
#define kUserDefaultsIsFirstTimeTopicBubbleKey @"kUserDefaultsIsFirstTimeTopicBubbleKey"
#define kUserDefaultsIsFirstTimeNoteBubbleKey @"kUserDefaultsIsFirstTimeNoteBubbleKey"

//第一次profile点赞
#define kUserDefaultsIsFirstTimeProfileLikeKey @"kUserDefaultsIsFirstTimeProfileLikeKey"

#define kUserDefaultsIsFirstTimeCreateGroupKey @"kUserDefaultsIsFirstTimeCreateGroupKey"
#define kUserDefaultsSetSMSKey @"kUserDefaultsSetSMSKey"

//#define kUserDefaultsUserNameKey @"kUserDefaultsUserNameKey"  //用户名，即注册phone
#define kUserDefaultsUserPhoneKey @"kUserDefaultsUserPhoneKey" //手机号
#define kUserDefaultsUserPhoneCodeKey @"kUserDefaultsUserPhoneCodeKey" //手机号国家代码

#define kUserDefaultsUserIdKey @"kUserDefaultsUserIdKey" // 用户ID

#define kUserDefaultsLocationDict @"kUserDefaultsLocationDict" //经纬度

#define kUserDefaultsHasUseAPP @"kUserDefaultsHasUseAPP" //是否是第一次进入应用，bool
#define kUserDefaultsHasLoadNewfeature @"kUserDefaultsHasLoadNewfeature" //用户版新特性界面展示

//表情本地存储
#define kUserDefaultsEmotionLocalSaveKey @"kUserDefaultsEmotionLocalSaveKey"

#define kUserDefaultsEmotionLocalDictKey @"kUserDefaultsEmotionLocalDictKey"

//环信用户名和密码
#define kUserDefaultsEaseMobNameKey @"kUserDefaultsEaseMobNameKey"
#define kUserDefaultsEaseMobPasswordKey @"kUserDefaultsEaseMobPasswordKey"

//用户 头像ulr 昵称
#define kUserDefaultsEMExtKey @"kUserDefaultsEMExtKey"

//点击纸条前的视图控制器的index
#define kUserDefaultsToPaperBeforeIndex @"kUserDefaultsToPaperBeforeIndex"

//纸条提示信息已读
#define kUserDefaultsPaperNoticeHasReadKey @"kUserDefaultsPaperNoticeHasReadKey"

//自定义相机跳转type
#define kUserDefaultsCustomCameraTypeKey @"kUserDefaultsCustomCameraTypeKey"

//视频地址本地
#define kUserDefaultsVideoUrlArrayKey @"kUserDefaultsVideoUrlArrayKey"

//摄像头状态
#define kCameraFaceFront @"kCameraFaceFront"

#define kSendVibrateOpenKey @"kSendVibrateOpenKey"
#define kSendSoundOpenKey @"kSendSoundOpenKey"

//当前聊天背景状态
#define kUserDefaultsChatBgKey @"kUserDefaultsChatBgKey"

//视频dismiss通知
#define kVideoShowViewControllerDismiss @"kVideoShowViewControllerDismiss"

#define kUserDefaultsCreateAccountTime @"kUserDefaultsCreateAccountTime" //注册时间
#define kUserDefaultsCreateAccountUid @"kUserDefaultsCreateAccountUid" //注册时间
//性别
typedef enum{
    kSexTypeMale = 0, //男
    kSexTypeFemale = 1, //女
    kSexTypeUnknown = 2 //未知
} SexType;


#pragma mark --- 苗天宇添的 ---

#define kSectionInstence 44
#define kMargin 10

#define kTableViewBackgroundColor kColor(247, 247, 247)




int iosMajorVersion();

NSString *Localized(NSString *s);
NSString *LocalizedByLanguage(NSString *s, NSString *language);

CGSize ScreenSize();

NSString *EncodeText(NSString *string, int key);

#pragma mark --- 苗天宇添的 ---


typedef void (^CCWebImageBlock)(UIImage *image, NSError *error);


#pragma mark

@interface UIImageView (CCWebImage)

- (void)setWithURL:(NSString *)imageURL placeholder:(UIImage *)placeholder completion:(CCWebImageBlock)block;
- (void)setAvatarWithURL:(nullable NSString *)imageURL;
- (void)setAvatarWithURL:(nullable NSString *)imageURL completion:(nullable CCWebImageBlock)block;
- (void)setGroupWithURL:(nullable NSString *)imageURL completion:(nullable CCWebImageBlock)block;
- (void)setThumbnailWithURL:(nullable NSString *)imageURL completion:(nullable CCWebImageBlock)block;
- (void)setNoPlaceholderWithURL:(nullable NSString *)imageURL completion:(nullable CCWebImageBlock)block;
- (void)setMomentWithURL:(nullable NSString *)imageURL completion:(nullable CCWebImageBlock)block;
- (void)setShakeWithURL:(nullable NSString *)imageURL completion:(nullable CCWebImageBlock)block;

@end

@interface NSString(CCString)

- (int)intValue2;

@end

@interface NSNumber(CCNumber)

- (int)intValue2;

@end






