//
//  NewContactCell.h
//  孝颜
//
//  Created by benjamin on 2017/8/15.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "BaseContactCell.h"

@interface NewContactCell : BaseContactCell

+(id)cell:(UITableView *)tableView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setInfo:(NSString *)info;

- (void)showInfoWithBool:(BOOL)infoBool;

@end
