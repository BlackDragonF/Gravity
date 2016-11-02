//
//  RegisterFirstViewController.m
//  Gravity
//
//  Created by 陈志浩 on 16/6/7.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRARegisterFirstViewController.h"
#import "ColorMacro.h"
#import "Masonry.h"
#import "GRANetworkingManager.h"
@interface GRARegisterFirstViewController()<UITextFieldDelegate> {
    NSDictionary * _resendButtonAttributedTitle;
    NSTimer * _timer;
    NSInteger _timeCount;
}   
@property (nonatomic, strong) UIImageView * textIcon1;
@property (nonatomic, strong) UIImageView * textIcon2;
@property (nonatomic, strong) UIView * phoneBackground;
@property (nonatomic, strong) UIView * passwordBackground;
@property (nonatomic, strong) UITextField * phoneText;
@property (nonatomic, strong) UITextField * passwordText;
@property (nonatomic, strong) UITextField * verificationText;
@property (nonatomic, strong) UIButton * resendButton;
@property (nonatomic, strong) UIBarButtonItem * nextButton;
@end

@implementation GRARegisterFirstViewController
static NSString * signupSmsURL = @"/backend/api/user/signup_sms";
static NSString * verifyPhoneURL = @"/backend/api/user/verify_phone";
- (void)viewDidLoad{
    [super viewDidLoad];
    [self basicConfiguration];
    [self addConstraints];
    [self addNavigationItems];
}
#pragma mark UI配置
- (void)basicConfiguration{
    //导航栏
    self.view.backgroundColor = [UIColor backGroundColor];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor backGroundColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor textWhiteColor2]];
    [self setTitle:@"注册"];
    //字典
    _resendButtonAttributedTitle = @{
                                     NSForegroundColorAttributeName: [UIColor textGreenColor],
                                     NSFontAttributeName: [UIFont systemFontOfSize:13.0]
                                     };
}

- (void)addNavigationItems{
    [self.resendButton addTarget:self action:@selector(resend) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * negativeSpacer2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer2.width = 4.0;
    self.navigationItem.rightBarButtonItems = @[self.nextButton, negativeSpacer2];
}

- (void)addConstraints{
    [self.phoneBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(39);
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
        make.top.equalTo(self.phoneBackground.mas_top);
        make.bottom.equalTo(self.phoneBackground.mas_bottom);
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
        make.top.equalTo(self.passwordBackground.mas_top);
        make.bottom.equalTo(self.passwordBackground.mas_bottom);
        make.left.equalTo(self.textIcon2.mas_right).with.offset(10);
        make.centerX.equalTo(self.passwordBackground.mas_centerX).with.offset(10);
    }];
    [self.verificationText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordBackground.mas_bottom).with.offset(15);
        make.left.equalTo(self.passwordBackground.mas_left);
        make.height.mas_equalTo(@44);
        make.width.equalTo(self.resendButton).multipliedBy(71.0/52.0);
    }];
    [self.resendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verificationText.mas_top);
        make.right.equalTo(self.passwordBackground.mas_right);
        make.height.mas_equalTo(@44);
        make.left.equalTo(self.verificationText.mas_right).with.offset(14);
    }];
}
#pragma mark 交互相关
- (void)resend{
    self.resendButton.backgroundColor = [UIColor transparentWhiteColor2];
    [[GRANetworkingManager sharedManager]requestWithApplendixURL:signupSmsURL andParameters:@{@"phone": self.phoneText.text} completionHandler:^(NSDictionary * responseJSON) {
        if([responseJSON[@"error"] isEqualToString:@"ok"]){
            _timeCount = 60;
            self.resendButton.userInteractionEnabled = NO;
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeCount) userInfo:nil repeats:YES];
        } else if ([responseJSON[@"error"] isEqualToString:@"phone:exists"]){
            NSLog(@"用户注册：手机号已存在！");
        }
    }];
}

