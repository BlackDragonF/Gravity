//
//  GRAOthersInformationHeaderView.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/12.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAOthersInformationHeaderView.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRAOthersInformationHeaderView()
@property (nonatomic, strong) UIImageView * avatarView;
@property (nonatomic, strong) UILabel * nicknameLabel;
@property (nonatomic, strong) UIImageView * genderView;
@property (nonatomic, strong) UILabel * locationLabel;
@property (nonatomic, strong) UILabel * contactTitleLabel;
@property (nonatomic, strong) UILabel * contactContentLabel;
@property (nonatomic, strong) UIView * contactView;
@end

@implementation GRAOthersInformationHeaderView
#pragma mark 初始化方法
- (instancetype)initWithAvatar:(UIImage *)avatar NickName:(NSString *)nickname Gender:(Gender)gender Location:(NSString *)location andContact:(NSString *)contact {
    if (self = [super init]) {
        self.avatar = avatar;
        self.nickname = nickname;
        self.gender = gender;
        self.location = location;
        self.contact = contact;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"PlanetIcon3"]];
        self.clipsToBounds = NO;
        [self addConstraints];
    }
    return self;
}
#pragma mark UI配置
- (void)addConstraints {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(21);
        make.top.equalTo(self.contentView.mas_top).with.offset(9);
        make.right.equalTo(self.locationLabel.mas_left).with.offset(-30);
        make.height.mas_equalTo(@120);
        make.width.mas_equalTo(@120);
    }];
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarView.mas_top).with.offset(27);
        make.bottom.equalTo(self.locationLabel.mas_top).with.offset(-10);
        make.left.equalTo(self.avatarView.mas_right).with.offset(44);
    }];
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nicknameLabel.mas_bottom).with.offset(10);
        make.bottom.equalTo(self.contactView.mas_top).with.offset(-12);
    }];
    [self.contactView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarView.mas_right).with.offset(13);
        make.width.mas_equalTo(@180);
        make.height.mas_equalTo(@44);
    }];
    [self.genderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nicknameLabel.mas_top);
        make.left.equalTo(self.nicknameLabel.mas_right);
        make.height.mas_equalTo(@13);
        make.width.mas_equalTo(@13);
    }];
    [self.contactTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.contactContentLabel.mas_height);
        make.top.equalTo(self.contactView.mas_top).with.offset(7.5);
        make.left.equalTo(self.contactView.mas_left).with.offset(13);
        make.bottom.equalTo(self.contactContentLabel.mas_top).with.offset(-7.5);
    }];
    [self.contactContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contactView.mas_left).with.offset(30);
        make.bottom.equalTo(self.contactView.mas_bottom).with.offset(-7.5);
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

- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc]init];
        _avatarView.layer.masksToBounds = YES;
        _avatarView.layer.cornerRadius = 60.0;
        _avatarView.layer.borderWidth = 0.5;
        [self.contentView addSubview:_avatarView];
    }
    return _avatarView;
}

- (UILabel *)nicknameLabel {
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc]init];
        [_nicknameLabel setTextColor:[UIColor textBlackColor]];
        [_nicknameLabel setFont:[UIFont systemFontOfSize:13.0]];
        [_nicknameLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_nicknameLabel];
    }
    return _nicknameLabel;
}

- (UIImageView *)genderView {
    if (!_genderView) {
        _genderView = [[UIImageView alloc]init];
        [self.contentView addSubview:_genderView];
    }
    return _genderView;
}

- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc]init];
        [_locationLabel setTextColor:[UIColor textGrayColor]];
        [_locationLabel setFont:[UIFont systemFontOfSize:12.0]];
        [_locationLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_locationLabel];
    }
    return _locationLabel;
}

- (UILabel *)contactTitleLabel {
    if (!_contactTitleLabel) {
        _contactTitleLabel = [[UILabel alloc]init];
        [_contactTitleLabel setText:@"联系方式："];
        [_contactTitleLabel setTextColor:[UIColor textBlackColor]];
        [_contactTitleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [_contactTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_contactTitleLabel];
    }
    return _contactTitleLabel;
}

- (UILabel *)contactContentLabel {
    if (!_contactContentLabel) {
        _contactContentLabel = [[UILabel alloc]init];
        [_contactContentLabel setTextColor:[UIColor textBlackColor]];
        [_contactContentLabel setFont:[UIFont systemFontOfSize:12.0]];
        [_contactContentLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_contactContentLabel];
    }
    return _contactContentLabel;
}

- (UIView *)contactView {
    if (!_contactView) {
        _contactView = [[UIView alloc]init];
        [_contactView setBackgroundColor:[UIColor transparentWhiteColor3]];
        [_contactView addSubview:self.contactTitleLabel];
        [_contactView addSubview:self.contactContentLabel];
        [self.contentView addSubview:_contactView];
    }
    return _contactView;
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

- (void)setContact:(NSString *)contact{
    _contact = contact;
    [self.contactContentLabel setText:_contact];
}
@end
