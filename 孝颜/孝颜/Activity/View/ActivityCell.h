//
//  ActivityCell.h
//  孝颜
//
//  Created by benjamin on 2017/8/10.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "XYTableViewCell.h"

@interface ActivityCell : XYTableViewCell

@property (nonatomic, strong) XYViewController *XYiewController;

+(id)cell:(UITableView *)tableView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setImage:(NSString *)url;
- (void)setTitle:(NSString *)title;
//副标题和时间
- (void)setSubTitleAndTime:(NSString*)subTitleAndTime;
//- (void)setTime:(NSString*)time;
- (void)setTag:(NSString*)tag;
- (void)setJoinTitle:(BOOL)join;

- (void)showLine:(BOOL)show;

@end
