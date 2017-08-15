//
//  DialogCell.h
//  孝颜
//
//  Created by benjamin on 2017/8/15.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "XYTableViewCell.h"

@interface DialogCell : XYTableViewCell

//@property (nonatomic, strong) EMMessage *lastMessage;
//@property (nonatomic, strong) EMConversation *conversation;

+(id)cell:(UITableView *)tableView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

//- (void)setLastMessage:(EMMessage *)message isGroupChat:(BOOL)isGroupChat;

- (void)setAvatar:(NSString *)url;

- (void)setName:(NSString *)name;

- (void)setUnreadCount:(int)unreadCount;

@end
