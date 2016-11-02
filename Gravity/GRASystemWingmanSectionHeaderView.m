//
//  GRASystemWingmanSectionHeaderView.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/9.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRASystemWingmanSectionHeaderView.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRASystemWingmanSectionHeaderView()
@property (nonatomic, strong) UILabel * dateLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@end
@implementation GRASystemWingmanSectionHeaderView
- (instancetype)initWithDate:(NSString *)date andTime:(NSString *)time {
    if (self = [super init]) {
        self.time = time;
        self.date = date;
        [self setBackgroundColor:[UIColor clearColor]];
        [self addConstraints];
    }
    return self;
}
#pragma mark UI配置
- (void)addConstraints {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(30);
        make.bottom.equalTo(self.mas_bottom).with.offset(-15);
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(@12);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(@12);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateLabel.mas_right).with.offset(5);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(@12);
    }];
}
#pragma mark set方法群
- (void)setDate:(NSString *)date {
    _date = date;
    self.dateLabel.text = date;
}

- (void)setTime:(NSString *)time {
    _time = time;
    self.timeLabel.text = _time;
}
#pragma mark 懒加载方法群
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        [self addSubview:_contentView];
    }
    return _contentView;
}
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.textColor = [UIColor textWhiteColor];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_dateLabel];
    }
    return _dateLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor textWhiteColor];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}
@end
