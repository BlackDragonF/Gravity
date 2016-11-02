//
//  GRAMainPageViewController.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/12.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAMainPageViewController.h"

#import "GRACardPageViewController.h"
#import "GRANotificationPageViewController.h"
#import "GRAHomePageViewController.h"
#import "GRAOthersInformationViewController.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRAMainPageViewController()
@property (nonatomic, strong) UIImageView * backView;
@property (nonatomic, strong) UIBarButtonItem * notificationButton;
@property (nonatomic, strong) UIBarButtonItem * homepageButton;
@property (nonatomic, strong) UIButton * moreButton;
@property (nonatomic, strong) UIView * containerView;
@property (nonatomic, strong) UIView * shadowView;
@property (nonatomic, strong) GRACardPageViewController * cardpage;
@end

@implementation GRAMainPageViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicConfiguration];
    [self addNavigationItems];
    [self addConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor backGroundColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor textWhiteColor2]];
    self.navigationController.navigationBar.layer.shadowColor = [UIColor clearColor].CGColor;
}
#pragma mark 基本配置
- (void)basicConfiguration {
    [self.view setBackgroundColor:[UIColor backGroundColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self setTitle:@"Gravity"];
}
#pragma mark UI配置
- (void)addConstraints {
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.width.mas_equalTo(@375);
        make.height.mas_equalTo(@254);
    }];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(122.5);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-60);
        make.width.mas_equalTo(@130);
        make.height.mas_equalTo(@44);
    }];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.shadowView);
    }];
    [self.cardpage.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView.mas_centerX);
        make.top.equalTo(self.containerView.mas_top).with.offset(-40);
        make.height.equalTo(self.view.mas_height);
        make.width.equalTo(self.view.mas_width);
    }];
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(37.5);
        make.top.equalTo(self.view.mas_top).with.offset(15);
        make.width.mas_equalTo(@300);
        make.height.mas_equalTo(@458);
    }];
}

- (void)addNavigationItems {
    UIBarButtonItem * negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -4.0;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, self.notificationButton];
    UIBarButtonItem * negativeSpacer2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer2.width = 4.0;
    self.navigationItem.rightBarButtonItems = @[self.homepageButton, negativeSpacer2];
}
#pragma mark 交互相关
- (void)notification {
    GRANotificationPageViewController * notification = [[GRANotificationPageViewController alloc]init];
    [self.navigationController pushViewController:notification animated:YES];
}

- (void)homepage {
    GRAHomePageViewController * homepage = [[GRAHomePageViewController alloc]init];
    [self.navigationController pushViewController:homepage animated:YES];
}

- (void)more {
    GRAOthersInformationViewController * othersInfo = [[GRAOthersInformationViewController alloc]init];
    [self.navigationController pushViewController:othersInfo animated:YES];
}

- (void)tapCard {
    GRACardPageViewController * cardpage = [[GRACardPageViewController alloc]init];
    [self.navigationController pushViewController:cardpage animated:YES];
}
#pragma mark 懒加载方法群
- (UIImageView *)backView {
    if (!_backView) {
        _backView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainpageBackground"]];
        [self.view addSubview:_backView];
    }
    return _backView;
}

- (UIBarButtonItem *)notificationButton {
    if (!_notificationButton) {
        _notificationButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"notification"] style:UIBarButtonItemStylePlain target:self action:@selector(notification)];
    }
    return _notificationButton;
}

- (UIBarButtonItem *)homepageButton {
    if (!_homepageButton) {
        _homepageButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"homepage"] style:UIBarButtonItemStylePlain target:self action:@selector(homepage)];
    }
    return _homepageButton;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _moreButton.backgroundColor = [UIColor clearColor];
        _moreButton.tintColor = [UIColor textWhiteColor2];
        [_moreButton setTitle:@"不止相遇" forState:UIControlStateNormal];
        _moreButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _moreButton.layer.cornerRadius = 5.0;
        _moreButton.layer.masksToBounds = YES;
        _moreButton.layer.borderColor = [UIColor textWhiteColor2].CGColor;
        _moreButton.layer.borderWidth = 0.5;
        [_moreButton addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview: _moreButton];
    }
    return _moreButton;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc]init];
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.cornerRadius = 3.0;
        _containerView.userInteractionEnabled = NO;
        [_containerView addSubview:self.cardpage.view];
        [self.shadowView addSubview:_containerView];
    }
    return _containerView;
}

- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc]init];
        _shadowView.layer.masksToBounds = NO;
        _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        _shadowView.layer.shadowOffset = CGSizeMake(3, 3);
        _shadowView.layer.shadowOpacity = 0.4;
        _shadowView.layer.shadowRadius = 3.0;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCard)];
        [_shadowView addGestureRecognizer:tap];
        [self.view addSubview:_shadowView];
    }
    return _shadowView;
}

- (GRACardPageViewController *)cardpage {
    if (!_cardpage) {
        _cardpage = [[GRACardPageViewController alloc]init];
    }
    return _cardpage;
}
@end
