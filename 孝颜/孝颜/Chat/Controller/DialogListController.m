//
//  DialogListController.m
//  孝颜
//
//  Created by benjamin on 2017/8/15.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "DialogListController.h"
#import "ChatViewController.h"

#import "DialogCell.h"

@interface DialogListController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>//EMChatManagerDelegate,EMClientDelegate,EMGroupManagerDelegate
{
    dispatch_queue_t _messageQueue;
    
    BOOL hasReport;
}
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *conversations;

@end

@implementation DialogListController


- (void)loadView
{
    [super loadView];
//    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
//    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
//    [[EMClient sharedClient].groupManager addDelegate:self delegateQueue:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [[EMClient sharedClient] removeDelegate:self];
//    [[EMClient sharedClient].chatManager removeDelegate:self];
//    [[EMClient sharedClient].groupManager removeDelegate:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    _messageQueue = dispatch_queue_create("hyphenate.io", NULL);
    [self addNotice];
//    [self setNavTitle];
    [self addTableView];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self loadConversations];
    
    //存当前页面是DialogListController
//    [self setIsDialog];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [self showLikeUsDialog];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [self setIsNotDialog];
    
}
- (void)addNotice
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadConversations) name:NoticeNewMessage object:nil];
}
- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kTableViewBackgroundColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    self.tableView.subviews[0].backgroundColor = [UIColor whiteColor];
}
//- (void)loadConversations
//{
//    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
//    
//    //按照时间排序
//    NSArray *sortedArray = [conversations sortedArrayUsingComparator:^(id obj1,id obj2)
//                            {
//                                NSInteger val1 = (NSInteger)((EMConversation *)obj1).latestMessage.timestamp;
//                                NSInteger val2 = (NSInteger)((EMConversation *)obj2).latestMessage.timestamp;
//                                
//                                //升序，假如需要降序的话，只需要修改下面的逻辑
//                                if (val1 > val2)
//                                {
//                                    return NSOrderedAscending;
//                                }
//                                else
//                                {
//                                    return NSOrderedDescending;
//                                }
//                            }];
//    
//    self.conversations = sortedArray.mutableCopy;
//    
//    [self reloadBackView];
//    
//}
//- (void)reloadBackView
//{
//    if (self.conversations.count > 0) {
//        [self hideEmpty];
//        self.searchController.searchBar.hidden = NO;
//        self.tableView.scrollEnabled = YES;
//    } else {
//        [self showEmpty];
//        self.searchController.searchBar.hidden = YES;
//    }
//    
//    [self.tableView reloadData];
//}
//-(void)showEmpty
//{
//    self.tableView.scrollEnabled = NO;
//    
//    if (self.emptyView == nil) {
//        _emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_SIZE.width, DEVICE_SIZE.height)];
//        _emptyView.backgroundColor = [UIColor whiteColor];
//        [self.tableView addSubview:_emptyView];
//        
//        UIImageView *noDataView = [[UIImageView alloc]init];
//        noDataView.image = [UIImage imageNamed:@"chat_quesheng"];
//        [_emptyView addSubview:noDataView];
//        
//        [noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(self.view);
//            make.centerY.mas_equalTo(self.view).mas_offset(-70 * autoLayoutY);
//            make.width.mas_equalTo(160 * autoLayoutX);
//            make.height.mas_equalTo(160 * autoLayoutX);
//        }];
//        
//        UILabel *noChatLabel = [[UILabel alloc]init];
//        noChatLabel.text = Localized(@"no_chat");
//        noChatLabel.textColor = kSecondTitleColor;
//        noChatLabel.font = kFont(18 * autoLayoutY);
//        noChatLabel.textAlignment = NSTextAlignmentCenter;
//        [_emptyView addSubview:noChatLabel];
//        
//        [noChatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.centerX.mas_equalTo(self.view);
//            make.top.mas_equalTo(noDataView.mas_bottom).mas_equalTo(20);
//            make.width.mas_equalTo(200 * autoLayoutX);
//            make.height.mas_equalTo(20 * autoLayoutY);
//        }];
//    }
//    
//    self.emptyView.hidden = NO;
//    
//    //上报聊天记录为空
//    if(hasReport == FALSE){
//        hasReport = true;
//        [AppDelegateInstance ddError:@"ChatEmpty"];
//    }
//}

//-(void)hideEmpty
//{
//    self.tableView.scrollEnabled = YES;
//    if(self.emptyView != nil)
//        self.emptyView.hidden = TRUE;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

//    return self.conversations.count;
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    EMConversation *conversation = self.conversations.count;
    DialogCell *cell = [DialogCell cell:tableView];
//    cell.conversation = conversation;
//    [cell setLastMessage:conversation.latestMessage isGroupChat:conversation.type == EMConversationTypeGroupChat];
//    [cell setUnreadCount:[conversation unreadMessagesCount]];
    
