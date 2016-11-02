//
//  GRAOthersWantToTalkCell.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/12.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAOthersWantToTalkCell.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRAOthersWantToTalkCell() {
    NSDictionary * _textAttribute;
}
@property (nonatomic, strong) UILabel * contentLabel;
@end

@implementation GRAOthersWantToTalkCell
#pragma mark 初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self addTextAttribute];
        [self addConstraints];
    }
    return self;
}
#pragma mark 基本配置
- (void)addTextAttribute {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 12.0f;
    _textAttribute = @{NSForegroundColorAttributeName: [UIColor textWhiteColor2], NSFontAttributeName: [UIFont systemFontOfSize:13.0f],NSParagraphStyleAttributeName: paragraphStyle};
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
#pragma mark set方法群
- (void)setContent:(NSString *)content{
    _content = content;
    [self.contentLabel setAttributedText:[[NSAttributedString alloc]initWithString: _content attributes:_textAttribute]];
}
#pragma mark 懒加载方法群
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor textWhiteColor2];
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}
@end
