//
//  GRAInviteFriendsButton.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/10.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAInviteFriendsButton.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRAInviteFriendsButton ()
@property (nonatomic, strong) UIImageView * iconView;
@property (nonatomic, strong) UILabel * nameLabel;
@end

@implementation GRAInviteFriendsButton
+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    GRAInviteFriendsButton * button = [super buttonWithType:buttonType];
    [button addConstraints];
    return button;
}
#pragma mark UI配置
- (void)addConstraints {
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.height.mas_equalTo(@60);
        make.width.mas_equalTo(@60);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_bottom).with.offset(15);
        make.centerX.equalTo(self.iconView.mas_centerX);
        make.height.mas_equalTo(@13);
    }];
}
#pragma mark set方法群
- (void)setName:(NSString *)name {
    _name = name;
    self.nameLabel.text = _name;
}

- (void)setIcon:(UIImage *)icon {
    _icon = icon;
    self.iconView.image = _icon;
}
#pragma mark 懒加载方法群
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        [self addSubview:_iconView];
    }
    return _iconView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor textWhiteColor2];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}
@end
