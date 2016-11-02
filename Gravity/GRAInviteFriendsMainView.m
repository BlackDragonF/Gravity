//
//  GRAInviteFriendsMainView.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/10.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAInviteFriendsMainView.h"

#import "GRAInviteFriendsButton.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRAInviteFriendsMainView()
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) CAShapeLayer * leftHeadlineLayer;
@property (nonatomic, strong) CAShapeLayer * rightHeadlineLayer;
@end

@implementation GRAInviteFriendsMainView
- (instancetype)init {
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"InviteFriendsBackground"]]];
        [self addConstraints];
        [self createHeadline];
    }
    return self;
}
#pragma mark UI配置
- (void)addConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(@13);
    }];
    [self.momentsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(30);
        make.left.equalTo(self.mas_left).with.offset(67.5);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@88);
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
        _titleLabel.text = @"通过一下方式分享/邀请";
        _titleLabel.textColor = [UIColor textGreenColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (GRAInviteFriendsButton *)momentsButton {
    if (!_momentsButton) {
        _momentsButton = [GRAInviteFriendsButton buttonWithType:UIButtonTypeRoundedRect];
#warning image to be replaced
        _momentsButton.icon = [UIImage imageNamed:@"man"];
        _momentsButton.name = @"朋友圈";
        [self addSubview:_momentsButton];
    }
    return _momentsButton;
}

- (CAShapeLayer *)leftHeadlineLayer{
    if (!_leftHeadlineLayer){
        _leftHeadlineLayer = [CAShapeLayer layer];
        CGMutablePathRef leftHeadlineShapePath = CGPathCreateMutable();
        [_leftHeadlineLayer setFillColor:[UIColor clearColor].CGColor];
        [_leftHeadlineLayer setStrokeColor:[UIColor separatorPurpleColor].CGColor];
        _leftHeadlineLayer.lineWidth = 0.5f;
        CGPathMoveToPoint(leftHeadlineShapePath, NULL, 0.0, 6.5);
        CGPathAddLineToPoint(leftHeadlineShapePath, NULL, 107.5, 6.5);
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
        CGPathMoveToPoint(rightHeadlineShapePath, NULL, 375.0-107.5, 6.5);
        CGPathAddLineToPoint(rightHeadlineShapePath, NULL, 375.0, 6.5);
        [_rightHeadlineLayer setPath:rightHeadlineShapePath];
        CGPathRelease(rightHeadlineShapePath);
        [self.layer addSublayer:_rightHeadlineLayer];
    }
    return _rightHeadlineLayer;
}
@end
