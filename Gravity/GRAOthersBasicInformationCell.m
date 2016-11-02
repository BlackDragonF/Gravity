//
//  GRAOthersBasicInformationCell.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/12.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAOthersBasicInformationCell.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRAOthersBasicInformationCell()
@property (nonatomic, strong) UILabel * ageAndConstellationLabel;
@property (nonatomic, strong) UILabel * majorLabel;
@property (nonatomic, strong) UILabel * preferLabel;
@property (nonatomic, strong) UILabel * hometownLabel;
@property (nonatomic, strong) UILabel * stateLabel;
@end
@implementation GRAOthersBasicInformationCell
#pragma mark 初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self addConstraints];
        [self drawDots];
    }
    return self;
}
#pragma mark UI配置
- (void)drawDotInLabel:(UILabel *)label{
    CAShapeLayer * circleLayer = [CAShapeLayer layer];
    CGMutablePathRef circlePath = CGPathCreateMutable();
    circleLayer.lineWidth = 0.0f;
    circleLayer.strokeColor = [UIColor clearColor].CGColor;
    circleLayer.fillColor = [UIColor backgroundRedColor].CGColor;
    CGPathAddEllipseInRect(circlePath, nil, CGRectMake(-10, 3.25, 6, 6));
    [circleLayer setPath:circlePath];
    CGPathRelease(circlePath);
    [label.layer addSublayer:circleLayer];
}

- (void)addConstraints {
    [self.ageAndConstellationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@70);
        make.left.equalTo(self.contentView.mas_left).with.offset(64);
        make.top.equalTo(self.contentView.mas_top).with.offset(7.5);
        make.bottom.equalTo(self.hometownLabel.mas_top).with.offset(-12);
    }];
    [self.majorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.ageAndConstellationLabel.mas_height);
        make.width.equalTo(self.ageAndConstellationLabel.mas_width);
        make.left.equalTo(self.ageAndConstellationLabel.mas_right).with.offset(10);
        make.top.equalTo(self.ageAndConstellationLabel.mas_top);
    }];
    [self.preferLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.ageAndConstellationLabel.mas_height);
        make.width.equalTo(self.ageAndConstellationLabel.mas_width);
        make.left.equalTo(self.majorLabel.mas_right).with.offset(10);
        make.top.equalTo(self.ageAndConstellationLabel.mas_top);
    }];
    [self.hometownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.ageAndConstellationLabel.mas_height);
        make.width.equalTo(self.ageAndConstellationLabel.mas_width);
        make.left.equalTo(self.ageAndConstellationLabel.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.ageAndConstellationLabel.mas_height);
        make.width.equalTo(self.ageAndConstellationLabel.mas_width);
        make.left.equalTo(self.hometownLabel.mas_right).with.offset(10);
        make.bottom.equalTo(self.hometownLabel.mas_bottom);
    }];
}

- (void)drawDots {
    [self drawDotInLabel:self.ageAndConstellationLabel];
    [self drawDotInLabel:self.majorLabel];
    [self drawDotInLabel:self.preferLabel];
    [self drawDotInLabel:self.hometownLabel];
    [self drawDotInLabel:self.stateLabel];
}
#pragma mark set方法群
- (void)setAge:(NSString *)age{
    _age = age;
    [self.ageAndConstellationLabel setText:[NSString stringWithFormat:@"%@-%@", _age, _constellation]];
}

- (void)setConstellation:(NSString *)constellation{
    _constellation = constellation;
    [self.ageAndConstellationLabel setText:[NSString stringWithFormat:@"%@-%@", _age, _constellation]];
}

- (void)setMajor:(NSString *)major{
    _major = major;
    [self.majorLabel setText:_major];
}

- (void)setPrefer:(NSString *)prefer{
    _prefer = prefer;
    [self.preferLabel setText:_prefer];
}

- (void)setHometown:(NSString *)hometown{
    _hometown = hometown;
    [self.hometownLabel setText:_hometown];
}

- (void)setState:(NSString *)state{
    _state = state;
    [self.stateLabel setText:_state];
}
#pragma mark 懒加载方法群
- (UILabel *)ageAndConstellationLabel {
    if (!_ageAndConstellationLabel) {
        _ageAndConstellationLabel = [[UILabel alloc]init];
        [_ageAndConstellationLabel setTextColor:[UIColor textWhiteColor2]];
        [_ageAndConstellationLabel setTextAlignment:NSTextAlignmentLeft];
        [_ageAndConstellationLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self.contentView addSubview:_ageAndConstellationLabel];
    }
    return _ageAndConstellationLabel;
}

- (UILabel *)majorLabel {
    if (!_majorLabel) {
        _majorLabel = [[UILabel alloc]init];
        [_majorLabel setTextColor:[UIColor textWhiteColor2]];
        [_majorLabel setTextAlignment:NSTextAlignmentLeft];
        [_majorLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self.contentView addSubview:_majorLabel];
    }
    return _majorLabel;
}

- (UILabel *)preferLabel {
    if (!_preferLabel) {
        _preferLabel = [[UILabel alloc]init];
        [_preferLabel setTextColor:[UIColor textWhiteColor2]];
        [_preferLabel setTextAlignment:NSTextAlignmentLeft];
        [_preferLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self.contentView addSubview:_preferLabel];
    }
    return _preferLabel;
}

- (UILabel *)hometownLabel {
    if (!_hometownLabel) {
        _hometownLabel = [[UILabel alloc]init];
        [_hometownLabel setTextColor:[UIColor textWhiteColor2]];
        [_hometownLabel setTextAlignment:NSTextAlignmentLeft];
        [_hometownLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self.contentView addSubview:_hometownLabel];
    }
    return _hometownLabel;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]init];
        [_stateLabel setTextColor:[UIColor textWhiteColor2]];
        [_stateLabel setTextAlignment:NSTextAlignmentLeft];
        [_stateLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self.contentView addSubview:_stateLabel];
    }
    return _stateLabel;
}
@end
