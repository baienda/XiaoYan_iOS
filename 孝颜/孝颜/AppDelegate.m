//
//  AppDelegate.m
//  孝颜
//
//  Created by benjamin on 2017/8/9.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "AppDelegate.h"
#import "ApiClient.h"
#import "UserDefault.h"
#import "UserConfig.h"

#import "WelcomeViewController.h"
#import "Common.h"

@import AddressBookUI;

AppDelegate *AppDelegateInstance = nil;

@interface AppDelegate ()

@property (nonatomic) NSInteger networkStatus;
@property (copy, nonatomic) NSString *ua;

@end

@implementation AppDelegate


- (void)refreshNetworkStatus
{
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                self.networkStatus = 1;
//                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                self.networkStatus = 2;
//                break;
//            case AFNetworkReachabilityStatusNotReachable:
//                self.networkStatus = 0;
//                break;
//            case AFNetworkReachabilityStatusUnknown:
//                self.networkStatus = -1;
//                break;
//        }
//    }];
}

- (NSInteger)getNetworkStatus
{
    return self.networkStatus;
}

- (NSString *)getLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    NSArray *array = [currentLanguage componentsSeparatedByString:@"-"];
    return array[0];
}

//- (NSString *)getUUid
//{
//    NSString *uuid = [UserDefault getString:@"uuid"];
//    if(uuid.length == 0){
//        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
//        NSString *strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
//        [UserDefault setString:@"uuid" value:strUUID];
//        uuid = strUUID;
//    }
//    return uuid;
//}

- (NSString *)getUA
{
    if(self.ua != nil && self.ua.length > 0){
        return self.ua;
    }
    
    NSString *uuid = [self getUUid];
    NSString *language = [self getLanguage];
    NSString *model = [[UIDevice currentDevice] model];
    NSString *osVersion = [[UIDevice currentDevice] systemVersion];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *temp = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    NSString *temp1 = [temp substringToIndex:temp.length - 2];
    NSString *temp2 = [temp substringFromIndex:temp.length - 1];
    NSString *temp3 = [temp1 stringByAppendingString:temp2];
    NSString *temp4 = [temp3 substringToIndex:1];
    NSString *temp5 = [temp3 substringFromIndex:2];
    NSString *appVersion = [NSString stringWithFormat:@"%@%@",temp4,temp5];
    
    
    self.ua = [NSString stringWithFormat:@"imei=%@&model=%@&language=%@&version=%@&os=%@&api=%@",
               uuid, model, language, appVersion, osVersion, @"1.0"];
    return self.ua;
}

//- (void)ddEvent:(NSString *)name{
//    int gender = [UserConfig getGender];
//    NSArray *countryCodes = [NSLocale ISOCountryCodes];
//    NSString *currentCountry = @"";
//    if([countryCodes count] > 0){
//        currentCountry = [countryCodes objectAtIndex:0];
//    }
//    [Answers logCustomEventWithName:name customAttributes:@{@"gender" : [NSString stringWithFormat:@"%d",gender], @"country" : currentCountry}];
//}
//
//- (void)ddError:(NSString *)name{
//    [Answers logCustomEventWithName:@"Error" customAttributes:@{@"Type" : name}];
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    [CRToastManager setDefaultOptions:@{kCRToastNotificationTypeKey : @(CRToastTypeNavigationBar),
//                                        kCRToastFontKey             : [UIFont fontWithName:@"HelveticaNeue-Light" size:16],
//                                        kCRToastTextColorKey        : [UIColor whiteColor],
//                                        kCRToastBackgroundColorKey  : [UIColor orangeColor],
//                                        kCRToastAutorotateKey       : @(YES)}];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [[UIView appearance] setExclusiveTouch:YES];
    
    AppDelegateInstance = self;
    self.application = application;
    
    //崩溃记录
//    [Fabric with:@[[Crashlytics class]]];
    
    application.applicationIconBadgeNumber = 0;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //初始化当前用户
//    [UserConfig loadConfig];
    
    //配置屏幕适配属性
    [self setAutoLayOutProperty];
    
    //初始化环信SDK
//    [[IMCore instance] initWithApplication:application Options:launchOptions];
//    MyLog(@"环信版本: %@", [EMClient sharedClient].version);
    
    //初次化界面
    _rootController = [[XYRootViewController alloc] init];
    self.window.rootViewController = _rootController;
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
    __weak typeof (self) weakSelf = self;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        //[self loadSettings];
//        if(![UserConfig isLogined]){
//            [weakSelf presentLoginController];
//        } else if(![UserConfig isCompleted]){
//            [weakSelf doLogout];
//        } else {
//            [weakSelf presentGuideController];
//        }
//        
//        //初始化表情
//        [Emoji instance];
//    });
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
//        if([self hasLocationRequested] == TRUE){
//            //初始化APNS
//            [self initAPNS];
//        }
        [self initAPNS];

    });
    //获取网络状况
    [self refreshNetworkStatus];
    
