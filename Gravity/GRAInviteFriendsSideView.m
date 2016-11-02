//
//  GRAInviteFriendsSideView.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/10.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAInviteFriendsSideView.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRAInviteFriendsSideView()
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) CAShapeLayer * leftHeadlineLayer;
@property (nonatomic, strong) CAShapeLayer * rightHeadlineLayer;
@property (nonatomic, strong) UILabel * ruleLabel1;
@property (nonatomic, strong) UILabel * ruleLabel2;
@end

@implementation GRAInviteFriendsSideView
- (instancetype)init {
    if (self = [super init]) {
        [self addConstraints];
        [self createHeadline];
    }
    return self;
}
#pragma mark UI配置
- (void)addConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).with.offset(-7.5);
        make.height.mas_equalTo(@13);
    }];
    [self.ruleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(15);
        make.left.equalTo(self.mas_left).with.offset(18);
        make.right.equalTo(self.mas_right).with.offset(-18);
    }];
    [self.ruleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ruleLabel1.mas_bottom).with.offset(15);
        make.left.equalTo(self.mas_left).with.offset(18);
        make.right.equalTo(self.mas_right).with.offset(-18);
    }];
}

- (void)createHeadline {
    [self leftHeadlineLayer];
    [self rightHeadlineLayer];
}
#pragma mark 懒加载方法群
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"规则说明";
        _titleLabel.textColor = [UIColor textGreenColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)ruleLabel1 {
    if (!_ruleLabel1) {
        _ruleLabel1 = [[UILabel alloc]init];
        NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc]init];
        style.lineSpacing = 2.5;
        _ruleLabel1.numberOfLines = 0;
        _ruleLabel1.attributedText = [[NSAttributedString alloc]initWithString:@"1.分享到朋友圈/QQ空间/微博，或者分享给好友即可获得5颗能量石奖励"attributes:@{NSParagraphStyleAttributeName:style}];
        _ruleLabel1.textColor = [UIColor textWhiteColor2];
        _ruleLabel1.textAlignment = NSTextAlignmentLeft;
        _ruleLabel1.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:_ruleLabel1];
    }
    return _ruleLabel1;
}

- (UILabel *)ruleLabel2 {
    if (!_ruleLabel2) {
        _ruleLabel2 = [[UILabel alloc]init];
        NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc]init];
        style.lineSpacing = 2.5;
        _ruleLabel2.numberOfLines = 0;
        _ruleLabel2.attributedText = [[NSAttributedString alloc]initWithString:@"2.被邀请的用户下载Gravity App并完成注册后，邀请者可再获得5颗能量石奖励"attributes:@{NSParagraphStyleAttributeName:style}];
        _ruleLabel2.textColor = [UIColor textWhiteColor2];
        _ruleLabel2.textAlignment = NSTextAlignmentLeft;
        _ruleLabel2.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:_ruleLabel2];
    }
    return _ruleLabel2;
}

- (CAShapeLayer *)leftHeadlineLayer{
    if (!_leftHeadlineLayer){
        _leftHeadlineLayer = [CAShapeLayer layer];
        CGMutablePathRef leftHeadlineShapePath = CGPathCreateMutable();
        [_leftHeadlineLayer setFillColor:[UIColor clearColor].CGColor];
        [_leftHeadlineLayer setStrokeColor:[UIColor separatorPurpleColor].CGColor];
        _leftHeadlineLayer.lineWidth = 0.5f;
        CGPathMoveToPoint(leftHeadlineShapePath, NULL, 0.0, 0.0);
        CGPathAddLineToPoint(leftHeadlineShapePath, NULL, 147.5, 0.0);
        [_leftHeadlineLayer setPath:leftHeadlineShapePath];
        CGPathRelease(leftHeadlineShapePath);
        [self.layer addSublayer:_leftHeadlineLayer];
    }
    return _leftHeadlineLayer;
}

- (CAShapeLayer *)rightHeadlineLayer{
    if (!_rightHeadlineLayer){
        _rightHeadlineLayer = [CAShapeLayer layer];
        CGMutablePathRef rightHeadlineShapePath = CGPathCreateMutable();
        [_rightHeadlineLayer setFillColor:[UIColor clearColor].CGColor];
        [_rightHeadlineLayer setStrokeColor:[UIColor separatorPurpleColor].CGColor];
        _rightHeadlineLayer.lineWidth = 0.5f;
        CGPathMoveToPoint(rightHeadlineShapePath, NULL, 375.0-147.5, 0.0);
        CGPathAddLineToPoint(rightHeadlineShapePath, NULL, 375.0, 0.0);
        [_rightHeadlineLayer setPath:rightHeadlineShapePath];
        CGPathRelease(rightHeadlineShapePath);
        [self.layer addSublayer:_rightHeadlineLayer];
    }
    return _rightHeadlineLayer;
}
@end
