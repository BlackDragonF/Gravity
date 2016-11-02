//
//  GRARegisterSectionHeaderView.m
//  Gravity
//
//  Created by 陈志浩 on 16/6/9.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRARegisterSectionHeaderView.h"
#import "ColorMacro.h"
#import "Masonry.h"

@implementation GRARegisterSectionHeaderView
- (instancetype)initWithSectionTitle:(NSString *)title {
    if (self = [super init]) {
        self.sectionTitle = title;
    }
    return self;
}

- (void)setSectionTitle:(NSString *)sectionTitle {
    _sectionTitle = sectionTitle;
    self.sectionTitleLabel.text = sectionTitle;
}

- (UILabel *)sectionTitleLabel {
    if (!_sectionTitleLabel) {
        _sectionTitleLabel = [[UILabel alloc]init];
        _sectionTitleLabel.textColor = [UIColor textGreenColor];
        _sectionTitleLabel.textAlignment = NSTextAlignmentLeft;
        _sectionTitleLabel.font = [UIFont systemFontOfSize:13.0];
        _isFourthViewController = NO;
        [self addSubview:_sectionTitleLabel];
        [_sectionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left).with.offset(15);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(@13);
        }];
    }
    return _sectionTitleLabel;
}

- (void)setIsFourthViewController:(BOOL)isFourthViewController {
    _isFourthViewController = isFourthViewController;
    if (isFourthViewController) {
        [self.sectionTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(33);
            make.left.equalTo(self.mas_left).with.offset(15);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(@13);
        }];
    } else {
        [self.sectionTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left).with.offset(15);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(@13);
        }];
    }
}
@end
