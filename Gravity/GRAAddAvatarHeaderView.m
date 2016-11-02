//
//  GRAAddAvatarHeaderView.m
//  Gravity
//
//  Created by 陈志浩 on 16/6/9.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAAddAvatarHeaderView.h"
#import "Masonry.h"
#import "ColorMacro.h"

@interface GRAAddAvatarHeaderView()
@property (nonatomic, strong) UIButton * avatarButton;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UIImageView * avatarView;
@end

@implementation GRAAddAvatarHeaderView
- (instancetype)init {
    if (self = [super init]) {
        [self makeComponents];
    }
    return self;
}

- (void)makeComponents {
    [self.avatarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@100);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarButton.mas_top).with.offset(30);
        make.centerX.equalTo(self.avatarButton.mas_centerX);
        make.width.mas_equalTo(@22);
        make.height.mas_equalTo(@22);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).with.offset(13);
        make.left.equalTo(self.avatarButton.mas_left).with.offset(24);
        make.centerX.equalTo(self.avatarButton.mas_centerX);
        make.height.mas_equalTo(@13);
    }];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.avatarButton);
    }];
}
#pragma mark set方法
- (void)setAvatar:(UIImage *)avatar {
    _avatar = avatar;
    [self.avatarView setImage:avatar];
}
#pragma mark 交互相关
- (void)addTarget:(id)target action:(SEL)sel forControlEvents:(UIControlEvents)controlEvents {
    [self.avatarButton addTarget:target action:sel forControlEvents:controlEvents];
}
#pragma mark 懒加载方法群
- (UIButton *)avatarButton {
    if (!_avatarButton) {
        _avatarButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _avatarButton.backgroundColor = [UIColor addAvatarGrayColor];
        _avatarButton.layer.cornerRadius = 50.0;
        _avatarButton.layer.masksToBounds = YES;
        [self addSubview:_avatarButton];
    }
    return _avatarButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"添加头像";
        _titleLabel.textColor = [UIColor textWhiteColor2];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:13.0];
        [self.avatarButton addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AddAvatarIcon"]];
        [self.avatarButton addSubview:_imageView];
    }
    return _imageView;
}

- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc]init];
        _avatarView.layer.cornerRadius = 50.0;
        _avatarView.layer.masksToBounds = YES;
        [self addSubview:_avatarView];
    }
    return _avatarView;
}
@end

