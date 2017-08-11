//
//  VideoTypeCell.m
//  孝颜
//
//  Created by benjamin on 2017/8/11.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "VideoTypeCell.h"

@interface VideoTypeCell ()
{
    
}

@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UILabel *subTitleView;
@property (nonatomic, strong) UIView *centerView;//主副标题subView
@property (nonatomic, strong) UIView *maskView;//蒙版

@property (nonatomic) BOOL isLineHide;

@end

@implementation VideoTypeCell

+(id)cell:(UITableView *)tableView
{
    NSString *className = NSStringFromClass([self class]);
    VideoTypeCell *cell = (VideoTypeCell *)[tableView dequeueReusableCellWithIdentifier:className];
    if (cell == nil)
    {
        cell = [[VideoTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
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
        
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = kBlackColor;
        _maskView.alpha = 0.4;
        _maskView.userInteractionEnabled = NO;
        [self.wrapView addSubview:_maskView];
        
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        [self.wrapView addSubview:_centerView];
        
        _titleView = [[UILabel alloc] init];
        _titleView.font = kFont(16* autoLayoutY);
        _titleView.textColor = kWhiteColor;
        _titleView.userInteractionEnabled = NO;
        _titleView.textAlignment = NSTextAlignmentCenter;
        [_centerView addSubview:_titleView];
        
        _subTitleView = [[UILabel alloc] init];
        _subTitleView.font = kFont(12* autoLayoutY);
        _subTitleView.textColor = kWhiteColor;
        _subTitleView.userInteractionEnabled = NO;
        _subTitleView.textAlignment = NSTextAlignmentCenter;
        [_centerView addSubview:_subTitleView];
        
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
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself.wrapView.mas_centerY);
        make.left.mas_equalTo(kLeadingMargin);
        make.right.mas_equalTo(-kLeadingMargin);
        make.height.mas_equalTo(50* autoLayoutY);
        
    }];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    [_subTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
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
@end
