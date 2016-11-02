//
//  GRAOthersInterestsCell.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/12.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAOthersInterestsCell.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRAOthersInterestsCell()
@property (nonatomic, strong) UILabel * contentLabel;
@end

@implementation GRAOthersInterestsCell
#pragma mark 初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self addConstraints];
    }
    return self;
}
#pragma mark UI配置
- (void)addConstraints {
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(54);
        make.top.equalTo(self.contentView.mas_top).with.offset(7.5);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right);
    }];
}
#pragma mark set方法
- (void)setAttributedContent:(NSAttributedString *)attributedContent{
    _attributedContent = attributedContent;
    [self.contentLabel setAttributedText:_attributedContent];
}
#pragma mark 懒加载方法
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = [UIColor textWhiteColor2];
        _contentLabel.font = [UIFont systemFontOfSize:13.0];
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}
@end
