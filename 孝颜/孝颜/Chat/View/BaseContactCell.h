//
//  BaseContactCell.h
//  孝颜
//
//  Created by benjamin on 2017/8/15.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "XYTableViewCell.h"

@interface BaseContactCell : XYTableViewCell

+(id)cell:(UITableView *)tableView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setAvatar:(NSString *)url;
- (void)setLoaclAvatar:(NSString *)imageStr;
- (void)setName:(NSString *)name;

@end
