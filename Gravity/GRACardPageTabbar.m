//
//  GRACardPageTabbar.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/12.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRACardPageTabbar.h"

#import "Masonry.h"
#import "ColorMacro.h"

@implementation GRACardPageTabbar
- (instancetype)init {
    if (self = [super init]) {
        [self.contentView setBackgroundColor:[UIColor backGroundColor]];
        [self.contentView.layer setOpacity:0.95];
        [self.contentView setClipsToBounds:NO];
        [self addConstraints];
    }
    return self;
}
#pragma mark UI配置
- (void)addConstraints {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(@49);
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        make.height.mas_equalTo(@22);
        make.width.mas_equalTo(@22);
    }];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
        make.height.mas_equalTo(@70);
        make.width.mas_equalTo(@70);
    }];
}
#pragma mark 懒加载方法群
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_backButton setImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
        _backButton.tintColor = [UIColor textWhiteColor2];
        [self.contentView addSubview:_backButton];
    }
    return _backButton;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_moreButton setBackgroundColor:[UIColor backGroundColor]];
        [_moreButton setTitle:@"不止相遇" forState:UIControlStateNormal];
//        _moreButton.layer.borderColor = [UIColor transparentWhiteColor].CGColor;
//        _moreButton.layer.borderWidth = 0.5;
        _moreButton.layer.cornerRadius = 35.0;
        _moreButton.layer.masksToBounds = YES;
        _moreButton.layer.opacity = 0.95;
        _moreButton.tintColor = [UIColor textWhiteColor2];
        _moreButton.titleLabel.textColor = [UIColor textWhiteColor2];
        _moreButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:_moreButton];
    }
    return _moreButton;
}
@end
