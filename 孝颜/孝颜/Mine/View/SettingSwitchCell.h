//
//  SettingSwitchCell.h
//  孝颜
//
//  Created by benjamin on 2017/8/14.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "XYTableViewCell.h"

@interface SettingSwitchCell : XYTableViewCell

@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, strong) UIView *uplineView;
@property (nonatomic, strong) UIView *downlineView;

+(id)cell:(UITableView *)tableView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
