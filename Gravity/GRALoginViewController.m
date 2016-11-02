//
//  LoginViewController.m
//  Gravity
//
//  Created by 陈志浩 on 16/6/6.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRALoginViewController.h"
#import "ColorMacro.h"
#import "Masonry.h"
#import "GRANetworkingManager.h"

@interface GRALoginViewController()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView * planetIconView;
@property (nonatomic, strong) UIImageView * textIcon1;
@property (nonatomic, strong) UIImageView * textIcon2;
@property (nonatomic, strong) UIView * phoneBackground;
@property (nonatomic, strong) UIView * passwordBackground;
@property (nonatomic, strong) UITextField * phoneText;
@property (nonatomic, strong) UITextField * passwordText;
@property (nonatomic, strong) UIButton * loginButton;
@property (nonatomic, strong) UIButton * forgetButton;
@end

@implementation GRALoginViewController
static NSString * loginURL = @"/backend/api/user/signin";
- (void)viewDidLoad{
    [super viewDidLoad];
    [self basicConfiguration];
    [self methodConfiguration];
    [self addConstraints];
}
#pragma mark UI配置
- (void)basicConfiguration{
    self.view.backgroundColor = [UIColor backGroundColor];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor backGroundColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self setTitle:@"登录"];
}

- (void)addConstraints{
    [self.planetIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(49);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@100);
    }];
    [self.phoneBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.planetIconView.mas_bottom).with.offset(67);
        make.left.equalTo(self.view.mas_left).with.offset(47.5);
        make.height.mas_equalTo(@44);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    [self.textIcon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneBackground.mas_top).with.offset(11);
        make.left.equalTo(self.phoneBackground.mas_left).with.offset(10);
        make.width.mas_equalTo(@22);
        make.height.mas_equalTo(@22);
    }];
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneBackground.mas_top).with.offset(16.5);
        make.height.mas_equalTo(@13);
        make.left.equalTo(self.textIcon1.mas_right).with.offset(10);
        make.centerX.equalTo(self.phoneBackground.mas_centerX).with.offset(10);
    }];
    [self.passwordBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneBackground.mas_bottom).with.offset(15);
        make.left.equalTo(self.phoneBackground.mas_left);
        make.height.mas_equalTo(@44);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    [self.textIcon2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordBackground.mas_top).with.offset(11);
        make.left.equalTo(self.passwordBackground.mas_left).with.offset(10);
        make.width.mas_equalTo(@22);
        make.height.mas_equalTo(@22);
    }];
    [self.passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordBackground.mas_top).with.offset(16.5);
        make.height.mas_equalTo(@13);
        make.left.equalTo(self.textIcon2.mas_right).with.offset(10);
        make.centerX.equalTo(self.passwordBackground.mas_centerX).with.offset(10);
    }];
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordBackground.mas_bottom).with.offset(10);
        make.right.equalTo(self.passwordBackground.mas_right);
        make.height.mas_equalTo(@10);
    }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordBackground.mas_bottom).with.offset(44);
        make.height.mas_equalTo(@44);
        make.left.equalTo(self.passwordBackground.mas_left);
        make.right.equalTo(self.passwordBackground.mas_right);
    }];
}
#pragma mark 交互相关
- (void)methodConfiguration{
    [self.forgetButton addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
}

- (void)forgetPassword{
    GRARetrievePasswordViewController * retrievePassword = [[GRARetrievePasswordViewController alloc]init];
    [self.navigationController showViewController:retrievePassword sender:self];
}

- (void)login{
    NSDictionary * parameters = @{
                                  @"phone": self.phoneText.text,
                                  @"password": self.passwordText.text
                                  };
    [[GRANetworkingManager sharedManager]requestWithApplendixURL:loginURL andParameters:parameters completionHandler:^(NSDictionary * responseJSON) {
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.phoneText resignFirstResponder];
    [self.passwordText resignFirstResponder];
}
#pragma mark UITextField代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isEqual:_phoneText]){
        [self.phoneText resignFirstResponder];
        [self.passwordText becomeFirstResponder];
    } else if ([textField isEqual:_passwordText]){
        [self.passwordText resignFirstResponder];
        [self login];
    }
    return YES;
}
#pragma mark 懒加载方法群
- (UIImageView *)planetIconView {
    if (!_planetIconView) {
        _planetIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"PlanetIcon1"]];
        [self.view addSubview:_planetIconView];
    }
    return _planetIconView;
}