//    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
//    
//    [FBSDKAppEvents logEvent:@"mainActivityOpen"];
//    
//    [FBSDKAppLinkUtility fetchDeferredAppLink:^(NSURL *url,NSError *error){
//        //TODO: FB深度连接
//    }];
    
    //    //初始化表情
    //    [Emoji instance];
    
    if (launchOptions) {
        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if(userInfo)
        {
            [self application:application didReceiveRemoteNotification:userInfo];
        }
    }
    
    return YES;
}

// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
//    [[IMCore instance] onApplication:application deviceToken:deviceToken];
}

// 注册deviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    MyLog(@"error -- %@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
}

//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//            options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
//{
//    return [[FBSDKApplicationDelegate sharedInstance] application:application
//                                                          openURL:url
//                                                          options:options];
//}

// Still need this for iOS8
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(nullable NSString *)sourceApplication
         annotation:(nonnull id)annotation
{
//    [[FBSDKApplicationDelegate sharedInstance] application:application
//                                                   openURL:url
//                                         sourceApplication:sourceApplication
//                                                annotation:annotation];
    return YES;
}


//接收本地推送
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    application.applicationIconBadgeNumber = 0;
    
    [application cancelLocalNotification:notification];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
//    [[IMCore instance] onApplicationDidEnterBackground:application];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
//    [[IMCore instance] onApplicationWillEnterForeground:application];
//    _enterForeground = YES;
    
    //广播应用被激活
    [[NSNotificationCenter defaultCenter] postNotificationName:NoticeLocationAppBackground object:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    [[NSUserDefaults standardUserDefaults]setObject:@(NO) forKey:kUserDefaultsSecondRefresh];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    application.applicationIconBadgeNumber = 0;
    
    //广播应用被激活
    [[NSNotificationCenter defaultCenter] postNotificationName:NoticeLocationAppActived object:nil];
    
    [[NSUserDefaults standardUserDefaults]setObject:@(YES) forKey:kUserDefaultsRefreshStatus];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    //打点
//    [FBSDKAppEvents activateApp];
    
    //查看网络消息
    [self refreshNetworkStatus];
    
//    [Emoji instance];
    
//    [self updateLocation];
    
//    if ([AppDelegateInstance isLocationed] == NO) {
//        [self requestLocation];
//    }
    
}

- (void)updateLocation
{
    if(![UserConfig isLogined])
        return;
    
    NSString *longitude = [UserConfig getLocationLng];
    NSString *latitude = [UserConfig getLocationLat];
    LocationParams *params = [LocationParams alloc];
    params.longitude = longitude;
    params.latitude = latitude;
    [ApiClient doUpdateLocation:^(id JSON) {
        MyLog(@"更新时间成功");
    } andFailure:^(id error) {
        MyLog(@"更新时间失败");
    } andParam:params];
}


