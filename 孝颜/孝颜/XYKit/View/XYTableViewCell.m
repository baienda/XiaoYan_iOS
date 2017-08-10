//
//  XYTableViewCell.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "XYTableViewCell.h"
#import "Common.h"

@implementation XYTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.superview.clipsToBounds = false;
        
        //分割线
        _separatorLayer = [[CALayer alloc] init];
        _separatorLayer.backgroundColor = UIColorRGB(0xE5E5E5).CGColor;
        [self.contentView.layer addSublayer:_separatorLayer];
        
        //容器
        _wrapView = [[UIView alloc] init];
        _wrapView.clipsToBounds = true;
        [self addSubview:_wrapView];
        
        //按下背景
        UIView *selectedView = [[UIView alloc] init];
        selectedView.backgroundColor = kSelectorColor;
        self.selectedBackgroundView = selectedView;
        
        
    }
    return self;
}

- (void)dealloc
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize rawSize = self.frame.size;
    CGFloat separatorHeight = 1 / [UIScreen mainScreen].scale;
    
    UIView *selectedView = self.selectedBackgroundView;
    if (selectedView != nil)
        selectedView.frame = CGRectMake(0, -separatorHeight, selectedView.frame.size.width, rawSize.height + separatorHeight);
    
    self.backgroundView.frame = CGRectMake(0.0f, 0.0f, rawSize.width, rawSize.height);
    
    static CGSize screenSize;
    static CGFloat widescreenWidth;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      screenSize = ScreenSize();
                      widescreenWidth = MAX(screenSize.width, screenSize.height);
                  });
    
    CGFloat contentOffset = self.contentView.frame.origin.x;
    
    CGSize size = rawSize;
    if (rawSize.width >= widescreenWidth - FLT_EPSILON)
        size.width = screenSize.height - contentOffset;
    else
        size.width = screenSize.width - contentOffset;
    
    _separatorLayer.frame = CGRectMake(_separatorLeftInset, rawSize.height - separatorHeight, rawSize.width - _separatorLeftInset, separatorHeight);
    
    _wrapView.frame = CGRectMake(contentOffset, 0.0f, size.width, size.height);
    
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    bool wasSelected = self.selected;
    
    [super setSelected:selected animated:animated];
    
    if ((selected && !wasSelected))
    {
        [self adjustOrdering];
    }
    
    if ((selected && !wasSelected) || (!selected && wasSelected))
    {
        UIView *selectedView = self.selectedBackgroundView;
        if (selectedView != nil && (self.selected || self.highlighted))
        {
            CGFloat separatorHeight = 0.5f;
            selectedView.frame = CGRectMake(0, -separatorHeight, selectedView.frame.size.width, self.frame.size.height + separatorHeight);
        }
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    bool wasHighlighted = self.highlighted;
    
    [super setHighlighted:highlighted animated:animated];
    
    if ((highlighted && !wasHighlighted))
    {
        [self adjustOrdering];
    }
    
    if ((highlighted && !wasHighlighted) || (!highlighted && wasHighlighted))
    {
        UIView *selectedView = self.selectedBackgroundView;
        if (selectedView != nil && (self.selected || self.highlighted))
        {
            CGFloat separatorHeight = 0.5f;
            selectedView.frame = CGRectMake(0, -separatorHeight, selectedView.frame.size.width, self.frame.size.height + separatorHeight);
        }
    }
}

- (void)adjustOrdering
{
    UIView *selectedView = self.selectedBackgroundView;
    if (selectedView != nil)
    {
        CGFloat separatorHeight = 0.5f;
        selectedView.frame = CGRectMake(0, -separatorHeight, selectedView.frame.size.width, self.frame.size.height + separatorHeight);
    }
    
    if ([self.superview isKindOfClass:[UITableView class]])
    {
        Class UITableViewCellClass = [UITableViewCell class];
        Class UISearchBarClass = [UISearchBar class];
        int maxCellIndex = 0;
        int index = -1;
        int selfIndex = 0;
        for (UIView *view in self.superview.subviews)
        {
            index++;
            if ([view isKindOfClass:UITableViewCellClass] || [view isKindOfClass:UISearchBarClass])
            {
                maxCellIndex = index;
                
                if (view == self)
                    selfIndex = index;
            }
        }
        
        if (selfIndex < maxCellIndex)
        {
            [self.superview insertSubview:self atIndex:maxCellIndex];
        }
    }
}

@end
