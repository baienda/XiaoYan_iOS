//
//  SettingTextCell.h
//  孝颜
//
//  Created by benjamin on 2017/8/14.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "XYTableViewCell.h"

@interface SettingTextCell : XYTableViewCell

@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UILabel *subTitleView;
@property (nonatomic, strong) UIView *uplineView;
@property (nonatomic, strong) UIView *downlineView;

+(id)cell:(UITableView *)tableView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setTitle:(NSString*)title;
- (void)setSubTitle:(NSString*)subTitle;

@end
