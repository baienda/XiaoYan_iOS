//
//  XYRootViewController.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "XYRootViewController.h"
#import "XYRootTableView.h"
#import "XYNavigationController.h"

@interface XYRootViewController ()
{
    XYRootTableView *_mainView;
    
    XYNavigationController *_masterNavigationController;
    XYNavigationController *_detailNavigationController;
    
    BOOL _hasLoadViewDone;
}

@end

@implementation XYRootViewController

- (instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        _courseViewController = [[CourseViewController alloc] init];
        _activityViewController = [[ActivityViewController alloc] init];
        _videoViewController = [[VideoViewController alloc]init];
        _mineViewController = [[MineViewController alloc] init];
        
        _mainTabsController = [[XYRootTabsController alloc] init];
        _masterNavigationController = [XYNavigationController navigationControllerWithControllers:@[]];
        _detailNavigationController = [XYNavigationController navigationControllerWithControllers:@[]];
    }
    return self;
}

- (bool)shouldAutorotate {
    return [(UIViewController *)[self viewControllers].lastObject shouldAutorotate];
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = UIColorRGBA(0xf2f2f5, 1.0f);
    
    _mainView = [[XYRootTableView alloc] initWithFrame:self.view.bounds];
    _mainView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mainView.hidden = TRUE;
    [self.view addSubview:_mainView];
    
    [self loadViewAfterLogin];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadUnreadMessage) name:NoticeNewMessage object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppActived) name:NoticeLocationAppActived object:nil];
    //获取最新IM消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendBaseViewControllerNewMessage) name:@"BaseViewControllerShowTipsNotice" object:nil];
//    //收到通话
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReceiveCallNotice:) name:ReceiveCallNotice object:nil];
//    
//    //接受通话
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReceiveCallAcceptNotice:) name:ReceiveCallAcceptNotice object:nil];
//    
//    //通话结束
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReceiveCallEndNotice:) name:CallHangUpNotice object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)loadUnreadMessage
{
//    int unreadCount = [[IMCore instance] getUnreadCount];
//    [_mainTabsController setUnreadCount:unreadCount];
}

- (void)onAppActived
{
    if(![UserConfig isLogined]){
        return;
    }
    
//    [self loadAcountInfo:nil];
    
//    [_mainTabsController setMomentCount:[UserConfig getNotif]];
}

- (void)loadViewAfterLogin
{
//    if(![UserConfig isLogined]){
//        return;
//    }
//    
//    if(_hasLoadViewDone){
//        return;
//    }
    
    _hasLoadViewDone = TRUE;
    
    _mainView.hidden = FALSE;
    [_mainTabsController setViewControllers:[NSArray arrayWithObjects:_courseViewController, _activityViewController, _videoViewController,_mineViewController, nil]];
    [_mainTabsController setSelectedIndex:0];
    
    [self updateSizeClass];
    
    if (_masterNavigationController.viewControllers.count != 0) {
        [self addMasterController];
    }
    
    if (_detailNavigationController.viewControllers.count != 0) {
        [self addDetailController];
    }
    
//    [self loadUnreadMessage];
    
//    [self loadAcountInfo:nil];
}

- (void)loginDone
{
//    if(_hasLoadViewDone)
//    {
//        if(_courseViewController.viewControllerHasEverAppeared){
//            [_courseViewController refresh];
//        }
//        
//        if(_activityViewController.viewControllerHasEverAppeared){
//            [_activityViewController refresh];
//        }
//        
//        if(_mineViewController.viewControllerHasEverAppeared){
//            [_mineViewController refresh];
//        }
//    }
//    //mineBase刷新(mineBase刷新调用baseVC的viewDidAppear界面会有问题)
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"mineBaseRefreshNotice" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    //通知未开启
//    if([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIRemoteNotificationTypeNone)
//    {
//        
//    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadViewAfterLogin];
}

- (void)pushContentController:(UIViewController *)contentController {
    if (_detailNavigationController.viewControllers.count == 0) {
        [_detailNavigationController setViewControllers:@[contentController] animated:false];
        
        [self addDetailController];
    } else {
        [_detailNavigationController pushViewController:contentController animated:true];
    }
}

- (void)replaceContentController:(UIViewController *)contentController {
    bool addDetail = _detailNavigationController.viewControllers.count == 0;
    [_detailNavigationController setViewControllers:@[_mainTabsController, contentController] animated:true];
    if (addDetail) {
        [self addDetailController];
    }
}

- (void)popToContentController:(UIViewController *)contentController {
    [_detailNavigationController popToViewController:contentController animated:true];
}

- (void)clearContentControllers {
    [_detailNavigationController popToRootViewControllerAnimated:true];
}

- (NSArray *)viewControllers {
    return [_masterNavigationController.viewControllers arrayByAddingObjectsFromArray:_detailNavigationController.viewControllers];
}

- (void)updateSizeClass {
    [self removeMasterController];
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    if (_masterNavigationController.viewControllers.count != 0) {
        [viewControllers addObject:_masterNavigationController.viewControllers[0]];
    } else {
        [viewControllers addObject:_mainTabsController];
    }
    for (UIViewController *controller in _detailNavigationController.viewControllers) {
        if (![viewControllers containsObject:controller]) {
            [viewControllers addObject:controller];
        }
    }
    if (_masterNavigationController.viewControllers.count > 1) {
        for (NSUInteger i = 1; i < _masterNavigationController.viewControllers.count - 1; i++) {
            [viewControllers addObject:_masterNavigationController.viewControllers[i]];
        }
    }
    [_masterNavigationController setViewControllers:@[] animated:false];
    
    for (UIViewController *controller in [[NSArray alloc] initWithArray:_masterNavigationController.viewControllers]) {
        [controller willMoveToParentViewController:nil];
        [controller.view removeFromSuperview];
        [controller removeFromParentViewController];
        [controller didMoveToParentViewController:nil];
    }
    bool addDetail = _detailNavigationController.viewControllers.count == 0;
    [_detailNavigationController setViewControllers:viewControllers animated:false];
    if (addDetail) {
        [self addDetailController];
    }
    
    [_mainView setFullScreenDetail:true];
}

