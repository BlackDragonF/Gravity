//
//  GRARegisterRestCell.m
//  Gravity
//
//  Created by 陈志浩 on 16/6/11.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRARegisterRestCell.h"
#import "ColorMacro.h"
#import "Masonry.h"

@interface GRARegisterRestCell()
@property (nonatomic, strong) CAShapeLayer * separatorLine;
@property (nonatomic, strong) UIImageView * arrowView;
@end

@implementation GRARegisterRestCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _hasSeparator = NO;
        _arrowed = NO;
    }
    return self;
}
#pragma mark 懒加载方法群
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor textWhiteColor2];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(15);
            make.left.equalTo(self.contentView.mas_left).with.offset(20);
            make.height.mas_equalTo(@13);
        }];
    }
    return _titleLabel;
}

- (CAShapeLayer *)separatorLine {
    if (!_separatorLine) {
        _separatorLine = [CAShapeLayer layer];
        CGMutablePathRef separatorLinePath = CGPathCreateMutable();
        [_separatorLine setFillColor:[UIColor clearColor].CGColor];
        [_separatorLine setStrokeColor:[UIColor separatorPurpleColor].CGColor];
        _separatorLine.lineWidth = 0.5;
        CGPathMoveToPoint(separatorLinePath, NULL, 0.0, 0.0);
        CGPathAddLineToPoint(separatorLinePath, NULL, 375.0, 0.0);
        [_separatorLine setPath:separatorLinePath];
        CGPathRelease(separatorLinePath);
    }
    return _separatorLine;
}

- (UIImageView *)arrowView {
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
        [self.contentView addSubview:_arrowView];
        [_arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(12);
            make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        }];
        _arrowView.hidden = YES;
    }
    return _arrowView;
}
#pragma mark set方法群
- (void)setHasSeparator:(BOOL)hasSeparator {
    _hasSeparator = hasSeparator;
    if (hasSeparator) {
        [self.layer addSublayer:self.separatorLine];
    } else {
        [self.separatorLine removeFromSuperlayer];
    }
}

- (void)setArrowed:(BOOL)arrowed {
    _arrowed = arrowed;
    if (_arrowed) {
        self.arrowView.hidden = NO;
    } else {
        self.arrowView.hidden = YES;
    }
}
@end
