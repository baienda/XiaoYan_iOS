//
//  MineProfileCell.m
//  孝颜
//
//  Created by benjamin on 2017/8/11.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "MineProfileCell.h"

@implementation MineProfileCell

+ (id)cell:(UITableView *)tableView
{
    NSString *className = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:className];
    
    return [tableView dequeueReusableCellWithIdentifier:className];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    self.titleView.font = kFont(16 * autoLayoutY);
    self.titleView.textColor = kTitleColor;
    
    self.subTitleView.font = kFont(14* autoLayoutY);
    self.subTitleView.textColor = kSecondTitleColor;
    
    self.arrowView.image = [UIImage imageNamed:@"2"];
    self.qrView.image = [UIImage imageNamed:@"2"];
    
    self.subTitleTrailing.constant = 40;
    
    self.upLine.backgroundColor = kLineColor;
    self.downLine.backgroundColor = kLineColor;
    
    self.upLine.hidden = YES;
    self.downLine.hidden = YES;
}
@end
