//
//  CommunityCell.m
//  孝颜
//
//  Created by benjamin on 2017/8/14.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "CommunityCell.h"

static CGFloat kTopMargin = 10;

@interface CommunityCell ()
{
    
}

@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UILabel *subTitleView;

@property (nonatomic) BOOL isLineHide;

@end

@implementation CommunityCell

+(id)cell:(UITableView *)tableView
{
    NSString *className = NSStringFromClass([self class]);
    CommunityCell *cell = (CommunityCell *)[tableView dequeueReusableCellWithIdentifier:className];
    if (cell == nil)
    {
        cell = [[CommunityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _titleView = [[UILabel alloc] init];
        _titleView.font = kFont(14* autoLayoutY);
        _titleView.textColor = kTitleColor;
        [self.wrapView addSubview:_titleView];
        
        _subTitleView = [[UILabel alloc] init];
        _subTitleView.font = kFont(12* autoLayoutY);
        _subTitleView.textColor = kSecondTitleColor;
        [self.wrapView addSubview:_subTitleView];
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
        make.left.mas_equalTo(kLeadingMargin);
        make.top.mas_equalTo(kTopMargin);
        make.right.mas_equalTo(-kLeadingMargin);
    }];
    [_subTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.wrapView.mas_left).mas_offset(kLeadingMargin);
        make.bottom.mas_equalTo(weakself.wrapView.mas_bottom).mas_offset(-kTopMargin);
        make.right.mas_equalTo(-kLeadingMargin);
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
- (void)setTitle:(NSString *)title {
    
    _titleView.text = title;
    
}
- (void)setSubTitle:(NSString*)subTitle {
    
    _subTitleView.text = subTitle;
}
@end
