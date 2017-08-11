//
//  MineBaseCell.h
//  孝颜
//
//  Created by benjamin on 2017/8/11.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "XYTableViewCell.h"

@interface MineBaseCell : XYTableViewCell

@property (nonatomic, strong)UIImageView* icon;
@property (nonatomic, strong)UILabel* title;
@property (nonatomic, strong)UIImageView* arrow;
@property (nonatomic, strong)UIView* underline;

+(id)cell:(UITableView *)tableView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
