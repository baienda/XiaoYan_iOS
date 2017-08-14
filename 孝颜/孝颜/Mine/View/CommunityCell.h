//
//  CommunityCell.h
//  孝颜
//
//  Created by benjamin on 2017/8/14.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "XYTableViewCell.h"

@interface CommunityCell : XYTableViewCell

+(id)cell:(UITableView *)tableView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setImage:(NSString *)url;
- (void)setTitle:(NSString *)title;
- (void)setSubTitle:(NSString*)subTitle;
- (void)setTime:(NSString*)time;
- (void)setJoinTitle:(BOOL)join;

- (void)showLine:(BOOL)show;

@end
