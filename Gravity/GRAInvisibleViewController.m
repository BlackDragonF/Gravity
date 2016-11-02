//
//  GRAInvisibleViewController.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/13.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAInvisibleViewController.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRAInvisibleViewController()
@property (nonatomic, strong) UILabel * titleLabel;
@end

@implementation GRAInvisibleViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark UI配置
- (void)addConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(15);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.height.mas_equalTo(@12);
    }];
}
#pragma mark 懒加载方法群
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"相遇不提醒";
        _titleLabel.textColor = [UIColor textGreenColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:12.0];
        [self.view addSubview:_titleLabel];
    }
    return _titleLabel;
}
@end
