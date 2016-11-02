//
//  GRALuckyView.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/11.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRALuckyView.h"

#import "Masonry.h"
#import "ColorMacro.h"

#define kShapeLineWidth 2.0

@interface GRALuckyView() {
    UIBezierPath * _basePath;
}
@property (nonatomic, strong) UILabel * valueLabel;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIView * progressView;
@property (nonatomic, strong) CAShapeLayer * mainShape;
@property (nonatomic, strong) CAShapeLayer * sideShape;
@end

@implementation GRALuckyView
#pragma mark 初始化方法群
- (instancetype)init {
    if (self = [super init]) {
        [self addConstraints];
    }
    return self;
}
- (instancetype)initWithLucky:(NSInteger)lucky {
    if (self = [super init]) {
        _lucky = lucky;
        self.valueLabel.text = [NSString stringWithFormat:@"%ld%%", (long)_lucky];
        [self addConstraints];
        [self updateLuckyShape];
    }
    return self;
}
#pragma mark UI配置
- (void)addConstraints {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(18);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(@14);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.valueLabel.mas_bottom).with.offset(5);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(@10);
    }];
}

- (void)updateLuckyShape {
    _basePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 60, 60)];
    [self.mainShape setPath:_basePath.CGPath];
    [self.sideShape setPath:_basePath.CGPath];
    self.mainShape.strokeStart = 0;
    self.mainShape.strokeEnd = (CGFloat)_lucky/100.0;
    self.sideShape.strokeStart = (CGFloat)_lucky/100.0;
    self.sideShape.strokeEnd = 1;
    
}
#pragma mark set方法群
- (void)setLucky:(NSInteger)lucky {
    _lucky = lucky;
    self.valueLabel.text = [NSString stringWithFormat:@"%ld%%", (long)_lucky];
    [self updateLuckyShape];
}
#pragma mark 懒加载方法群
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UIView *)progressView {
    if (!_progressView) {
        _progressView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        _progressView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        _progressView.layer.transform = CATransform3DMakeRotation(-M_PI/2, 0, 0, 1);
        [self.contentView addSubview:_progressView];
    }
    return _progressView;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc]init];
        _valueLabel.textColor = [UIColor backgroundRedColor];
        _valueLabel.textAlignment = NSTextAlignmentCenter;
        _valueLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_valueLabel];
    }
    return _valueLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"缘分值";
        _titleLabel.textColor = [UIColor textGrayColor2];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (CAShapeLayer *)mainShape {
    if (!_mainShape) {
        _mainShape = [CAShapeLayer layer];
        _mainShape.fillColor = [UIColor clearColor].CGColor;
        _mainShape.strokeColor = [UIColor backgroundRedColor].CGColor;
        _mainShape.lineWidth = kShapeLineWidth;
        [self.progressView.layer addSublayer:_mainShape];
    }
    return _mainShape;
}

- (CAShapeLayer *)sideShape {
    if (!_sideShape) {
        _sideShape = [CAShapeLayer layer];
        _sideShape.fillColor = [UIColor clearColor].CGColor;
        _sideShape.strokeColor = [UIColor textGrayColor2].CGColor;
        _sideShape.lineWidth = kShapeLineWidth;
        [self.progressView.layer addSublayer:_sideShape];
    }
    return _sideShape;
}
@end
