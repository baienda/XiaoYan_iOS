//
//  AvatarView.h
//  孝颜
//
//  Created by benjamin on 2017/8/15.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvatarView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *onLineView;

- (void)loadURL:(NSString *)url;

- (void)loadURL:(NSString *)url completion:(CCWebImageBlock)completion;

- (void)setDefaultGroup;

- (void)setDefault:(BOOL)female;

- (void)setLocalAvatar:(UIImage*)image;

@end
