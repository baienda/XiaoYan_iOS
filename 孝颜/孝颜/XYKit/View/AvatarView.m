//
//  AvatarView.m
//  孝颜
//
//  Created by benjamin on 2017/8/15.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "AvatarView.h"

@implementation AvatarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        self.userInteractionEnabled = YES;
        
        _imageView = [[UIImageView alloc] init];
        _imageView.clipsToBounds = TRUE;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview:_imageView];
        
        _onLineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"online"]];
        _onLineView.hidden = YES;
        [self addSubview:_onLineView];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.userInteractionEnabled = YES;
        
        _imageView = [[UIImageView alloc] init];
        _imageView.clipsToBounds = TRUE;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview:_imageView];
        
        _onLineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"online"]];
        _onLineView.hidden = YES;
        [self addSubview:_onLineView];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize rawSize = self.frame.size;
    
    _imageView.frame = CGRectMake(0.0f, 0.0f, rawSize.width, rawSize.height);
//    _imageView.layer.cornerRadius = rawSize.width / 2;
    _imageView.layer.cornerRadius = 2;
    
    [_onLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-4);
        make.bottom.mas_equalTo(-4);
        make.height.mas_equalTo(14 * autoLayoutY);
        make.width.mas_equalTo(14 * autoLayoutX);
    }];
}

- (void)loadURL:(NSString *)url
{
    [_imageView setAvatarWithURL:url completion:nil];
}
- (void)loadURL:(NSString *)url completion:(CCWebImageBlock)completion
{
    [_imageView setAvatarWithURL:url completion:completion];
}
- (void)setDefaultGroup
{
    _imageView.image = [UIImage imageNamed:@"chat_icon_group"];
}

- (void)setDefault:(BOOL)female
{
    if(female == YES){
        _imageView.image = [UIImage imageNamed:@"icon_moren"];
    } else {
        _imageView.image = [UIImage imageNamed:@"icon_moren"];
    }
}
- (void)setLocalAvatar:(UIImage*)image {
    
    _imageView.image = image;
}

@end
