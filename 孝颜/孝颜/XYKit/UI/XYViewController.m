//
//  XYViewController.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "XYViewController.h"
#import "XYNavigationBar.h"
//#import "CRToast.h"
#import "UIView+animation.h"

@interface XYViewController ()

@property (nonatomic, strong) XYNavigationBar *navigationBar;
@property (nonatomic, strong) UINavigationItem *navigationItem1;

@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) UIImageView *loadingImageView;
@property (nonatomic, strong) UIImageView *loadSuccessView;
@property (nonatomic, strong) UILabel *loadingTextView;
@property (nonatomic, strong) UIView *pageLoadingView;
@property (nonatomic, strong) UIImageView *pageLoadingImageView;

@property (nonatomic, strong) NSArray *sortedArray;//最新IM消息

@property (nonatomic, assign) BOOL animationFinished;

@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation XYViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self _commonViewControllerInit];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        [self _commonViewControllerInit];
    }
    return self;
}

- (void)_commonViewControllerInit
{
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)])
        [self setAutomaticallyAdjustsScrollViewInsets:false];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewControllerStatusBarWillChangeFrame:) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewControllerKeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewControllerKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //获取最新IM消息
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BaseViewControllerShowTips) name:@"BaseViewControllerShowTipsNotice" object:nil];
    //跳转页面
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BaseViewControllerPushToChat) name:@"BaseViewControllerPushToChatNotice" object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BaseViewControllerShowTips) name:@"sendBaseViewControllerNewMessageNotice" object:nil];
    
}

- (void)dealloc
{
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BaseViewControllerShowTipsNotice" object:nil];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BaseViewControllerPushToChatNotice" object:nil];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"sendBaseViewControllerNewMessageNotice" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //页面关闭时，更新位置时间
//    [AppDelegateInstance updateLocationTime];
}

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    //隐藏默认导航
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    _viewControllerIsAnimatingAppearanceTransition = true;
    _viewControllerIsAppearing = true;
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    _viewControllerIsAppearing = false;
    _viewControllerIsAnimatingAppearanceTransition = false;
    _viewControllerHasEverAppeared = true;
    
    __weak id weakSelf = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    _viewControllerIsDisappearing = true;
    _viewControllerIsAnimatingAppearanceTransition = true;
//    [self hidePageLoading];
//    [self hideLoading];
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    _viewControllerIsDisappearing = false;
    _viewControllerIsAnimatingAppearanceTransition = false;
    [super viewDidDisappear:animated];
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer{
    //判断是否为rootViewController
    if (self.navigationController && self.navigationController.viewControllers.count == 1) {
        return NO;
    }
    return YES;
}

- (void)hideStatusBar:(bool)hide
{
    [[UIApplication sharedApplication] setStatusBarHidden:hide withAnimation:UIStatusBarAnimationFade];
}

- (void)setNavigationBarStyle:(NavigationBarStyle)barStyle
{
    //初始化自定义导航栏
    if(_navigationBar == nil){
        _navigationBar = [[XYNavigationBar alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SIZE.width, 64.0) barStyle:barStyle];
        _navigationItem1 = [[UINavigationItem alloc] init];
        [_navigationBar setItems:@[_navigationItem1]];
        [self.view addSubview:_navigationBar];
    }
}

- (void)setTitleText:(NSString *)titleText
{
    UILabel *title = [[UILabel alloc] init];
    title.frame = CGRectMake((DEVICE_SIZE.width - 150 * autoLayoutX)/2.0, 0, 150 * autoLayoutX, kHeaderViewHeight);
    title.text = titleText;
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = UIColorRGB(0x242427);
    title.font = kHeaderTitleFont;
    [self setTitleView:title];
}

- (void)setTitleView:(UIView *)titleView
{
    [self setNavigationBarStyle:WhiteNavigationBarStyle];
    _navigationItem1.titleView = titleView;
}

- (void)setLineColor:(UIColor *)color;
{
    if(_navigationBar != nil){
        [_navigationBar setLineColor:color];
    }
}

- (void)setHiddenBar:(bool)hidden animated:(bool)animated
{
    if(_navigationBar != nil){
        [_navigationBar setHiddenState:hidden animated:animated];
    }
}

- (void)setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem
{
    [self setLeftBarButtonItem:leftBarButtonItem animated:false];
}

