//
//  GRAStartpageViewController.m
//  Gravity
//
//  Created by 陈志浩 on 2016/11/5.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAStartpageViewController.h"
#import "ColorMacro.h"
#import "Masonry.h"

#import "GRALoginViewController.h"
#import "GRARegisterFirstViewController.h"

@interface GRAStartpageViewController ()
@property (nonatomic, strong) UIImageView * iconView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * subtitleLabel;
@property (nonatomic, strong) UIButton * signinButton;
@property (nonatomic, strong) UIButton * signupButton;
@end

@implementation GRAStartpageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicConfiguration];
    [self methodConfiguration];
    [self addConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)basicConfiguration {
    self.view.backgroundColor = [UIColor backGroundColor];
}

- (void)addConstraints {
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(106.5);
        make.height.mas_equalTo(@100);
        make.width.mas_equalTo(@100);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.iconView.mas_centerX);
        make.top.equalTo(self.iconView.mas_bottom).with.offset(19);
        make.height.mas_equalTo(@29);
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.titleLabel.mas_centerX);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(12);
        make.height.mas_equalTo(@15);
    }];
    [self.signinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.subtitleLabel.mas_centerX);
        make.top.equalTo(self.subtitleLabel.mas_bottom).with.offset(99);
        make.width.mas_equalTo(@280);
        make.height.mas_equalTo(@44);
    }];
    [self.signupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.signinButton.mas_centerX);
        make.top.equalTo(self.signinButton.mas_bottom).with.offset(15);
        make.width.mas_equalTo(@280);
        make.height.mas_equalTo(@44);
    }];
}

#pragma mark 懒加载方法群
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"PlanetIcon1"]];
        [self.view addSubview:_iconView];
    }
    return _iconView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:29.0];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"Gravity";
        [self.view addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc]init];
        _subtitleLabel.font = [UIFont systemFontOfSize:15.0];
        _subtitleLabel.textColor = [UIColor textGreenColor];
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
        _subtitleLabel.text = @"I can reach you";
        [self.view addSubview:_subtitleLabel];
    }
    return _subtitleLabel;
}

- (UIButton *)signinButton {
    if (!_signinButton) {
        _signinButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_signinButton setAttributedTitle:[[NSAttributedString alloc]initWithString:@"登录" attributes:@{NSForegroundColorAttributeName: [UIColor textWhiteColor2], NSFontAttributeName: [UIFont systemFontOfSize:14.0]}] forState:UIControlStateNormal];
        _signinButton.backgroundColor = [UIColor backgroundRedColor];
        _signinButton.layer.cornerRadius = 5.0;
        _signinButton.layer.masksToBounds = YES;
        [self.view addSubview:_signinButton];
    }
    return _signinButton;
}

- (UIButton *)signupButton {
    if (!_signupButton) {
        _signupButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_signupButton setAttributedTitle:[[NSAttributedString alloc]initWithString:@"注册" attributes:@{NSForegroundColorAttributeName: [UIColor textWhiteColor2], NSFontAttributeName: [UIFont systemFontOfSize:14.0]}] forState:UIControlStateNormal];
        _signupButton.backgroundColor = [UIColor transparentWhiteColor];
        _signupButton.layer.cornerRadius = 5.0;
        _signupButton.layer.masksToBounds = YES;
        [self.view addSubview:_signupButton];
    }
    return _signupButton;
}

#pragma mark 交互相关
- (void)methodConfiguration {
    [self.signinButton addTarget:self action:@selector(signin) forControlEvents:UIControlEventTouchUpInside];
    [self.signupButton addTarget:self action:@selector(signup) forControlEvents:UIControlEventTouchUpInside];
}

- (void)signin {
    GRALoginViewController * login = [[GRALoginViewController alloc]init];
    UINavigationController * navigation = [[UINavigationController alloc]initWithRootViewController:login];
    [self configureNavitionController:navigation];
    [self presentViewController:navigation animated:YES completion:^{
    }];
}

- (void)signup {
    GRARegisterFirstViewController * register1 = [[GRARegisterFirstViewController alloc]init];
    UINavigationController * navigation = [[UINavigationController alloc]initWithRootViewController:register1];
    [self configureNavitionController:navigation];
    [self presentViewController:navigation animated:YES completion:^{
    }];
}

- (void)configureNavitionController:(UINavigationController *)navigation {
    [navigation.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [navigation.navigationBar setShadowImage:[[UIImage alloc]init]];
    CALayer * layer = navigation.navigationBar.layer;
    layer.masksToBounds = NO;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(0, 2.5);
    layer.shadowOpacity = 0.1;
    layer.shouldRasterize = YES;
}
@end
