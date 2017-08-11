//
//  MineBaseCell.m
//  孝颜
//
//  Created by benjamin on 2017/8/11.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "MineBaseCell.h"

@implementation MineBaseCell


+(id)cell:(UITableView *)tableView
{
    NSString *className = NSStringFromClass([self class]);
    MineBaseCell *cell = (MineBaseCell *)[tableView dequeueReusableCellWithIdentifier:className];
    if (cell == nil)
    {
        cell = [[MineBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _icon = [[UIImageView alloc] init];
        [self.wrapView addSubview:_icon];
        
        _title = [[UILabel alloc] init];
        _title.font = kFont(14* autoLayoutY);
        _title.textColor = kTitleColor;
        [self.wrapView addSubview:_title];
        
        _arrow = [[UIImageView alloc] init];
        _arrow.image = [UIImage imageNamed:@"2"];
        [self.wrapView addSubview:_arrow];
        
        _underline = [[UIView alloc] init];
        _underline.backgroundColor = kLineColor;
        [self.wrapView addSubview:_underline];
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
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.wrapView.mas_left).mas_offset(kLeadingMargin);
        make.centerY.mas_equalTo(weakself.wrapView.mas_centerY);
        make.width.mas_equalTo(28* autoLayoutX);
        make.height.mas_equalTo(28* autoLayoutY);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.icon.mas_right).mas_offset(kLeadingMargin);
        make.right.mas_equalTo(weakself.wrapView.mas_right).mas_offset(-kLeadingMargin - 40);
        make.centerY.mas_equalTo(weakself.wrapView.mas_centerY);
    }];
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakself.wrapView.mas_right).mas_offset(-kLeadingMargin);
        make.centerY.mas_equalTo(weakself.wrapView.mas_centerY);
        make.height.mas_equalTo(12* autoLayoutY);
        make.width.mas_equalTo(12* autoLayoutY);
    }];
    [_underline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
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
