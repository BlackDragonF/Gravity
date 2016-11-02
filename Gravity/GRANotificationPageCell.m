//
//  GRANotificationPageCell.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/9.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRANotificationPageCell.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRANotificationPageCell()
@property (nonatomic, strong) UIImageView * iconView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * subtitleLabel;
@property (nonatomic, strong) CAShapeLayer * separatorLayer;
@end

@implementation GRANotificationPageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self addConstraints];
    }
    return self;
}
#pragma mark UI配置
- (void)addConstraints {
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(15);
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-15);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@60);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(30);
        make.left.equalTo(self.iconView.mas_right).with.offset(15);
        make.height.mas_equalTo(@16);
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.titleLabel.mas_left);
        make.height.mas_equalTo(@12);
    }];
}
#pragma mark set方法群
- (void)setIcon:(UIImage *)icon {
    _icon = icon;
    _iconView.image = _icon;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = _title;
}

- (void)setSubtitle:(NSString *)subtitle {
    _subtitle = subtitle;
    _subtitleLabel.text = _subtitle;
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
        _iconView.layer.cornerRadius = 30.0;
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
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc]init];
        _subtitleLabel.textColor = [UIColor textGreenColor];
        _subtitleLabel.textAlignment = NSTextAlignmentLeft;
        _subtitleLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_subtitleLabel];
    }
    return _subtitleLabel;
}

- (CAShapeLayer *)separatorLayer{
    if (!_separatorLayer){
        _separatorLayer = [CAShapeLayer layer];
        CGMutablePathRef separatorShapePath = CGPathCreateMutable();
        [_separatorLayer setFillColor:[UIColor clearColor].CGColor];
        [_separatorLayer setStrokeColor:[UIColor separatorPurpleColor].CGColor];
        _separatorLayer.lineWidth = 0.5f;
        CGPathMoveToPoint(separatorShapePath, NULL, 75.0, 91.0);
        CGPathAddLineToPoint(separatorShapePath, NULL, 375.0, 91.0);
        [_separatorLayer setPath:separatorShapePath];
        CGPathRelease(separatorShapePath);
        [self.contentView.layer addSublayer:_separatorLayer];
    }
    return _separatorLayer;
}
@end