//    DialogListController *__weak weakSelf = self;
//    [ChatUser getByChatId:conversation.conversationId type:conversation.type completion:^(ChatUser *aUser) {
//        if(aUser != nil){
//            if(cell.conversation != nil && aUser.cid != nil && [aUser.cid isEqualToString:cell.conversation.conversationId]){
//                MyLog(@"%@",aUser.avatar );
//                if([aUser.avatar length] > 0 && ![aUser.avatar  isEqualToString:@"<null>"]){
//                    [cell setAvatar:aUser.avatar ];
//                }
//                [cell setName:@"nobody"];
//                if([aUser.name length] > 0){
//                    [cell setName:[NSString stringWithFormat:@"%@",aUser.name]];
//                }
//            }
//            [weakSelf.dataDict setObject:aUser.name forKey:conversation.conversationId];
//        }
//    }];
    [cell setAvatar:@"https://n.sinaimg.cn/news/transform/20170807/E6wL-fyitamv6457474.jpg"];
    [cell setName:@"哈哈"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50* autoLayoutY;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    EMConversation *conversation = self.conversations[indexPath.row];
    ChatViewController *chat = [[ChatViewController alloc] init];
    [self pushViewController:chat animated:YES];
//    chat.chatUser = [[ChatUser alloc] initWithConversationType:conversation.conversationId conversationType:conversation.type];
    
//    if(conversation.type == EMConversationTypeGroupChat)
//    {
//        [[EMClient sharedClient].groupManager getGroupSpecificationFromServerByID:conversation.conversationId includeMembersList:YES completion:^(EMGroup *aGroup, EMError *aError) {
//            
//            chat.groupOwner = aGroup.owner;
//        }];
//    }
//    [self pushViewController:chat animated:YES];
//    
//    __weak typeof (self) weakSelf = self;
//    [chat setPopConversationBlock:^{
//        [weakSelf.tableView reloadData];
//    }];
//    
//    [chat setCreateConvNoMsgBlock:^(NSString *group_chatid){
//        
//        [[EMClient sharedClient].chatManager getConversation:group_chatid type:EMConversationTypeGroupChat createIfNotExist:YES];
//        
//    }];
//    if (self.searchController.active)
//    {
//        [self.searchController setActive:NO];
        //        [self.searchController.searchBar resignFirstResponder];
        //        [self.searchController dismissViewControllerAnimated:YES completion:nil];
//    }
}
//- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    NSMutableArray *conversations;
//    if (!self.searchController.active) {
//        conversations = self.conversations;
//    }
//    else
//    {
//        conversations = self.conversationSearched;
//    }
//    
//    if (indexPath.row + 1 > conversations.count) return nil;
//    
//    EMConversation *conver = [conversations objectAtIndex:indexPath.row];
//    
//    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:Localized(@"delete") handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
//        
//        [FBSDKAppEvents logEvent:@"DoaLogListDeleteConversation"];
//        
//        //删除环信服务器中的会话
//        __weak typeof (self) weakSelf = self;
//        [[EMClient sharedClient].chatManager deleteConversations:@[conver] isDeleteMessages:YES completion:^(EMError *aError) {
//            [[EMClient sharedClient].chatManager getConversation:conver.conversationId type:conver.type createIfNotExist:NO];
//            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
//            [weakSelf loadConversations];
//        }];
//        //移除缓存对话框文字
//        [[Database instance] deleteChatTextById:conver.conversationId];
//        //删除会话UI
//        [self.conversations removeObject:conver];
//        [self.conversationSearched removeObject:conver];
//        
//        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        
//    }];
//    
//    deleteRowAction.backgroundColor = kGlobalColor;
//    
//    UITableViewRowAction *unreadAction;
//    if (conver.unreadMessagesCount > 0) {
//        
//        unreadAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:Localized(@"set_readed") handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
//            
//            [FBSDKAppEvents logEvent:@"DoaLogListUnread"];
//            
//            [conver markAllMessagesAsRead:nil];
//            
//            [self reloadBackView];
//            
//        }];
//        unreadAction.backgroundColor = kGrayColor;
//    }
//    
//    if (conver.unreadMessagesCount > 0) {
//        return @[deleteRowAction,unreadAction];
//    }
//    else
//    {
//        return @[deleteRowAction];
//    }
//    
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = self.tableView.contentOffset.y;
    if(y > 36){
        [self setLineColor:UIColorRGB(0xE5E5E5)];
    } else {
        [self setLineColor:[UIColor whiteColor]];
    }
}
//- (void)connectionStateDidChange:(EMConnectionState)aConnectionState
//{
//    if (aConnectionState == EMConnectionDisconnected) {
//        MyLog(@"网络断开，重连中...");
//        [self setTitleText:Localized(@"connecting")];
//    }else{
//        MyLog(@"自动重连接成功...");
//        [self setTitleText:Localized(@"chat")];
//        [[EMClient sharedClient] loginWithUsername:[UserConfig getChatName] password:[UserConfig getChatPassword] completion: nil];
//    }
//    
//}
//#pragma mark 自动登录的回调
//- (void)autoLoginDidCompleteWithError:(EMError *)aError{
//    if (!aError) {
//        MyLog(@"自动登录成功...");
//        [self setTitleText:Localized(@"chat")];
//    }else{
//        MyLog(@"自动登录失败 %@",aError);
//        [self setTitleText:Localized(@"im_unable_to_network")];
//    }
//}

@end
