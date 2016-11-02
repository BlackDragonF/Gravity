//
//  GRACardPageSectionHeaderView.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/11.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRACardPageSectionHeaderView.h"

#import "GRALuckyView.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRACardPageSectionHeaderView() {
    NSMutableAttributedString * _baseAttributedString;
}
@property (nonatomic, strong) GRALuckyView * luckyView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * subtitleLabel;
@end

@implementation GRACardPageSectionHeaderView
- (instancetype)init {
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor backGroundGrayColor]];
        [self addConstraints];
    }
    return self;
}
- (instancetype)initWithLucky:(NSInteger)lucky MeetingTimes:(NSInteger)meeting andNearestMeters:(NSInteger)meters {
    if (self = [super init]) {
        _lucky = lucky;
        _meeting = meeting;
        _meters = meters;
        [self setBackgroundColor:[UIColor backGroundGrayColor]];
        [self addConstraints];
    }
    return self;
}
#pragma mark UI配置
- (void)addConstraints {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.luckyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.left.equalTo(self.contentView.mas_left).with.offset(35);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@60);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(21);
        make.left.equalTo(self.luckyView.mas_right).with.offset(30);
        make.height.mas_equalTo(@14);
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.titleLabel.mas_left);
        make.height.mas_equalTo(@12);
    }];
}
#pragma mark set方法群
- (void)setLucky:(NSInteger)lucky {
    _lucky = lucky;
    self.luckyView.lucky = _lucky;
}

- (void)setMeeting:(NSInteger)meeting {
    _meeting = meeting;
    _baseAttributedString = [[NSMutableAttributedString alloc]initWithString:@"相遇次"];
    [_baseAttributedString insertAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld", _meeting] attributes:@{NSForegroundColorAttributeName:[UIColor backgroundRedColor]}] atIndex:2];
    [self.titleLabel setAttributedText:[_baseAttributedString copy]];
}

- (void)setMeters:(NSInteger)meters {
    _meters = meters;
    _baseAttributedString = [[NSMutableAttributedString alloc]initWithString:@"曾经你和TA只相距米"];
    [_baseAttributedString insertAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld", _meters] attributes:@{NSForegroundColorAttributeName:[UIColor backgroundRedColor]}] atIndex:9];
    [self.subtitleLabel setAttributedText:[_baseAttributedString copy]];
}
#pragma mark 懒加载方法群
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (GRALuckyView *)luckyView {
    if (!_luckyView) {
        _luckyView = [[GRALuckyView alloc]init];
        [self.contentView addSubview:_luckyView];
    }
    return _luckyView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc]init];
        _subtitleLabel.textAlignment = NSTextAlignmentLeft;
        _subtitleLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_subtitleLabel];
    }
    return _subtitleLabel;
}
@end
