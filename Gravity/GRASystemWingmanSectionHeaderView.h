//
//  GRASystemWingmanSectionHeaderView.h
//  Gravity
//
//  Created by 陈志浩 on 16/7/9.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRASystemWingmanSectionHeaderView : UIView
@property (nonatomic, strong) NSString * date;
@property (nonatomic, strong) NSString * time;

@property (nonatomic, strong) UIView * contentView;
- (instancetype)initWithDate:(NSString *)date
                     andTime:(NSString *)time;
@end
