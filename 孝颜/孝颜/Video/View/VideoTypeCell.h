//
//  VideoTypeCell.h
//  孝颜
//
//  Created by benjamin on 2017/8/11.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "XYTableViewCell.h"

@interface VideoTypeCell : XYTableViewCell

@property (nonatomic, strong) XYViewController *XYiewController;

+(id)cell:(UITableView *)tableView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setImage:(NSString *)url;
- (void)setTitle:(NSString *)title;
- (void)setSubTitle:(NSString*)subTitle;

- (void)startAni;
- (void)stopAni;

- (void)showLine:(BOOL)show;

@end
