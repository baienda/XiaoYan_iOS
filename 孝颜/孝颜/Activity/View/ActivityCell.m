//
//  ActivityCell.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "ActivityCell.h"

static CGFloat kTopMargin = 10;
static CGFloat KPhotoHeight = 300;
//static CGFloat kTimeWidth = 100;
static CGFloat KJoinWidth = 100;
static CGFloat kJoinHeight = 50;
static CGFloat kJoinTop = 30;
static CGFloat KTagWidth = 80;
static CGFloat kTagHeight = 20;



@interface ActivityCell ()
{
    
}

@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UILabel *subTitleView;
@property (nonatomic, strong) UILabel *timeView;
@property (nonatomic, strong) UIButton *tagView;
@property (nonatomic, strong) UIButton *joinView;

@property (nonatomic) BOOL isLineHide;

@end

@implementation ActivityCell

+(id)cell:(UITableView *)tableView
{
    NSString *className = NSStringFromClass([self class]);
    ActivityCell *cell = (ActivityCell *)[tableView dequeueReusableCellWithIdentifier:className];
    if (cell == nil)
    {
        cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _photoView = [[UIImageView alloc] init];
        [self.wrapView addSubview:_photoView];
        
        _titleView = [[UILabel alloc] init];
        _titleView.font = kFont(14* autoLayoutY);
        _titleView.textColor = kTitleColor;
        [self.wrapView addSubview:_titleView];
        
        _subTitleView = [[UILabel alloc] init];
        _subTitleView.font = kFont(12* autoLayoutY);
        _subTitleView.textColor = kSecondTitleColor;
        [self.wrapView addSubview:_subTitleView];
        
        
        _tagView = [[UIButton alloc] init];
        _tagView.titleLabel.font = kFont(14* autoLayoutY);
        _tagView.layer.cornerRadius = 2* autoLayoutY;
        _tagView.clipsToBounds = YES;
        _tagView.layer.borderColor = kSecondTitleColor.CGColor;
        _tagView.layer.borderWidth = 0.5;
        _tagView.adjustsImageWhenDisabled = NO;
        [_tagView setTitleColor:kSecondTitleColor forState:UIControlStateNormal];
        [_tagView setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_tagView setBackgroundColor:kWhiteColor];
        [self.wrapView addSubview:_tagView];
        
        _joinView = [[UIButton alloc] init];
        _joinView.titleLabel.font = kFont(16* autoLayoutY);
        _joinView.layer.cornerRadius = kJoinHeight/2;
        _joinView.clipsToBounds = YES;
        _joinView.adjustsImageWhenDisabled = NO;
        [_joinView setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_joinView setBackgroundColor:kGrayColor];
        [_joinView setAlpha:0.7];
        [self.wrapView addSubview:_joinView];
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
    
    [_photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.wrapView.mas_left);
        make.top.mas_equalTo(weakself.wrapView.mas_top);
        make.right.mas_equalTo(weakself.wrapView.mas_right);
        make.height.mas_equalTo(KPhotoHeight* autoLayoutY);
    }];
    
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.wrapView.mas_left).mas_offset(kLeadingMargin);
        make.top.mas_equalTo(weakself.photoView.mas_bottom).mas_offset(kTopMargin);
        make.right.mas_equalTo(weakself.wrapView.mas_right).mas_offset(-kLeadingMargin);
    }];

    [_subTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.wrapView.mas_left).mas_offset(kLeadingMargin);
        make.top.mas_equalTo(weakself.titleView.mas_bottom).mas_offset(kTopMargin);
        make.right.mas_equalTo(weakself.wrapView.mas_right).mas_offset(-kLeadingMargin);
    }];

    [_joinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakself.wrapView.mas_right).mas_offset(kJoinHeight/2);
        make.top.mas_equalTo(weakself.wrapView.mas_top).mas_offset(kJoinTop);
        make.width.mas_equalTo(KJoinWidth* autoLayoutX);
        make.height.mas_equalTo(kJoinHeight* autoLayoutY);
    }];
    
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kLeadingMargin);
        make.top.mas_equalTo(weakself.subTitleView.mas_bottom).mas_offset(kTopMargin);
        make.width.mas_equalTo(KTagWidth* autoLayoutX);
        make.height.mas_equalTo(kTagHeight* autoLayoutY);
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
- (void)setImage:(NSString *)url {
    
    [_photoView setThumbnailWithURL:url completion:nil];
}
- (void)setTitle:(NSString *)title {
    
    _titleView.text = title;
    
}
- (void)setSubTitleAndTime:(NSString*)subTitleAndTime{
    
    _subTitleView.text = subTitleAndTime;
}
- (void)setTime:(NSString*)time {
    
    _timeView.text = time;
    
}
- (void)setTag:(NSString*)tag {
    
    [_tagView setTitle:tag forState:UIControlStateNormal];
}
- (void)setJoinTitle:(BOOL)join {
    
    if (join) {
        [_joinView setTitle:Localized(@"正在进行") forState:UIControlStateNormal];
        [_joinView setTitleColor:kGlobalColor forState:UIControlStateNormal];
        [_joinView addTarget:self action:@selector(joinClick) forControlEvents:UIControlEventTouchUpInside];
        
    }else {
        [_joinView setTitle:Localized(@"已结束") forState:UIControlStateNormal];
        [_joinView setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_joinView removeTarget:self action:@selector(joinClick) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)joinClick {
    
    if(self.XYiewController == nil) return;
    
}
@end
