//
//  VideoHotTypeCell.m
//  孝颜
//
//  Created by benjamin on 2017/8/11.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "VideoHotTypeCell.h"

@implementation VideoHotTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.title.font = kFontBold(16* autoLayoutY);
    self.maskView.userInteractionEnabled = NO;
    self.maskView.backgroundColor = kGlobalColor;
    self.maskView.alpha = 0.4;
    
}
@end
