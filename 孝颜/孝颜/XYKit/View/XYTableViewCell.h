//
//  XYTableViewCell.h
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *wrapView;

@property CALayer *separatorLayer;

@property CGFloat separatorLeftInset;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