- (void)setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem animated:(BOOL)animated
{
    [self setNavigationBarStyle:WhiteNavigationBarStyle];
    [_navigationItem1 setLeftBarButtonItem:leftBarButtonItem animated:animated];
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem
{
    [self setRightBarButtonItem:rightBarButtonItem animated:false];
}

- (void)setRightBarButtonItems:(NSArray *)items
{
    [self setRightBarButtonItems:items animated:NO];
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem animated:(BOOL)animated
{
    [self setNavigationBarStyle:WhiteNavigationBarStyle];
    [_navigationItem1 setRightBarButtonItem:rightBarButtonItem animated:animated];
}

- (void)setRightBarButtonItems:(NSArray *)items animated:(BOOL)animated
{
    [self setNavigationBarStyle:WhiteNavigationBarStyle];
    [_navigationItem1 setRightBarButtonItems:items animated:animated];
}

- (void)setBackButton:(BackStyle *)backStyle action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0, 0, 44, 44);
    [btn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self setLeftBarButtonItem:item];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)flag
{
    [self.navigationController pushViewController:viewController animated:flag];
}

- (void)pushViewControllerAndRemove:(UIViewController *)viewController animated:(BOOL)flag andBeforeCount:(int)beforeCount
{
    [self.navigationController pushViewController:viewController animated:flag];
    
    NSMutableArray *navigationStack = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
    while (beforeCount > 0) {
        beforeCount--;
        if([navigationStack count] <= 2){
            break;
        }
        [navigationStack removeObjectAtIndex:[navigationStack count] - 2];
    }
    self.navigationController.viewControllers = navigationStack;
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag
{
    [self presentViewController:viewControllerToPresent animated:flag completion:nil];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)())completion
{
    if (iosMajorVersion() >= 8 && self.presentedViewController != nil && [self.presentedViewController isKindOfClass:[UIAlertController class]])
    {
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           [self presentViewController:viewControllerToPresent animated:flag completion:completion];
                       });
    }
    else
        [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dismissViewController
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)localizationUpdated
{
    
}


+ (bool)isWidescreen
{
    static bool isWidescreenInitialized = false;
    static bool isWidescreen = false;
    
    if (!isWidescreenInitialized)
    {
        isWidescreenInitialized = true;
        
        CGSize screenSize = [XYViewController screenSizeForInterfaceOrientation:UIInterfaceOrientationPortrait];
        if (screenSize.width > 321 || screenSize.height > 481)
            isWidescreen = true;
    }
    
    return isWidescreen;
}

+ (CGSize)screenSizeForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    CGSize mainScreenSize = ScreenSize();
    
    CGSize size = CGSizeZero;
    if (UIInterfaceOrientationIsPortrait(orientation))
        size = CGSizeMake(mainScreenSize.width, mainScreenSize.height);
    else
        size = CGSizeMake(mainScreenSize.height, mainScreenSize.width);
    return size;
}

////居中
//- (void)alert:(NSString *)message button:(NSString *)button click:(LXAlertClickIndexBlock)click
//{
//    @synchronized(alertView)
//    {
//        [self hideLoading];
//        if(alertView != nil)
//        {
//            [alertView dismissAlertView];
//            alertView = nil;
//        }
//        alertView = [[LXAlertView alloc]initWithTitle:Localized(@"tips") message:message cancelBtnTitle:nil otherBtnTitle:button clickIndexBlock:click and:YES and:YES];
//        [alertView showLXAlertView];
//    }
//}
////居左
//- (void)alertLeft:(NSString *)message button:(NSString *)button click:(LXAlertClickIndexBlock)click
//{
//    @synchronized(alertView)
//    {
//        
//        [self hideLoading];
//        if(alertView != nil)
//        {
//            [alertView dismissAlertView];
//            alertView = nil;
//        }
//        alertView = [[LXAlertView alloc]initWithTitle:Localized(@"tips") message:message cancelBtnTitle:nil otherBtnTitle:button clickIndexBlock:click and:YES and:NO];
//        [alertView showLXAlertView];
//    }
//}
//- (void)confirm:(NSString *)message button1:(NSString *)button1 button2:(NSString *)button2 click:(LXAlertClickIndexBlock)click
//{
//    @synchronized(alertView)
//    {
//        [self hideLoading];
//        if(alertView != nil)
//        {
//            [alertView dismissAlertView];
//            alertView = nil;
//        }
//        alertView = [[LXAlertView alloc]initWithTitle:Localized(@"tips") message:message cancelBtnTitle:button1 otherBtnTitle:button2 clickIndexBlock:click and:YES and:YES];
//        [alertView showLXAlertView];
//    }
//}

