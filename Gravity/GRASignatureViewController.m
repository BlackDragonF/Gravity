//
//  GRASignatureViewController.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/7.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRASignatureViewController.h"
#import "GRAHomePageSectionHeaderView.h"
#import "GRASignatureTextView.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRASignatureViewController()<UITextViewDelegate>
@property (nonatomic, strong) GRAHomePageSectionHeaderView * sectionHeaderView;
@property (nonatomic, strong) GRASignatureTextView * signatureView;
@property (nonatomic, strong) UILabel * hintLabel;
@property (nonatomic, strong) UIBarButtonItem * backButton;
@property (nonatomic, strong) UIBarButtonItem * saveButton;
@end

@implementation GRASignatureViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicConfiguration];
    [self addConstraints];
    [self addNavigationItems];
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
    [self setTitle:@"个性签名"];
}
#pragma markUI配置
- (void)addConstraints {
    [self.signatureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sectionHeaderView.mas_bottom);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.height.mas_equalTo(@100);
    }];
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.signatureView.mas_bottom).with.offset(12);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.height.mas_equalTo(@13);
    }];
}

- (void)addNavigationItems {
    UIBarButtonItem * negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -4.0;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, self.backButton];
    UIBarButtonItem * negativeSpacer2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer2.width = 4.0;
    self.navigationItem.rightBarButtonItems = @[self.saveButton, negativeSpacer2];
}
#pragma mark 交互相关
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.signatureView resignFirstResponder];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)save {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 懒加载方法群
- (GRAHomePageSectionHeaderView *)sectionHeaderView {
    if (!_sectionHeaderView) {
        _sectionHeaderView = [[GRAHomePageSectionHeaderView alloc]initWithTitle:@"我来说给你听"
                                                                          Frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 48)
                                                                     andPadding:UIEdgeInsetsMake(20, 15, 15, 0)];
        _sectionHeaderView.fontSize = 13.0;
        [self.view addSubview:_sectionHeaderView];
    }
    return _sectionHeaderView;
}

- (UITextView *)signatureView {
    if (!_signatureView) {
        __weak GRASignatureViewController * weakSelf = self;
        _signatureView = [[GRASignatureTextView alloc]init];
        _signatureView.placeholder = @"Hey~你在这里想遇见什么？";
        _signatureView.tintColor = [UIColor textWhiteColor2];
        _signatureView.textContainerInset = UIEdgeInsetsMake(19, 10, 0, 10);
        _signatureView.autocorrectionType = UITextAutocorrectionTypeNo;
        _signatureView.backgroundColor = [UIColor transparentWhiteColor];
        _signatureView.characterUpdate = ^(NSInteger leftCount) {
            weakSelf.hintLabel.text = [NSString stringWithFormat:@"可输入%ld个字", (long)leftCount];
        };
        [self.view addSubview:_signatureView];
    }
    return _signatureView;
}

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc]init];
        _hintLabel.text = @"可输入30个字";
        _hintLabel.textColor = [UIColor textWhiteColor];
        _hintLabel.textAlignment = NSTextAlignmentRight;
        _hintLabel.font = [UIFont systemFontOfSize:13.0];
        [self.view addSubview:_hintLabel];
    }
    return _hintLabel;
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

- (UIBarButtonItem *)saveButton {
    if (!_saveButton) {
        _saveButton = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    }
    return _saveButton;
}
@end
