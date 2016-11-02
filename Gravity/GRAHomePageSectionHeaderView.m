//
//  GRAHomePageSectionHeaderView.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/7.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAHomePageSectionHeaderView.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRAHomePageSectionHeaderView()
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) UILabel * titleLabel;
@end

@implementation GRAHomePageSectionHeaderView
#pragma mark 初始化方法
- (instancetype)initWithTitle:(NSString *)title Frame:(CGRect)frame andPadding:(UIEdgeInsets)padding {
    if (self = [super initWithFrame:frame]) {
        _title = title;
        _padding = padding;
        [self addConstraints];
    }
    return self;
}
#pragma mark UI配置
- (void)addConstraints {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(self.padding);
    }];
}
#pragma mark set方法群
- (void)setTitle:(NSString *)title {
    _title = title;
    [self.titleLabel setText:_title];
}

- (void)setPadding:(UIEdgeInsets)padding {
    _padding = padding;
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(_padding);
    }];
}

- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
    _titleLabel.font = [UIFont systemFontOfSize:_fontSize];
}
#pragma mark 懒加载方法群
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = self.title;
        _titleLabel.textColor = [UIColor textGreenColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
@end
