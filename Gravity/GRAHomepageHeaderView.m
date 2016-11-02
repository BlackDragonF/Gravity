//
//  HomepageHeaderView.m
//  Gravity
//
//  Created by 陈志浩 on 16/4/12.
//  Copyright © 2016年 UniqueStudio. All rights reserved.
//

#import "GRAHomePageHeaderView.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRAHomePageHeaderView ()
@property (nonatomic, strong) UIImageView * avatarView;
@property (nonatomic, strong) UILabel * nicknameLabel;
@property (nonatomic, strong) UIImageView * genderView;
@property (nonatomic, strong) UILabel * locationLabel;
@property (nonatomic, strong) UIButton * changeInfomationButton;
@end

@implementation GRAHomePageHeaderView
#pragma mark 初始化方法群
- (instancetype)init{
    return [self initWithAvatar:[UIImage imageNamed:@"default"] Nickname:@"NICKNAME" Gender:Man andLocation:@"华中科技大学东校区"];
}

- (instancetype)initWithAvatar:(UIImage *)avatar Nickname:(NSString *)nickname Gender:(Gender)gender andLocation:(NSString *)location{
    if (self = [super init]){
        _avatar = avatar;
        _nickname = nickname;
        _gender = gender;
        _location = location;
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"PlanetIcon2"]]];
        [self addConstraints];
    }
    return self;
}
#pragma mark UI配置
- (void)addConstraints {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.changeInfomationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(13);
        make.right.equalTo(self.contentView.mas_right).with.offset(-34);
        make.width.equalTo(@22);
        make.height.equalTo(@22);
    }];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).with.offset(13);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
    }];
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.avatarView.mas_centerX);
        make.top.equalTo(self.avatarView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@13);
    }];
    [self.genderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nicknameLabel.mas_centerY);
        make.left.equalTo(self.nicknameLabel.mas_right).with.offset(5);
        make.height.mas_equalTo(@10);
        make.width.mas_equalTo(@10);
    }];
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.avatarView.mas_centerX);
        make.top.equalTo(self.nicknameLabel.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@12);
    }];
}
#pragma mark 交互相关
- (void)addTargetToButton:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    [self.changeInfomationButton addTarget:target action:action forControlEvents:controlEvents];
}
#pragma mark set方法群
- (void)setAvatar:(UIImage *)avatar{
    _avatar = avatar;
    [self.avatarView setImage:_avatar];
}

- (void)setNickname:(NSString *)nickname{
    _nickname = nickname;
    [self.nicknameLabel setText:_nickname];
}

- (void)setGender:(Gender)gender{
    _gender = gender;
    if (_gender == Man)
        self.genderView.image = [UIImage imageNamed:@"man"];
    else
        self.genderView.image = [UIImage imageNamed:@"woman"];
}

- (void)setLocation:(NSString *)location{
    _location = location;
    [self.locationLabel setText:_location];
}
#pragma mark 懒加载方法群
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc]initWithImage:self.avatar];
        _avatarView.layer.cornerRadius = 50.0f;
        _avatarView.layer.masksToBounds = YES;
        _avatarView.layer.borderColor = [UIColor textGreenColor].CGColor;
        _avatarView.layer.borderWidth = 0.5f;
        [self.contentView addSubview:_avatarView];
    }
    return _avatarView;
}

- (UILabel *)nicknameLabel {
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc]init];
        [_nicknameLabel setText:self.nickname];
        [_nicknameLabel setTextColor:[UIColor textBlackColor]];
        [_nicknameLabel setTextAlignment:NSTextAlignmentCenter];
        [_nicknameLabel setFont:[UIFont systemFontOfSize:13.0]];
        [self.contentView addSubview:_nicknameLabel];
    }
    return _nicknameLabel;
}

- (UIImageView *)genderView {
    if (!_genderView) {
        _genderView = [[UIImageView alloc]init];
        if (self.gender == Man)
            _genderView.image = [UIImage imageNamed:@"man"];
        else
            _genderView.image = [UIImage imageNamed:@"woman"];
        [self.contentView addSubview:_genderView];
    }
    return _genderView;
}

- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc]init];
        [_locationLabel setText:self.location];
        [_locationLabel setTextColor:[UIColor textGrayColor]];
        [_locationLabel setTextAlignment:NSTextAlignmentCenter];
        [_locationLabel setFont:[UIFont systemFontOfSize:12.0]];
        [self.contentView addSubview:_locationLabel];
    }
    return _locationLabel;
}

- (UIButton *)changeInfomationButton {
    if (!_changeInfomationButton) {
        _changeInfomationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_changeInfomationButton setImage:[UIImage imageNamed:@"changeInformation"] forState:UIControlStateNormal];
        [_changeInfomationButton setTintColor:[UIColor textWhiteColor2]];
        [self.contentView addSubview:_changeInfomationButton];
    }
    return _changeInfomationButton;
}
@end
