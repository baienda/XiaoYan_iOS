//
//  DialogCell.m
//  孝颜
//
//  Created by benjamin on 2017/8/15.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "DialogCell.h"
#import "AvatarView.h"
#import "ChatTimeTool.h"
#import "UserConfig.h"
//#import "Database.h"

static CGFloat kIconHeight = 38;

@interface DialogCell(){

}
@property (nonatomic, strong) AvatarView *avatarView;
@property (nonatomic, strong) UILabel *nameView;
@property (nonatomic, strong) UILabel *timeView;
@property (nonatomic, strong) UILabel *subtitleView;

@property (nonatomic, strong) UILabel *countView;
@property (nonatomic, strong) UIImageView *statusView;

@end
@implementation DialogCell

+(id)cell:(UITableView *)tableView
{
    NSString *className = NSStringFromClass([self class]);
    DialogCell *cell = (DialogCell *)[tableView dequeueReusableCellWithIdentifier:className];
    if (cell == nil)
    {
        cell = [[DialogCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.superview.clipsToBounds = false;
        
        _avatarView = [[AvatarView alloc] init];
        [self.wrapView addSubview:_avatarView];
        
        _nameView = [[UILabel alloc] init];
        _nameView.font = kFont(16* autoLayoutY);
        _nameView.textColor = UIColorRGB(0x242427);
        [self.wrapView addSubview:_nameView];
        
        _timeView = [[UILabel alloc] init];
        _timeView.font = kFont(10* autoLayoutY);
        _timeView.textColor = UIColorRGB(0xC5C5CA);
        [self.wrapView addSubview:_timeView];
        
        _subtitleView = [[UILabel alloc] init];
        _subtitleView.font = kFont(14* autoLayoutY);
        _subtitleView.textColor = UIColorRGB(0xb8b3b4);
        [self.wrapView addSubview:_subtitleView];
        
        _countView = [[UILabel alloc] init];
        _countView.font = kFont(12* autoLayoutY);
        _countView.textColor = [UIColor whiteColor];
        _countView.layer.masksToBounds = YES;
        _countView.layer.cornerRadius = 12;
        _countView.backgroundColor = UIColorRGB(0xFF66A5);
        _countView.hidden = YES;
        _countView.clipsToBounds = YES;
        _countView.textAlignment = NSTextAlignmentCenter;
        [self.wrapView addSubview:_countView];
        
        _statusView = [[UIImageView alloc] init];
        _statusView.contentMode = UIViewContentModeScaleAspectFill;
        _statusView.hidden = YES;
        [self.wrapView addSubview:_statusView];
        
    }
    return self;
}

- (void)layoutSubviews
{
    self.separatorLeftInset = 2* kLeadingMargin + kIconHeight* autoLayoutY;
    
    [super layoutSubviews];
    
    CGRect frame = self.wrapView.frame;
    WS(weakSelf);
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kLeadingMargin);
        make.centerY.mas_equalTo(weakSelf.wrapView.mas_centerY);
        make.width.mas_equalTo(kIconHeight* autoLayoutX);
        make.height.mas_equalTo(kIconHeight* autoLayoutY);
    }];
    
    CGSize timeSize = [_timeView.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_timeView.font} context:nil].size;
    
    [_timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kLeadingMargin);
        make.top.mas_equalTo(weakSelf.avatarView.mas_top);
        make.width.mas_equalTo(timeSize.width);
    }];
    
    [_nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.avatarView.mas_right).mas_offset(kLeadingMargin);
        make.top.mas_equalTo(16);
        make.right.mas_equalTo(-kLeadingMargin * 2 - timeSize.width);
    }];
    
    [_subtitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.avatarView.mas_right).mas_offset(kLeadingMargin);
        make.top.mas_equalTo(weakSelf.nameView.mas_bottom).mas_offset(0);
        make.right.mas_equalTo(-kLeadingMargin);
    }];
    
//    CGSize countSize = [_countView.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_countView.font} context:nil].size;
//    if(countSize.width < 12) countSize.width = 12;
    
//    _countView.frame = CGRectMake(frame.size.width - countSize.width - 12 - 15, 38, countSize.width + 12, 24);
//    
//    _statusView.frame = CGRectMake(frame.size.width - 14 - 15, 46, 14, 14);
}

- (void)prepareForReuse
{
    [super prepareForReuse];
//    _nameView.text = @"";
//    _subtitleView.text = @"";
//    _countView.hidden = YES;
//    _statusView.hidden = YES;
//    [_avatarView setDefault:TRUE];
}

//- (void)setLastMessage:(EMMessage *)message isGroupChat:(BOOL)isGroupChat
//{
//    NSString *lastMessageBody = [[IMCore instance] getMessageDigest:message];
//    NSString *content = [EaseConvertToCommonEmoticonsHelper
//                         convertToSystemEmoticons:lastMessageBody];
//    _timeView.text = [NSString stringWithFormat:@"%@",[ChatTimeTool timeStr:message.timestamp]];
//    _subtitleView.text = content;
//    
//    self.lastMessage = message;
//    
//    if (isGroupChat) {
//        [_avatarView setDefaultGroup];
//        __weak typeof (self) weakSelf = self;
//        [ChatUser getByChatId:message.from completion:^(ChatUser *aUser) {
//            if(aUser){
//                if(weakSelf.lastMessage != nil && aUser.cid != nil && [weakSelf.lastMessage.from isEqualToString:aUser.cid]){
//                    weakSelf.subtitleView.text = [NSString stringWithFormat:@"%@: %@", aUser.name, lastMessageBody];
//                }
//            }
//        }];
//    }
//    else
//    {
//        [_avatarView setDefault:TRUE];
//    }
//    //草稿
//    NSString* cacheText = [[Database instance] loadChatTextById:self.conversation.conversationId];
//    if (![cacheText isEqualToString:@""]&& cacheText != nil) {
//        
//        NSAttributedString* cacheAtt = [[NSAttributedString alloc] initWithString:cacheText];
//        NSString* draft = Localized(@"draft");
//        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:draft];
//        [str addAttribute:NSForegroundColorAttributeName value:kGlobalColor range:NSMakeRange(0, [draft length])];
//        [str appendAttributedString:cacheAtt];
//        _subtitleView.attributedText = str;
//    }
//    _statusView.hidden = YES;
//    
//    if(message.direction == EMMessageDirectionSend){
//        if(message.status == EMMessageStatusSuccessed){
//            if(message.isReadAcked == YES){
//                _statusView.hidden = NO;
//                _statusView.image = [UIImage imageNamed:@"chat_icon_yidu"];
//            } else {
//                _statusView.hidden = NO;
//                _statusView.image = [UIImage imageNamed:@"chat_icon_songda"];
//            }
//        } else if(message.status == EMMessageStatusFailed){
//            _statusView.hidden = NO;
//            _statusView.image = [UIImage imageNamed:@"chat_icon_error"];
//        }
//    }
//}

- (void)setUnreadCount:(int)unreadCount
{
    if (unreadCount == 0) {
        _countView.hidden = YES;
    } else {
        _statusView.hidden = YES;
        _countView.hidden = NO;
        
        if(unreadCount > 99){
            _countView.text = @"99+";
        } else {
            _countView.text = [NSString stringWithFormat:@"%d", unreadCount];
        }
    }
}

- (void)setAvatar:(NSString *)url
{
    [_avatarView loadURL:url];
}

- (void)setName:(NSString *)name
{
    _nameView.text = name;
}

@end
