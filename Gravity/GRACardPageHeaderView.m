//
//  GRACardPageHeaderView.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/11.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRACardPageHeaderView.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRACardPageHeaderView()
@property (nonatomic, strong) UILabel * dateLabel;
@property (nonatomic, strong) UIImageView * avatarView;
@property (nonatomic, strong) UILabel * nicknameLabel;
@property (nonatomic, strong) UIImageView * genderView;
@property (nonatomic, strong) UILabel * locationLabel;
@end

@implementation GRACardPageHeaderView
#pragma mark 初始化方法群
- (instancetype)initWithDate:(NSString *)date Avatar:(UIImage *)avatar Nickname:(NSString *)nickname Gender:(Gender)gender andLocation:(NSString *)location {
    if (self = [super init]) {
        self.date = date;
        self.avatar = avatar;
        self.nickname = nickname;
        self.gender = gender;
        self.location = location;
        [self addConstraints];
        [self setBackgroundColor:[UIColor textWhiteColor2]];
    }
    return self;
}
#pragma mark UI配置
- (void)addConstraints {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(15);
        make.right.equalTo(self.contentView).with.offset(-27.5);
        make.height.mas_equalTo(@10);
    }];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(35);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(@130);
        make.height.mas_equalTo(@130);
    }];
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarView.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(@14);
    }];
    [self.genderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nicknameLabel.mas_right).with.offset(2.5);
        make.centerY.equalTo(self.nicknameLabel.mas_centerY);
        make.width.mas_equalTo(@10);
        make.height.mas_equalTo(@10);
    }];
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nicknameLabel.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(@10);
//        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-15);
    }];
}
#pragma mark set方法群
- (void)setDate:(NSString *)date {
    _date = date;
    [self.dateLabel setText:_date];
}

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
        _contentView = [[UIView alloc]init];
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.textColor = [UIColor textBlackColor];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.font = [UIFont systemFontOfSize:10.0];
        [self.contentView addSubview:_dateLabel];
    }
    return _dateLabel;
}

- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc]init];
        _avatarView.layer.masksToBounds = YES;
        _avatarView.layer.cornerRadius = 65.0;
        _avatarView.layer.borderColor = [UIColor textGreenColor].CGColor;
        _avatarView.layer.borderWidth = 0.5;
        [self.contentView addSubview:_avatarView];
    }
    return _avatarView;
}

- (UILabel *)nicknameLabel {
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc]init];
        _nicknameLabel.textColor = [UIColor textBlackColor];
        _nicknameLabel.textAlignment = NSTextAlignmentCenter;
        _nicknameLabel.font = [UIFont systemFontOfSize:14.0];
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
        [_locationLabel setFont:[UIFont systemFontOfSize:10.0]];
        [self.contentView addSubview:_locationLabel];
    }
    return _locationLabel;
}
@end
