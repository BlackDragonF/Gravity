//
//  GRACardPageCell.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/11.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRACardPageCell.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRACardPageCell()
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * subtitleLabel;
@property (nonatomic, strong) UIImageView * iconView;
@property (nonatomic, strong) CAShapeLayer * upperLayer;
@property (nonatomic, strong) CAShapeLayer * lowerLayer;
@end

@implementation GRACardPageCell
#pragma mark 初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor textWhiteColor2]];
        [self addConstraints];
    }
    return self;
}
#pragma mark UI配置
- (void)addConstraints {
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(15);
        make.left.equalTo(self.contentView.mas_left).with.offset(97.5);
        make.width.mas_equalTo(@12);
        make.height.mas_equalTo(@16);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.iconView.mas_left).with.offset(-15);
        make.top.equalTo(self.contentView.mas_top).with.offset(18);
        make.height.mas_equalTo(@11);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(18);
        make.left.equalTo(self.iconView.mas_right).with.offset(15);
        make.height.mas_equalTo(@13);
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@11);
    }];
}
#pragma mark set方法群
- (void)setTime:(NSString *)time {
    _time = time;
    self.timeLabel.text = _time;
}

- (void)setTitle:(NSAttributedString *)title {
    _title = title;
    self.titleLabel.attributedText = _title;
}

- (void)setSubtitle:(NSAttributedString *)subtitle {
    _subtitle = subtitle;
    self.subtitleLabel.attributedText = _subtitle;
}

- (void)setPosition:(GRACardPageCellPosition)position {
    _position = position;
    switch (_position) {
        case GRACardPageCellDefault:
            [self.iconView.layer addSublayer:self.upperLayer];
            [self.iconView.layer addSublayer:self.lowerLayer];
            break;
        case GRACardPageCellFirst:
            [self.upperLayer removeFromSuperlayer];
            [self.iconView.layer addSublayer:self.lowerLayer];
            break;
        case GRACardPageCellLast:
            [self.iconView.layer addSublayer:self.upperLayer];
            [self.lowerLayer removeFromSuperlayer];
            break;
    }
}
#pragma mark 懒加载方法群
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor textBlackColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = [UIFont systemFontOfSize:11.0];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor textBlackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc]init];
        _subtitleLabel.textColor = [UIColor textGrayColor];
        _subtitleLabel.textAlignment = NSTextAlignmentLeft;
        _subtitleLabel.font = [UIFont systemFontOfSize:11.0];
        [self.contentView addSubview:_subtitleLabel];
    }
    return _subtitleLabel;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cardicon"]];
        [self.contentView addSubview:_iconView];
    }
    return _iconView;
}

- (CAShapeLayer *)upperLayer {
    if (!_upperLayer) {
        _upperLayer = [CAShapeLayer layer];
        CGMutablePathRef upperPath = CGPathCreateMutable();
        _upperLayer.fillColor = [UIColor clearColor].CGColor;
        _upperLayer.strokeColor = [UIColor backGroundGrayColor].CGColor;
        _upperLayer.lineWidth = 1.0;
        CGPathMoveToPoint(upperPath, NULL, 6.0, -15.0);
        CGPathAddLineToPoint(upperPath, NULL, 6.0, 0.0);
        [_upperLayer setPath:upperPath];
        CGPathRelease(upperPath);
    }
    return _upperLayer;
}

- (CAShapeLayer *)lowerLayer {
    if (!_lowerLayer) {
        _lowerLayer = [CAShapeLayer layer];
        CGMutablePathRef lowerPath = CGPathCreateMutable();
        _lowerLayer.fillColor = [UIColor clearColor].CGColor;
        _lowerLayer.strokeColor = [UIColor backGroundGrayColor].CGColor;
        _lowerLayer.lineWidth = 1.0;
        CGPathMoveToPoint(lowerPath, NULL, 6.0, 16.0);
        CGPathAddLineToPoint(lowerPath, NULL, 6.0, 66.0);
        [_lowerLayer setPath:lowerPath];
        CGPathRelease(lowerPath);
    }
    return _lowerLayer;
}
@end