- (void)localizationUpdated {
    [_mainTabsController localizationUpdated];
}

- (void)removeDetailController {
    if (_detailNavigationController.parentViewController != nil) {
        [_detailNavigationController willMoveToParentViewController:nil];
        [_detailNavigationController removeFromParentViewController];
        [_mainView setDetailView:nil];
        [_detailNavigationController didMoveToParentViewController:nil];
    }
}

- (void)addDetailController {
    if (_detailNavigationController.parentViewController != self) {
        [_detailNavigationController willMoveToParentViewController:self];
        [self addChildViewController:_detailNavigationController];
        [_mainView setDetailView:_detailNavigationController.view];
        [_detailNavigationController didMoveToParentViewController:self];
    }
}

- (void)removeMasterController {
    if (_masterNavigationController.parentViewController != nil) {
        [_masterNavigationController willMoveToParentViewController:nil];
        [_masterNavigationController removeFromParentViewController];
        [_mainView setMasterView:nil];
        [_masterNavigationController didMoveToParentViewController:nil];
    }
}

- (void)addMasterController {
    if (_masterNavigationController.parentViewController != self) {
        [_masterNavigationController willMoveToParentViewController:self];
        [self addChildViewController:_masterNavigationController];
        [_mainView setMasterView:_masterNavigationController.view];
        [_masterNavigationController didMoveToParentViewController:self];
    }
}

- (bool)isSplitView {
    if (iosMajorVersion() < 9 || [UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPad)
        return false;
    
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact)
        return true;
    
    if (fabs(self.view.frame.size.width - [UIScreen mainScreen].bounds.size.width) > FLT_EPSILON)
        return true;
    
    return false;
}

- (CGRect)applicationBounds {
    CGSize screenSize = ScreenSize();
    CGFloat min = MIN(screenSize.width, screenSize.height);
    CGFloat max = MAX(screenSize.width, screenSize.height);
    
    CGSize size = CGSizeZero;
    CGSize (^sizeByDeviceOrientation)(void) = ^CGSize {
        if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation))
            return CGSizeMake(min, max);
        else
            return CGSizeMake(max, min);
    };
    
    if (![self isSplitView])
        size = sizeByDeviceOrientation();
    else
        size = self.view.frame.size;
    
    return (CGRect){ CGPointZero, size };
}
- (void)sendBaseViewControllerNewMessage {
    
    [UserDefault setBool:@"BaseViewShowTipOnceNewMessageNotice" value:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendBaseViewControllerNewMessageNotice" object:nil];
}


- (void)getUserData:(int)uid completion:(void (^)(NSDictionary *dict))aCompletionBlock
{
    OnlyUidParams* params = [OnlyUidParams alloc];
    params.uid = uid;
    
    [ApiClient getProfileInfoSuccess:^(id JSON) {
        
        MyLog(@"%@",JSON);
        
        if (JSON[@"data"] == nil) return;
        
        aCompletionBlock(JSON[@"data"]);
        
    } andFailure:^(id error) {
        
    } andParams:params];
}

//- (void)ReceiveCallNotice:(NSNotification *)notification
//{
//    EMCallSession *aSession = notification.object;
//    if(aSession){
//        //        [self startCallTimer];
//        
//        __weak typeof (self) weakSelf = self;
//        NSString *temp = [NSString stringWithFormat:@"%@",aSession.remoteName];
//        NSArray *array = [temp componentsSeparatedByString:@"."];
//        int uid = [array.lastObject intValue2];
//        
//        NSString *content = aSession.type == EMCallTypeVideo ? Localized(@"call_invite_you_video") : Localized(@"call_invite_you_voice");
//        
//        [self getUserData:uid completion:^(NSDictionary *dict) {
//            CallViewController *callController = [[CallViewController alloc] initWithSession:aSession isCaller:NO status:content];
//            callController.modalPresentationStyle = UIModalPresentationOverFullScreen;
//            callController.infoDict = dict;
//            self.callController = callController;
//            [weakSelf presentViewController:callController animated:NO completion:nil];
//            
//            [callController beginRing];
//        }];
//        
//    }
//}

//- (void)ReceiveCallAcceptNotice:(NSNotification *)notification
//{
//    EMCallSession *aSession = notification.object;
//    if(aSession){
//        if (aSession.type == EMCallTypeVoice) {
//            [_callController voiceConnected];
//        }
//        else
//        {
//            _callController.switchCameraButton.hidden = NO;
//            
//            [_callController.bgImageView removeFromSuperview];
//            
//            [_callController.icon removeFromSuperview];
//            
//            [_callController.nameLabel removeFromSuperview];
//            
//            [_callController AddTap];
//        }
//        [_callController.ringPlayer stop];
//        _callController.statusLabel.text = @" ";
//        _callController.timeLabel.hidden = NO;
//        [_callController startTimer];
//        [_callController startShowInfo];
//        _callController.cancelButton.hidden = NO;
//        _callController.cancelLabel.hidden = NO;
//        _callController.rejectButton.hidden = YES;
//        _callController.rejectLabel.hidden = YES;
//        _callController.answerButton.hidden = YES;
//        _callController.answerLabel.hidden = YES;
//    }
//}

//- (void)ReceiveCallEndNotice:(NSNotification *)notification
//{
//    [_callController close];
//}
@end
