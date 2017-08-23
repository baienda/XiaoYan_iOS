//
//  CourseModel.h
//  孝颜
//
//  Created by benjamin on 2017/8/16.
//  Copyright © 2017年 com.baienda. All rights reserved.
//

#import "XYBaseModel.h"

@interface CourseModel : XYBaseModel

@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *large_url;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *large_location;

@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *large_time;

@property (nonatomic, copy) NSString *money_type;

@property (nonatomic, copy) NSString *tele_num;

@property (nonatomic, copy) NSString *loc_latitude;

@property (nonatomic, copy) NSString *loc_longitude;

//缓存的image
@property (nonatomic, strong) UIImage *large_image;

@end
