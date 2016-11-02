//
//  GRAOthersInformationSectionHeaderView.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/13.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAOthersInformationSectionHeaderView.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRAOthersInformationSectionHeaderView()
@property (nonatomic, strong) UIImageView * iconView;
@property (nonatomic, strong) UILabel * titleLabel;
@end

@implementation GRAOthersInformationSectionHeaderView
#pragma mark 初始化方法
- (instancetype)initWithIcon:(UIImage *)icon andTitle:(NSString *)title {
    if (self = [super init]) {
        self.icon = icon;
        self.title = title;
        [self addConstraints];
        [self drawSeparator];
    }
    return self;
}
#pragma mark UI配置
- (void)addConstraints {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.titleLabel.mas_left).with.offset(-15);
        make.height.mas_equalTo(@29);
        make.width.mas_equalTo(@29);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(7.5);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-15);
    }];
}

- (void)drawSeparator{
    CAShapeLayer * separatorLayer = [CAShapeLayer layer];
    CGMutablePathRef separatorShapePath = CGPathCreateMutable();
    [separatorLayer setFillColor:[UIColor clearColor].CGColor];
    [separatorLayer setStrokeColor:[UIColor separatorGrayColor].CGColor];
    separatorLayer.lineWidth = 0.5f;
    CGPathMoveToPoint(separatorShapePath, NULL, 54.0f, 35.0f);
    CGPathAddLineToPoint(separatorShapePath, NULL, [UIScreen mainScreen].bounds.size.width, 35.0f);
    [separatorLayer setPath:separatorShapePath];
    CGPathRelease(separatorShapePath);
    [self.contentView.layer addSublayer:separatorLayer];
}
#pragma mark set方法群
- (void)setIcon:(UIImage *)icon{
    _icon = icon;
    [self.iconView setImage:_icon];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    [self.titleLabel setText:_title];
}
#pragma mark 懒加载方法群
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.cornerRadius = 14.5;
        _iconView.layer.borderWidth = 0.5;
        _iconView.layer.borderColor = [UIColor textWhiteColor2].CGColor;
        [self.contentView addSubview:_iconView];
    }
    return _iconView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor textGreenColor];
        _titleLabel.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
@end
