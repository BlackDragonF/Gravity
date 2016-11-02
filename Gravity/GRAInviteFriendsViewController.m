//
//  GRAInviteFriendsViewController.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/10.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAInviteFriendsViewController.h"

#import "GRAInviteFriendsMainView.h"
#import "GRAInviteFriendsSideView.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRAInviteFriendsViewController()
@property (nonatomic, strong) UILabel * descriptionLabel;
@property (nonatomic, strong) GRAInviteFriendsMainView * mainView;
@property (nonatomic, strong) GRAInviteFriendsSideView * sideView;
@property (nonatomic, strong) UIBarButtonItem * backButton;
@end

@implementation GRAInviteFriendsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicConfiguration];
    [self addNavigationItems];
    [self addConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
}
#pragma mark 基本配置
- (void)basicConfiguration {
    [self.view setBackgroundColor:[UIColor backGroundColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor backGroundColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor textWhiteColor2]];
    [self setTitle:@"邀请好友"];
}
#pragma mark UI配置
- (void)addConstraints {
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(20);
        make.left.equalTo(self.view.mas_left).with.offset(18);
        make.right.equalTo(self.view.mas_right).with.offset(-18);
    }];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descriptionLabel.mas_bottom).with.offset(30);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(@273.5);
    }];
    [self.sideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(@100);
    }];
}

- (void)addNavigationItems {
    UIBarButtonItem * negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -4.0;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, self.backButton];
}
#pragma mark 交互相关
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 懒加载方法群
- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc]init];
        NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc]init];
        style.lineSpacing = 2.5;
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.attributedText = [[NSAttributedString alloc]initWithString:@"分享到其他平台或者邀请你的好友下载应用并完成注册，你将获得能量石奖励！"attributes:@{NSParagraphStyleAttributeName:style}];
        _descriptionLabel.textColor = [UIColor textWhiteColor];
        _descriptionLabel.textAlignment = NSTextAlignmentLeft;
        _descriptionLabel.font = [UIFont systemFontOfSize:13.0];
        [self.view addSubview:_descriptionLabel];
    }
    return _descriptionLabel;
}

- (GRAInviteFriendsMainView *)mainView {
    if (!_mainView) {
        _mainView = [[GRAInviteFriendsMainView alloc]init];
        [self.view addSubview:_mainView];
    }
    return _mainView;
}

- (GRAInviteFriendsSideView *)sideView {
    if (!_sideView) {
        _sideView = [[GRAInviteFriendsSideView alloc]init];
        [self.view addSubview:_sideView];
    }
    return _sideView;
}

- (UIBarButtonItem *)backButton {
    if (!_backButton) {
        UIButton * backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        backButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0);
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        _backButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    }
    return _backButton;
}
@end
