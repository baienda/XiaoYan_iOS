//
//  SettingSwitchCell.m
//  孝颜
//
//  Created by benjamin on 2017/8/14.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "SettingSwitchCell.h"


@interface SettingSwitchCell ()
{
    
}

@property (nonatomic) BOOL isLineHide;

@end

@implementation SettingSwitchCell

+(id)cell:(UITableView *)tableView
{
    NSString *className = NSStringFromClass([self class]);
    SettingSwitchCell *cell = (SettingSwitchCell *)[tableView dequeueReusableCellWithIdentifier:className];
    if (cell == nil)
    {
        cell = [[SettingSwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _titleView= [[UILabel alloc] init];
        _titleView.font = kFont(14* autoLayoutY);
        _titleView.textColor = kTitleColor;
        [self.wrapView addSubview:_titleView];
        
        _switchView = [[UISwitch alloc] init];
        _switchView.onTintColor= kGlobalColor;
        _switchView.tintColor = kLineColor;
        _switchView.transform= CGAffineTransformMakeScale(0.8,0.8);
        [self.wrapView addSubview:_switchView];
        
        _uplineView = [[UIView alloc] init];
        _uplineView.backgroundColor = kLineColor;
        [self.wrapView addSubview:_uplineView];
        
        _downlineView = [[UIView alloc] init];
        _downlineView.backgroundColor = kLineColor;
        [self.wrapView addSubview:_downlineView];
        
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
    [super layoutSubviews];
    
    WS(weakself);
    
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.wrapView.mas_left).mas_offset(kLeadingMargin);
        make.right.mas_equalTo(weakself.wrapView.mas_right).mas_offset(-kLeadingMargin - 80);
        make.centerY.mas_equalTo(weakself.wrapView.mas_centerY);
    }];
    [_switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kLeadingMargin);
        make.centerY.mas_equalTo(weakself.wrapView.mas_centerY);
    }];
    
    [_downlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [_uplineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    self.separatorLayer.hidden = NO;
}
@end
