//
//  XYLabel.m
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "XYLabel.h"

@implementation XYLabel

- (instancetype)init {
    if (self = [super init]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}
- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}
- (id)initWithContent:(NSString *)content
{
    self = [super init];
    if (self)
    {
        [self commonInit:content];
    }
    return self;
}
- (void)commonInit:(NSString *)content
{
    self.textColor = kTitleColor;
    self.font = kFont(16 * autoLayoutY);
    self.numberOfLines = 0;
    self.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;//设置对齐方式
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    [paragraphStyle setLineSpacing:5.0];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    [self setAttributedText:attributedString];
    //设置行间距后适配高度显示
    [self sizeToFit];
}
- (void)attrWithContent:(NSString *)content textColor:(UIColor*)textColor font:(UIFont*)font lineSpacing:(CGFloat)lineSpacing numberOfLines:(NSInteger)numberOfLines textAlignment:(NSTextAlignment)textAlignment{
    
    self.textColor = textColor;
    self.font = font;
    self.numberOfLines = numberOfLines;
    self.textAlignment = textAlignment;
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = textAlignment;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [paragraphStyle setLineSpacing:lineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    [self setAttributedText:attributedString];
    [self sizeToFit];
}

@end
