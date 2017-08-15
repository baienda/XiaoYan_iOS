//
//  BaseContactCell.m
//  孝颜
//
//  Created by benjamin on 2017/8/15.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "BaseContactCell.h"

static CGFloat kIconHeight = 38;

@interface BaseContactCell ()
{
    
}

@property (nonatomic, strong) AvatarView *avatarView;
@property (nonatomic, strong) UILabel *nameView;

@property (nonatomic) BOOL isLineHide;

@end

@implementation BaseContactCell

+(id)cell:(UITableView *)tableView
{
    NSString *className = NSStringFromClass([self class]);
    BaseContactCell *cell = (BaseContactCell *)[tableView dequeueReusableCellWithIdentifier:className];
    if (cell == nil)
    {
        cell = [[BaseContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _avatarView = [[AvatarView alloc] init];
        [self.wrapView addSubview:_avatarView];
        
        _nameView = [[UILabel alloc] init];
        _nameView.font = kFont(16* autoLayoutY);
        _nameView.textColor = UIColorRGB(0x242427);
        [self.wrapView addSubview:_nameView];
    }
    return self;
}
- (void)dealloc
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {

}

- (void)layoutSubviews
{
    self.separatorLeftInset = 2* kLeadingMargin + kIconHeight* autoLayoutX;
    
    [super layoutSubviews];
    
    if(_isLineHide){
        self.separatorLayer.hidden = YES;
    } else {
        self.separatorLayer.hidden = NO;
    }
    
    WS(weakSelf);
    
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.wrapView.mas_left).mas_offset(kLeadingMargin);
        make.centerY.mas_equalTo(weakSelf.wrapView.mas_centerY);
        make.width.mas_equalTo(kIconHeight* autoLayoutX);
        make.height.mas_equalTo(kIconHeight* autoLayoutY);
    }];
    
    [_nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.avatarView.mas_right).mas_offset(kLeadingMargin);
        make.centerY.mas_equalTo(weakSelf.wrapView.mas_centerY);
        make.right.mas_equalTo(-kLeadingMargin - 100);
    }];
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    self.separatorLayer.hidden = NO;
}
- (void)showLine:(BOOL)show;
{
    _isLineHide = !show;
}

- (void)setAvatar:(NSString *)url
{
    [_avatarView loadURL:url];
}
- (void)setLoaclAvatar:(NSString *)imageStr {
    
    [_avatarView setLocalAvatar:[UIImage imageNamed:imageStr]];
}
- (void)setName:(NSString *)name
{
    _nameView.text = name;
}
@end
