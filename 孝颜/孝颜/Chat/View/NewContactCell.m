//
//  NewContactCell.m
//  孝颜
//
//  Created by benjamin on 2017/8/15.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "NewContactCell.h"

@interface NewContactCell ()
{
    
}

@property (nonatomic, strong) UILabel *infoView;

@end

@implementation NewContactCell

+(id)cell:(UITableView *)tableView
{
    NSString *className = NSStringFromClass([self class]);
    NewContactCell *cell = (NewContactCell *)[tableView dequeueReusableCellWithIdentifier:className];
    if (cell == nil)
    {
        cell = [[NewContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _infoView = [[UILabel alloc] init];
        _infoView.font = kFont(12* autoLayoutY);
        _infoView.textColor = kGrayColor;
        
        [self.wrapView addSubview:_infoView];
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
    self.separatorLeftInset = 104;
    
    [super layoutSubviews];
    
    WS(weakSelf);
    
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.wrapView.mas_centerY);
        make.right.mas_equalTo(-kLeadingMargin);
    }];
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    self.separatorLayer.hidden = NO;
}
- (void)setInfo:(NSString *)info {
    
    _infoView.text = info;
}
- (void)showInfoWithBool:(BOOL)infoBool {
    
    if (infoBool) {
        _infoView.textColor = kGrayColor;
        _infoView.text = Localized(@"已添加");
    }else {
        _infoView.textColor = kRedColor;
        _infoView.text = Localized(@"添加");
    }
}
@end
