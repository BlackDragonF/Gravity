//
//  GRAGeneralSettingsCell.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/9.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAGeneralSettingsCell.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRAGeneralSettingsCell()
@property (nonatomic, strong) UIImageView * iconView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIImageView * arrowView;
@property (nonatomic, strong) CAShapeLayer * separatorLayer;
@end

@implementation GRAGeneralSettingsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor transparentWhiteColor]];
        [self addConstraints];
    }
    return self;
}
#pragma mark UI配置
- (void)addConstraints {
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-5);
        make.height.mas_equalTo(@29);
        make.width.mas_equalTo(@29);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(15);
        make.left.equalTo(self.iconView.mas_right).with.offset(15);
        make.height.mas_equalTo(@13);
    }];
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-12);
        make.top.equalTo(self.contentView.mas_top).with.offset(15);
        make.height.mas_equalTo(@17);
        make.width.mas_equalTo(@10);
    }];
}
#pragma mark set方法群
- (void)setIcon:(UIImage *)icon {
    _icon = icon;
    _iconView.image = _icon;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = _title;
}

- (void)setSeparator:(BOOL)separator{
    _separator = separator;
    if (_separator){
        [self.contentView.layer addSublayer:self.separatorLayer];
    } else {
        [self.separatorLayer removeFromSuperlayer];
    }
}
#pragma mark 懒加载方法群
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        _iconView.layer.cornerRadius = 14.5;
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.borderColor = [UIColor textGreenColor].CGColor;
        _iconView.layer.borderWidth = 0.5;
        [self.contentView addSubview:_iconView];
    }
    return _iconView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor textWhiteColor2];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)arrowView {
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
        [self.contentView addSubview:_arrowView];
    }
    return _arrowView;
}

- (CAShapeLayer *)separatorLayer{
    if (!_separatorLayer){
        _separatorLayer = [CAShapeLayer layer];
        CGMutablePathRef separatorShapePath = CGPathCreateMutable();
        [_separatorLayer setFillColor:[UIColor clearColor].CGColor];
        [_separatorLayer setStrokeColor:[UIColor separatorPurpleColor].CGColor];
        _separatorLayer.lineWidth = 0.5f;
        CGPathMoveToPoint(separatorShapePath, NULL, 50.0f, 45.0f);
        CGPathAddLineToPoint(separatorShapePath, NULL, 375.0f, 45.0f);
        [_separatorLayer setPath:separatorShapePath];
        CGPathRelease(separatorShapePath);
        [self.contentView.layer addSublayer:_separatorLayer];
    }
    return _separatorLayer;
}
@end
