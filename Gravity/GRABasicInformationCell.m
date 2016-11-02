//
//  GRABasicInformationCell.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/7.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRABasicInformationCell.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRABasicInformationCell()
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIImageView * arrowView;
@property (nonatomic, strong) CAShapeLayer * separatorLayer;
@end

@implementation GRABasicInformationCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor transparentWhiteColor]];
        [self addConstraints];
    }
    return self;
}
#pragma mark UI配置
- (void)addConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(30);
        make.top.equalTo(self.contentView).with.offset(15);
        make.bottom.equalTo(self.contentView).with.offset(-15);
        make.height.mas_equalTo(@14);
    }];
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-12);
        make.top.equalTo(self.contentView).with.offset(15);
        make.width.mas_equalTo(@10);
        make.height.mas_equalTo(@17);
    }];
}
#pragma mark set方法群
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = _title;
}

- (void)setContent:(NSString *)content {
    _content = content;
    switch (_interactionType) {
        case GRAInteractionTextType:
            self.contentText.text = _content;
            break;
        case GRAInteractionPickerType:
            self.contentLabel.text = _content;
            break;
    }
}

- (void)setInteractionType:(GRAInteractionType)interactionType {
    _interactionType = interactionType;
    switch (_interactionType) {
        case GRAInteractionTextType:
        {
            [self.contentText mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView.mas_left).with.offset(103);
                make.centerY.equalTo(self.titleLabel.mas_centerY);
                make.height.mas_equalTo(@13);
            }];
            break;
        }
        case GRAInteractionPickerType:
        {
            [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView.mas_left).with.offset(103);
                make.centerY.equalTo(self.titleLabel.mas_centerY);
                make.height.mas_equalTo(@13);
            }];
            break;
        }
    }
}

- (void)setSeparator:(BOOL)separator{
    _separator = separator;
    if (_separator){
        [self.contentView.layer addSublayer:self.separatorLayer];
    } else {
        [self.separatorLayer removeFromSuperlayer];
    }
}
#pragma mark 懒加载方法群
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor textWhiteColor2];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UITextField *)contentText {
    if (!_contentText) {
        _contentText = [[UITextField alloc]init];
        _contentText.textColor = [UIColor textWhiteColor];
        _contentText.textAlignment = NSTextAlignmentLeft;
        _contentText.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_contentText];
    }
    return _contentText;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = [UIColor textWhiteColor];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UIImageView *)arrowView {
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
        [self.contentView addSubview:_arrowView];
    }
    return _arrowView;
}

- (CAShapeLayer *)separatorLayer{
    if (!_separatorLayer){
        _separatorLayer = [CAShapeLayer layer];
        CGMutablePathRef separatorShapePath = CGPathCreateMutable();
        [_separatorLayer setFillColor:[UIColor clearColor].CGColor];
        [_separatorLayer setStrokeColor:[UIColor separatorPurpleColor].CGColor];
        _separatorLayer.lineWidth = 0.5f;
        CGPathMoveToPoint(separatorShapePath, NULL, 0.0f, 45.0f);
        CGPathAddLineToPoint(separatorShapePath, NULL, 375.0f, 45.0f);
        [_separatorLayer setPath:separatorShapePath];
        CGPathRelease(separatorShapePath);
        [self.contentView.layer addSublayer:_separatorLayer];
    }
    return _separatorLayer;
}
@end
