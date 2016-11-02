//
//  GRACardPageSectionHeaderView.h
//  Gravity
//
//  Created by 陈志浩 on 16/7/11.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRACardPageSectionHeaderView : UIView
@property (nonatomic, strong) UIView * contentView;

@property (nonatomic) NSInteger lucky;
@property (nonatomic) NSInteger meeting;
@property (nonatomic) NSInteger meters;

- (instancetype)initWithLucky:(NSInteger)lucky
                 MeetingTimes:(NSInteger)meeting
             andNearestMeters:(NSInteger)meters;
@end
