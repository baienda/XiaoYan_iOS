//
//  HotCourseCell.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "HotCourseCell.h"
#import "JoinCourseController.h"

static CGFloat kTopMargin = 10;
static CGFloat kPhotoWidth = 80;
static CGFloat KPhotoHeight = 60;
static CGFloat kTimeWidth = 100;
static CGFloat KJoinWidth = 60;
static CGFloat kJoinHeight = 20;

@interface HotCourseCell ()
{
    
}

@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UILabel *subTitleView;
@property (nonatomic, strong) UILabel *timeView;

@property (nonatomic, strong) UIButton *joinView;

@property (nonatomic) BOOL isLineHide;

@end

@implementation HotCourseCell

+(id)cell:(UITableView *)tableView
{
    NSString *className = NSStringFromClass([self class]);
    HotCourseCell *cell = (HotCourseCell *)[tableView dequeueReusableCellWithIdentifier:className];
    if (cell == nil)
    {
        cell = [[HotCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
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
        
        _timeView = [[UILabel alloc] init];
        _timeView.font = kFont(12* autoLayoutY);
        _timeView.textColor = kSecondTitleColor;
        [self.wrapView addSubview:_timeView];
        
        _joinView = [[UIButton alloc] init];
        _joinView.titleLabel.font = kFont(14* autoLayoutY);
        _joinView.layer.cornerRadius = 2* autoLayoutY;
        _joinView.clipsToBounds = YES;
        _joinView.layer.borderColor = kSecondTitleColor.CGColor;
        _joinView.layer.borderWidth = 0.5;
        _joinView.adjustsImageWhenDisabled = NO;
        [_joinView setTitleColor:kSecondTitleColor forState:UIControlStateNormal];
        [_joinView setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_joinView setBackgroundColor:kWhiteColor];
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
        make.left.mas_equalTo(weakself.wrapView.mas_left).mas_offset(kLeadingMargin);
        make.top.mas_equalTo(weakself.wrapView.mas_top).mas_offset(kTopMargin);
        make.width.mas_equalTo(kPhotoWidth* autoLayoutX);
        make.height.mas_equalTo(KPhotoHeight* autoLayoutY);
    }];
    
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.photoView.mas_right).mas_offset(kLeadingMargin);
        make.top.mas_equalTo(weakself.photoView.mas_top);
        make.right.mas_equalTo(weakself.wrapView.mas_right).mas_offset(-kLeadingMargin);
    }];
    
    [_timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.photoView.mas_right).mas_offset(kLeadingMargin);
        make.bottom.mas_equalTo(weakself.photoView.mas_bottom);
        make.width.mas_equalTo(kTimeWidth* autoLayoutX);
    }];
    
    [_subTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.photoView.mas_right).mas_offset(kLeadingMargin);
        make.bottom.mas_equalTo(weakself.timeView.mas_top).mas_offset(-5);
        make.width.mas_equalTo(kTimeWidth* autoLayoutX);
    }];
    
    [_joinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakself.wrapView.mas_right).mas_offset(-kLeadingMargin);
        make.bottom.mas_equalTo(weakself.wrapView.mas_bottom).mas_equalTo(-kTopMargin);
        make.width.mas_equalTo(KJoinWidth* autoLayoutX);
        make.height.mas_equalTo(kJoinHeight* autoLayoutY);
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
- (void)setSubTitle:(NSString*)subTitle {

    _subTitleView.text = subTitle;
}
- (void)setTime:(NSString*)time {
    
    _timeView.text = time;

}
- (void)setJoinTitle:(BOOL)join {

    if (join) {
        [_joinView setTitle:Localized(@"正在报名") forState:UIControlStateNormal];
        [_joinView setTitleColor:kGlobalColor forState:UIControlStateNormal];
        [_joinView addTarget:self action:@selector(joinClick) forControlEvents:UIControlEventTouchUpInside];

    }else {
        [_joinView setTitle:Localized(@"报名截止") forState:UIControlStateNormal];
        [_joinView setTitleColor:kGrayColor forState:UIControlStateNormal];
        [_joinView removeTarget:self action:@selector(joinClick) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)joinClick {
    
    if(self.XYiewController == nil) return;
    JoinCourseController* JoinVC = [[JoinCourseController alloc] init];
    JoinVC.hidesBottomBarWhenPushed = YES;
    [self.XYiewController pushViewController:JoinVC animated:YES];

}

@end