- (UIImageView *)textIcon1 {
    if (!_textIcon1) {
        _textIcon1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"TextIcon1"]];
        [self.phoneBackground addSubview:_textIcon1];
    }
    return _textIcon1;
}

- (UIImageView *)textIcon2 {
    if (!_textIcon2) {
        _textIcon2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"TextIcon2"]];
        [self.passwordBackground addSubview:_textIcon2];
    }
    return _textIcon2;
}

- (UIView *)phoneBackground {
    if (!_phoneBackground) {
        _phoneBackground = [[UIView alloc]init];
        _phoneBackground.backgroundColor = [UIColor transparentWhiteColor];
        _phoneBackground.layer.cornerRadius = 5.0;
        _phoneBackground.layer.masksToBounds = YES;
        [self.view addSubview:_phoneBackground];
    }
    return _phoneBackground;
}

- (UIView *)passwordBackground {
    if (!_passwordBackground) {
        _passwordBackground = [[UIView alloc]init];
        _passwordBackground.backgroundColor = [UIColor transparentWhiteColor];
        _passwordBackground.layer.cornerRadius = 5.0;
        _passwordBackground.layer.masksToBounds = YES;
        [self.view addSubview:_passwordBackground];
    }
    return _passwordBackground;
}

- (UITextField *)phoneText {
    if (!_phoneText) {
        _phoneText = [[UITextField alloc]init];
        _phoneText.delegate = self;
        _phoneText.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName: [UIColor textWhiteColor]}];
        _phoneText.font = [UIFont systemFontOfSize:13.0];
        _phoneText.textColor = [UIColor textWhiteColor2];
        _phoneText.tintColor = [UIColor textWhiteColor2];
        _phoneText.textAlignment = NSTextAlignmentCenter;
        _phoneText.returnKeyType = UIReturnKeyNext;
        [self.phoneBackground addSubview:_phoneText];
    }
    return _phoneText;
}

- (UITextField *)passwordText {
    if (!_passwordText) {
        _passwordText = [[UITextField alloc]init];
        _passwordText.delegate = self;
        _passwordText.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: [UIColor textWhiteColor]}];
        _passwordText.font = [UIFont systemFontOfSize:13.0];
        _passwordText.textColor = [UIColor textWhiteColor2];
        _passwordText.tintColor = [UIColor textWhiteColor2];
        _passwordText.textAlignment = NSTextAlignmentCenter;
        _passwordText.secureTextEntry = YES;
        _passwordText.clearsOnBeginEditing = YES;
        _passwordText.returnKeyType = UIReturnKeyDone;
        [self.passwordBackground addSubview:_passwordText];
    }
    return _passwordText;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_loginButton setAttributedTitle:[[NSAttributedString alloc]initWithString:@"登录" attributes:@{NSForegroundColorAttributeName: [UIColor textWhiteColor2], NSFontAttributeName: [UIFont systemFontOfSize:14.0]}] forState:UIControlStateNormal];
        _loginButton.backgroundColor = [UIColor backgroundRedColor];
        _loginButton.layer.cornerRadius = 5.0;
        _loginButton.layer.masksToBounds = YES;
        [self.view addSubview:_loginButton];
    }
    return _loginButton;
}

- (UIButton *)forgetButton {
    if (!_forgetButton) {
        _forgetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_forgetButton setAttributedTitle:[[NSAttributedString alloc]initWithString:@"忘了密码？" attributes:@{NSForegroundColorAttributeName: [UIColor textGreenColor], NSFontAttributeName: [UIFont systemFontOfSize:10.0]}] forState:UIControlStateNormal];
        [self.view addSubview:_forgetButton];
    }
    return _forgetButton;
}
@end
