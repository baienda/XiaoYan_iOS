//
//  VideoHotTypeHeaderView.m
//  孝颜
//
//  Created by benjamin on 2017/8/11.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "VideoHotTypeHeaderView.h"

@implementation VideoHotTypeHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _wrapView = [[UIView alloc]init];
        _wrapView.frame =CGRectMake(0,0, self.frame.size.width,self.frame.size.height);
        _wrapView.backgroundColor = kWhiteColor;
        [self addSubview:_wrapView];
//        _scroller = [[JKScrollFocus alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 40)];
//        [_wrapView addSubview:_scroller];
        _titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 40)];
        _titleView.text = Localized(@"热门分类");
        _titleView.textColor = kBlackColor;
        _titleView.textAlignment = NSTextAlignmentCenter;
        _titleView.font = kFontBold(14* autoLayoutY);
        [_wrapView addSubview:_titleView];
    }
    return self;
}
@end
