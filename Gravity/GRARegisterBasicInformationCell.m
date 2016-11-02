//
//  GRARegisterBasicInformationCell.m
//  Gravity
//
//  Created by 陈志浩 on 16/6/9.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRARegisterBasicInformationCell.h"
#import "ColorMacro.h"
#import "Masonry.h"

@interface GRARegisterBasicInformationCell()
@property (nonatomic, strong) CAShapeLayer * separatorLine;
@property (nonatomic, strong) UIView * separatorView;
@end

@implementation GRARegisterBasicInformationCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _hasSeparator = NO;
        [self createSeparator];
        [self makeComponents];
    }
    return self;
}
#pragma mark 添加约束
- (void)makeComponents {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(17);
        make.left.equalTo(self.contentView.mas_left).with.offset(22);
        make.height.mas_equalTo(@13);
    }];
    [self.separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(@0.5);
        make.top.equalTo(self.contentView.mas_top);
    }];
}
#pragma mark set方法
- (void)setHasSeparator:(BOOL)hasSeparator {
    _hasSeparator = hasSeparator;
    if (hasSeparator) {
        [self.separatorView.layer addSublayer:_separatorLine];
    } else {
        [_separatorLine removeFromSuperlayer];
    }
}
#pragma mark 懒加载方法群
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

- (UIView *)separatorView {
    if (!_separatorView) {
        _separatorView = [[UIView alloc]init];
        [self.contentView addSubview:_separatorView];
    }
    return _separatorView;
}
#pragma mark 画线
- (void)createSeparator {
    _separatorLine = [CAShapeLayer layer];
    CGMutablePathRef separatorLinePath = CGPathCreateMutable();
    [_separatorLine setFillColor:[UIColor clearColor].CGColor];
    [_separatorLine setStrokeColor:[UIColor separatorPurpleColor].CGColor];
    _separatorLine.lineWidth = 0.5;
    CGPathMoveToPoint(separatorLinePath, NULL, 0.0, 0.0);
    CGPathAddLineToPoint(separatorLinePath, NULL, 375.0, 0.0);
    [_separatorLine setPath:separatorLinePath];
    CGPathRelease(separatorLinePath);
}
@end