- (void)nextStep{
    NSDictionary * verifyPhoneParameters = @{
                                             @"phone": self.phoneText.text,
                                             @"code": self.verificationText.text,
                                             @"type": @"signup"
                                             };
    [[GRANetworkingManager sharedManager]requestWithApplendixURL:verifyPhoneURL andParameters:verifyPhoneParameters completionHandler:^(NSDictionary * responseJSON) {
        if([responseJSON[@"error"] isEqualToString:@"ok"]){
            NSMutableDictionary * signupParameters = [@{
                                                       @"phone": self.phoneText.text,
                                                       @"password": self.passwordText.text
                                                       }mutableCopy];
            GRARegisterSecondViewController * register2 = [[GRARegisterSecondViewController alloc]initWithSignupParameters:signupParameters];
            [self.navigationController showViewController:register2 sender:self];
        } else if ([responseJSON[@"error"] isEqualToString:@"verify:failed"]) {
            NSLog(@"验证手机：失败！");
        }
    }];
}

- (void)timeCount{
    _timeCount--;
    if (_timeCount <= 0) {
        [_timer invalidate];
        [self.resendButton setAttributedTitle:[[NSAttributedString alloc]initWithString:@"重新发送" attributes:_resendButtonAttributedTitle] forState:UIControlStateNormal];
        self.resendButton.userInteractionEnabled = YES;
    } else {
        self.resendButton.titleLabel.text = [NSString stringWithFormat:@"重新发送(%lds)", (long)_timeCount];
        [UIView performWithoutAnimation:^{
            [self.resendButton setAttributedTitle:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"重新发送(%lds)", (long)_timeCount] attributes:_resendButtonAttributedTitle] forState:UIControlStateNormal];
            [self.resendButton.layer layoutIfNeeded];
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.phoneText resignFirstResponder];
    [self.passwordText resignFirstResponder];
    [self.verificationText resignFirstResponder];
}

#pragma mark UITextField代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isEqual:self.phoneText]){
        [self.phoneText resignFirstResponder];
        [self.passwordText becomeFirstResponder];
    } else if ([textField isEqual:self.passwordText]){
        [self.passwordText resignFirstResponder];
    } else if ([textField isEqual:self.verificationText]){
        [self.verificationText resignFirstResponder];
    }
    return YES;
}
#pragma mark 懒加载方法群
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
        _passwordText.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入不少于6位的密码" attributes:@{NSForegroundColorAttributeName: [UIColor textWhiteColor]}];
        _passwordText.font = [UIFont systemFontOfSize:13.0];
        _passwordText.textColor = [UIColor textWhiteColor2];
        _passwordText.tintColor = [UIColor textWhiteColor2];
        _passwordText.textAlignment = NSTextAlignmentCenter;
        _passwordText.clearsOnBeginEditing = YES;
        [self.passwordBackground addSubview:_passwordText];
    }
    return _passwordText;
}

- (UITextField *)verificationText {
    if (!_verificationText) {
        _verificationText = [[UITextField alloc]init];
        _verificationText.delegate = self;
        _verificationText.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName: [UIColor textWhiteColor]}];
        _verificationText.font = [UIFont systemFontOfSize:13.0];
        _verificationText.textColor = [UIColor textWhiteColor2];
        _verificationText.tintColor = [UIColor textWhiteColor2];
        _verificationText.textAlignment = NSTextAlignmentCenter;
        _verificationText.backgroundColor = [UIColor transparentWhiteColor];
        _verificationText.layer.cornerRadius = 5.0;
        _verificationText.layer.masksToBounds = YES;
        [self.view addSubview: _verificationText];
    }
    return _verificationText;
}

- (UIButton *)resendButton {
    if (!_resendButton) {
        _resendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_resendButton setAttributedTitle:[[NSAttributedString alloc]initWithString:@"发送验证码" attributes:_resendButtonAttributedTitle] forState:UIControlStateNormal];
        _resendButton.backgroundColor = [UIColor transparentWhiteColor];
        _resendButton.layer.cornerRadius = 5.0;
        _resendButton.layer.masksToBounds = YES;
        [self.view addSubview:_resendButton];
    }
    return _resendButton;
}

- (UIBarButtonItem *)nextButton {
    if (!_nextButton) {
        _nextButton = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(nextStep)];
    }
    return _nextButton;
}
@end