- (void)initAPNS
{
    [[NSUserDefaults standardUserDefaults]setObject:@(YES) forKey:kSendVibrateOpenKey];
    [[NSUserDefaults standardUserDefaults]setObject:@(YES) forKey:kSendSoundOpenKey];
    
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    
    //iOS8 注册APNS
    if ([self.application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [self.application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [self.application registerUserNotificationSettings:settings];
    }
    else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
}

- (XYNavigationController *)loginNavigationController
{
    if (_loginNavigationController == nil)
    {
        UIViewController *rootController = [[WelcomeViewController alloc] init];
        
        _loginNavigationController = [XYNavigationController navigationControllerWithControllers:@[rootController]];
    }
    
    return _loginNavigationController;
}

- (void)presentGuideController
{
//    if (![[NSThread currentThread] isMainThread])
//    {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self presentGuideController];
//        });
//        return;
//    }
//    else
//    {
//        NSMutableArray *images = [NSMutableArray new];
//        [images addObject:[UIImage imageNamed:@"lead_page"]];
//        
//        NSArray *titles = @[@""];
//        NSArray *secondTitles = @[@""];
//        
//        HcdGuideView *guideView = [HcdGuideView sharedInstance];
//        guideView.window = self.window;
//        [guideView showGuideViewWithImages:images andTitles:titles andSecondTitles:secondTitles andPoints:nil];
//    }
    
}

- (void)presentLoginController
{
    if (![[NSThread currentThread] isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           [self presentLoginController];
                       });
        return;
    }
    else
    {
        XYNavigationController *loginNavigationController = [self loginNavigationController];
        NSMutableArray *viewControllers = [[loginNavigationController viewControllers] mutableCopy];
        
        [loginNavigationController setViewControllers:viewControllers animated:false];
        
        if (AppDelegateInstance.rootController.presentedViewController != nil)
        {
            if (AppDelegateInstance.rootController.presentedViewController == loginNavigationController)
                return;
            
            [AppDelegateInstance.rootController dismissViewControllerAnimated:true completion:nil];
            double delayInSeconds = 0.5;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^
                           {
                               [AppDelegateInstance.rootController presentViewController:loginNavigationController animated:TRUE completion:nil];
                           });
        }
        else
            [AppDelegateInstance.rootController presentViewController:loginNavigationController animated:TRUE completion:nil];
        
        
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^
                       {
                           [_rootController.mainTabsController setSelectedIndex:0];
                           [AppDelegateInstance.rootController clearContentControllers];
                           [AppDelegateInstance resetControllerStack];
                       });
    }
}

- (void)resetControllerStack
{
    [AppDelegateInstance.rootController clearContentControllers];
}

-(void)doLogout
{
    //退出环信
//    [[IMCore instance] logout:nil];
    
    //清除UserDefaults
    [UserConfig clearConfig];
    
//    [FBSDKAccessToken setCurrentAccessToken:nil];
    
    
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
                       [[UIApplication sharedApplication] cancelAllLocalNotifications];
                       
                       [AppDelegateInstance presentLoginController];
                   });
}


- (void)setAutoLayOutProperty
{
    if (DEVICE_SIZE.width<DEVICE_SIZE.height) {
        if(DEVICE_SIZE.height > 667){
            self.autoLayOutX = DEVICE_SIZE.width/375;
            self.autoLayOutY = DEVICE_SIZE.height/667;
        }else{
            self.autoLayOutX = 1.0;
            self.autoLayOutY = 1.0;
        }
    }else{
        if(DEVICE_SIZE.width > 375){
            self.autoLayOutX = DEVICE_SIZE.height/375;
            self.autoLayOutY = DEVICE_SIZE.width/667;
        }else{
            self.autoLayOutX = 1.0;
            self.autoLayOutY = 1.0;
        }
    }
}


+ (NSString *)documentsPath
{
    static NSString *path = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      if (iosMajorVersion() >= 8)
                      {
                          NSString *groupName = [@"group." stringByAppendingString:[[NSBundle mainBundle] bundleIdentifier]];
                          
                          NSURL *groupURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:groupName];
                          if (groupURL != nil)
                          {
                              NSString *documentsPath = [[groupURL path] stringByAppendingPathComponent:@"Documents"];
                              
                              [[NSFileManager defaultManager] createDirectoryAtPath:documentsPath withIntermediateDirectories:true attributes:nil error:NULL];
                              
                              path = documentsPath;
                          }
                          else
                              path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0];
                      }
                      else
                          path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0];
                  });
    
    return path;
}
@end