//- (void)showLoading :(BOOL)isload
//{
//    if(self.loadingView == nil){
//        self.loadingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_SIZE.width, DEVICE_SIZE.height)];
//        [self.navigationController.view addSubview:self.loadingView];
//        
//        UIView *maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_SIZE.width, DEVICE_SIZE.height)];
//        maskView.backgroundColor = [UIColor blackColor];
//        maskView.alpha = 0.5;
//        [self.loadingView addSubview:maskView];
//        
//        UIImageView *backImageView = [[UIImageView alloc]init];
//        backImageView.image = [UIImage imageNamed:@"load_bg"];
//        backImageView.bounds = CGRectMake(0, 0, 100 * autoLayoutX, 100 * autoLayoutX);
//        backImageView.center = CGPointMake(DEVICE_SIZE.width/2.0, DEVICE_SIZE.height/2.0 + 5);
//        [self.loadingView addSubview:backImageView];
//        
//        UIImageView *loadView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"load_progress"]];
//        loadView.bounds = CGRectMake(0, 0, 58 * autoLayoutX, 58 * autoLayoutX);
//        loadView.center = CGPointMake(backImageView.frame.size.width/2.0, backImageView.frame.size.height/2.0 - 10);
//        
//        UIImageView *loadSuccessView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"load_success"]];
//        loadSuccessView.bounds = CGRectMake(0, 0, 58 * autoLayoutX, 58 * autoLayoutX);
//        loadSuccessView.center = CGPointMake(backImageView.frame.size.width/2.0, backImageView.frame.size.height/2.0 - 10);
//        loadSuccessView.hidden = YES;
//        self.loadSuccessView = loadSuccessView;
//        [backImageView addSubview:loadSuccessView];
//        
//        UILabel *loadingLabel = [[UILabel alloc]init];
//        loadingLabel.text = isload ? Localized(@"loading") : Localized(@"posting");
//        loadingLabel.font = kFont(12 * autoLayoutY);
//        loadingLabel.textColor = kSecondTitleColor;
//        loadingLabel.textAlignment = NSTextAlignmentCenter;
//        loadingLabel.bounds = CGRectMake(0, 0, 80, 20);
//        loadingLabel.center = CGPointMake(backImageView.frame.size.width/2.0, backImageView.frame.size.height/2.0 + 35);
//        [backImageView addSubview:loadingLabel];
//        self.loadingTextView = loadingLabel;
//        
//        //        [UIView RotateAnimationShowView:loadView];
//        
//        [self rotateImageView:loadView];
//        [backImageView addSubview:loadView];
//        self.loadingImageView = loadView;
//        
//        
//        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [leftBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
//        leftBtn.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
//        [self.loadingView addSubview:leftBtn];
//        
//        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(10);
//            make.top.mas_equalTo(10);
//            make.width.mas_equalTo(44);
//            make.height.mas_equalTo(44);
//        }];
//    }
//}
//
//- (void)showLoadingSuccss
//{
//    if(self.loadingView != nil)
//    {
//        self.loadingTextView.text = Localized(@"success");
//        self.loadingImageView.tag = 0;
//        [self.loadingImageView removeFromSuperview];
//        [self.loadingImageView.layer removeAllAnimations];
//        self.loadSuccessView.hidden = NO;
//        
//        double delayInSeconds = 0.7;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//        dispatch_after(popTime, dispatch_get_main_queue(), ^
//                       {
//                           [self hideLoading];
//                       });
//        
//    }
//}
//
//- (void)hideLoading
//{
//    if(self.loadingView != nil){
//        [self.loadingView removeFromSuperview];
//        [self.loadingImageView removeFromSuperview];
//        [self.loadingImageView.layer removeAllAnimations];
//        self.loadingView = nil;
//        self.loadingImageView = nil;
//        self.animationFinished = YES;
//    }
//}
//
//- (void)showPageLoading
//{
//    if(self.pageLoadingView == nil){
//        int bottomHeight = 0;
//        if([self isKindOfClass:[FriendMomentController class]])
//        {
//            bottomHeight = 49;
//        }
//        self.pageLoadingView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_SIZE.width, DEVICE_SIZE.height - 64 - bottomHeight)];
//        [self.navigationController.view addSubview:self.pageLoadingView];
//        
//        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"three_1"],[UIImage imageNamed:@"three_2"],[UIImage imageNamed:@"three_3"], nil];
//        self.pageLoadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SIZE.width, DEVICE_SIZE.width/2)];
//        self.pageLoadingImageView.animationImages = array; //动画图片数组
//        self.pageLoadingImageView.animationDuration = 0.8; //执行一次完整动画所需的时长
//        self.pageLoadingImageView.animationRepeatCount = 0;  //动画重复次数 0表示无限次，默认为0
//        
//        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SIZE.width, DEVICE_SIZE.height-128 - bottomHeight)];
//        self.pageLoadingImageView.center = backgroundView.center;
//        [backgroundView addSubview:self.pageLoadingImageView];
//        [self.pageLoadingView addSubview:backgroundView];
//        
//        [self.navigationController.view addSubview:self.pageLoadingView];
//    }
//    self.pageLoadingView.hidden = NO;
//    [self.pageLoadingImageView startAnimating];
//    
//}
//
//- (void)hidePageLoading
//{
//    if(self.pageLoadingView != nil){
//        self.pageLoadingView.hidden = YES;
//        [self.pageLoadingImageView stopAnimating];
//    }
//}
//
//- (void)rotateImageView:(UIImageView *)imageView{
//    // 一秒钟旋转几圈
//    CGFloat circleByOneSecond = 4.0f;
//    
//    imageView.tag = 1;
//    
//    // 执行动画
//    [UIView animateWithDuration:1.f / circleByOneSecond
//                          delay:0
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         imageView.transform = CGAffineTransformRotate(imageView.transform, M_PI_2);
//                     }
//                     completion:^(BOOL finished){
//                         if (!_animationFinished) {
//                             if(imageView.tag == 1)
//                                 [self rotateImageView:imageView];
//                         }
//                     }];
//}
//
//- (UIImageView *)rotate360DegreeWithImageView:(UIImageView *)imageView{
//    CABasicAnimation *animation = [CABasicAnimation
//                                   animationWithKeyPath:@"transform"];
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    
//    animation.toValue = [NSValue valueWithCATransform3D:
//                         CATransform3DMakeRotation(M_PI/2.0, 0.0, 0.0, 1.0) ];
//    animation.duration = 0.25;
//    
//    animation.cumulative = YES;
//    animation.repeatCount = MAXFLOAT;
//    
//    [imageView.layer addAnimation:animation forKey:nil];
//    return imageView;
//}
- (void)showCustonPageLoading {
    
    self.activityIndicatorView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0,0,50,50)];
    self.activityIndicatorView.center=self.view.center;
    [self.activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:self.activityIndicatorView];
    [self.activityIndicatorView startAnimating];
}
- (void)hideCustonPageLoading {
    
    [self.activityIndicatorView stopAnimating];
    
}
- (void)showCustonLoading {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud = hud;
}
- (void)hideCustonLoading {
    
    if (self.hud) {
        [self.hud hideAnimated:YES];
    }
}
- (void)setUpSuccessHUD{
    
    //然后显示一个成功的提示；
    MBProgressHUD *successHUD = [MBProgressHUD showHUDAddedTo:self.view animated:true];
    successHUD.label.text = Localized(@"success");
    successHUD.mode = MBProgressHUDModeText;
    successHUD.removeFromSuperViewOnHide = true;
    [successHUD hideAnimated:true afterDelay:0.5];
    
}
- (void)setUpSuccessHUD :(NSString*)text{
    
    //然后显示一个成功的提示；
    MBProgressHUD *successHUD = [MBProgressHUD showHUDAddedTo:self.view animated:true];
    successHUD.label.text = text;
    successHUD.mode = MBProgressHUDModeText;
    successHUD.removeFromSuperViewOnHide = true;
    [successHUD hideAnimated:true afterDelay:0.5];
}
- (void)setUpErrorHUD :(NSString*)error {
    
    MBProgressHUD *successHUD = [MBProgressHUD showHUDAddedTo:self.view animated:true];
    successHUD.label.text = error;
    successHUD.mode = MBProgressHUDModeText;
    successHUD.removeFromSuperViewOnHide = true;
    [successHUD hideAnimated:true afterDelay:0.5];
}
- (void)setUpOnlyTextHUD :(NSString*)text {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.offset = CGPointMake(0.f, 0.f);
    [hud hideAnimated:YES afterDelay:3.f];
}
- (void)setUpCustomSuccessHUD:(NSString*)text {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [[UIImage imageNamed:@"2"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.square = YES;
    hud.label.text = text;
    [hud hideAnimated:YES afterDelay:3.f];
}
//- (BOOL)handlerError:(id)error
//{
//    if([error[@"errno"] intValue2] == 1)
//    {
//        [self alert:Localized(@"text_net_error") button:Localized(@"ok") click:nil];
//        return TRUE;
//    }
//    
//    if ([error[@"errno"]intValue2] == 403) {
//        [self alert:Localized(@"err_forbidden") button:Localized(@"ok") click:nil];
//        return TRUE;
//    }
//    
//    if ([error[@"errno"]intValue2] == 401)
//    {
//        [self alert:Localized(@"err_need_login") button:Localized(@"ok") click:^(NSInteger clickIndex) {
//            
//            [AppDelegateInstance doLogout];
//            
//        }];
//        return TRUE;
//    }
//    
//    if ([error[@"errno"]intValue2] == 500)
//    {
//        [self alert:Localized(@"err_server") button:Localized(@"ok") click:nil];
//        [AppDelegateInstance ddError:@"API500"];
//        return TRUE;
//    }
//    
//    return false;
//}

//- (void)loadAcountInfo:(accountLoadedBlock)block
//{
//    
//    [ApiClient getAccountSuccess:^(id JSON) {
//        
//        MyLog(@"%@",JSON);
//        id data = JSON[@"data"];
//        
//        int notifCount = [data[@"cnts"][@"notif"] intValue2];
//        
//        [UserConfig setUid:[data[@"uid"] intValue2]];
//        [UserConfig setChatId:[data[@"chat_id"] intValue2]];
//        [UserConfig setNickname:data[@"nickname"]];
//        [UserConfig setGender:[data[@"gender"] intValue2]];
//        [UserConfig setAvatar:data[@"avatar"]];
//        
//        [UserConfig setCanLogin:[data[@"permissions"][@"login"] boolValue]];
//        [UserConfig setCanPostPhoto:[data[@"permissions"][@"photo"] boolValue]];
//        [UserConfig setCanPostMessage:[data[@"permissions"][@"message"] boolValue]];
//        [UserConfig setCanPostNote:[data[@"permissions"][@"note"] boolValue]];
//        [UserConfig setCanPostComment:[data[@"permissions"][@"comment"] boolValue]];
//        [UserConfig setCanSayHi:[data[@"permissions"][@"sayhi"] boolValue]];
//        [UserConfig setHasFace:[data[@"avatar_has_face"] boolValue]];
//        [UserConfig setNotif:notifCount];
//        [UserConfig setIsLock:[data[@"permissions"][@"is_lock"] boolValue]];
//        [UserConfig setStar:[data[@"star"] intValue2]];
//        [UserConfig setHideLocation:[data[@"self_hide"] boolValue]];
//        
//        if(block){
//            block();
//        }
//        
//    } andFailure:^(id error) {
//    }];
//}

- (void)backClick {
    
    [self popViewController];
}

- (void)setCustomFinishNavBar :(NSString*)title rightBtn :(UIButton*)rightBtn rightTitle:(NSString*)rightTitle{
        
    UIView *container = [[UIView alloc] init];
    container.frame = CGRectMake(0, 0, DEVICE_SIZE.width, 64);
    container.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:container];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(15, 5 + 20, 29, 29);
    [cancelBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:cancelBtn];
    
    
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.frame = CGRectMake((DEVICE_SIZE.width - 150 * autoLayoutX)/2.0, 20, 150 * autoLayoutX, kHeaderViewHeight);
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = kTitleColor;
    titleLable.font = kHeaderTitleFont;
    titleLable.text =  title;
    [container addSubview:titleLable];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColorRGB(0xE5E5E5);
    line.frame = CGRectMake(0, 64 - 0.5, DEVICE_SIZE.width, 0.5);
    [container addSubview:line];
    
    [rightBtn setTitle:rightTitle forState:UIControlStateNormal];
    [rightBtn setTitleColor:kGlobalColor forState:UIControlStateNormal];
    [rightBtn setTitleColor:UIColorRGBA(0xFF237D, 0.36) forState:UIControlStateDisabled];
    [rightBtn setTitleColor:kGlobalHighlightColor forState:UIControlStateHighlighted];
    [rightBtn sizeToFit];
    rightBtn.enabled = YES;
    rightBtn.titleLabel.font = kFontBold(18 * autoLayoutX);
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBtn.frame = CGRectMake((DEVICE_SIZE.width + 150 * autoLayoutX)/2.0, 20 + 5, DEVICE_SIZE.width - (DEVICE_SIZE.width + 150 * autoLayoutX)/2.0 - 15, 34);
    [container addSubview:rightBtn];
}
-(BOOL) isEmpty:(NSString *) str {
    
    if (!str) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}
@end
