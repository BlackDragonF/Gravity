//
//  HomepageCell.m
//  Gravity
//
//  Created by 陈志浩 on 16/4/12.
//  Copyright © 2016年 UniqueStudio. All rights reserved.
//
#import "GRAHomePageCell.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRAHomePageCell()
@property (nonatomic, strong) UIImageView * iconView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * subtitleLabel;
@property (nonatomic, strong) UIImageView * arrowView;
@property (nonatomic, strong) CAShapeLayer * separatorLayer;
@end

@implementation GRAHomePageCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark 初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setBackgroundColor:[UIColor transparentWhiteColor]];
        _arrowed = NO;
        [self addConstraints];
    }
    return self;
}

#pragma mark UI配置
- (void)addConstraints {
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(15);
        make.right.equalTo(self.titleLabel.mas_left).with.offset(-30);
        make.width.mas_equalTo(@29);
        make.top.equalTo(self.contentView.mas_top).with.offset(7.5);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-7.5);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_top).with.offset(7.5);
        make.bottom.equalTo(self.iconView.mas_bottom).with.offset(-7.5);
        make.width.equalTo(self.subtitleLabel.mas_width);
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        make.centerY.equalTo(self.titleLabel.mas_centerY);
    }];
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.height.mas_equalTo(@17.5);
        make.width.mas_equalTo(@11);
    }];
}

#pragma mark set方法群
- (void)setIcon:(UIImage *)icon{
    _icon = icon;
    [self.iconView setImage:_icon];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    [self.titleLabel setText:_title];
}

- (void)setSubtitle:(NSString *)subtitle{
    _subtitle = subtitle;
    [self.subtitleLabel setText:_subtitle];
}

- (void)setArrowed:(BOOL)arrowed{
    _arrowed = arrowed;
    //根据是否有箭头重新布局
    if (_arrowed){
        [self.arrowView setHidden:NO];
        [self.subtitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.arrowView.mas_left).with.offset(-10);
            make.centerY.equalTo(self.titleLabel.mas_centerY);
        }];
    } else {
        [self.arrowView setHidden:YES];
        [self.subtitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).with.offset(-15);
            make.centerY.equalTo(self.titleLabel.mas_centerY);
        }];
    }
}

- (void)setHighlightedSubtitle:(BOOL)highlightedSubtitle{
    _highlightedSubtitle = highlightedSubtitle;
    if (_highlightedSubtitle){
        [self.subtitleLabel setTextColor:[UIColor textGreenColor]];
    } else {
        [self.subtitleLabel setTextColor:[UIColor textWhiteColor]];
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
- (CAShapeLayer *)separatorLayer{
    if (!_separatorLayer){
        _separatorLayer = [CAShapeLayer layer];
        CGMutablePathRef separatorShapePath = CGPathCreateMutable();
        [_separatorLayer setFillColor:[UIColor clearColor].CGColor];
        [_separatorLayer setStrokeColor:[UIColor separatorPurpleColor].CGColor];
        _separatorLayer.lineWidth = 0.5f;
        CGPathMoveToPoint(separatorShapePath, NULL, 74.0f, 45.0f);
        CGPathAddLineToPoint(separatorShapePath, NULL, 364.0f, 45.0f);
        [_separatorLayer setPath:separatorShapePath];
        CGPathRelease(separatorShapePath);
        [self.contentView.layer addSublayer:_separatorLayer];
    }
    return _separatorLayer;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        [self.contentView addSubview:_iconView];
    }
    return _iconView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_titleLabel setTextColor:[UIColor textWhiteColor2]];
        [_titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc]init];
        [_subtitleLabel setTextAlignment:NSTextAlignmentRight];
        [_subtitleLabel setTextColor:[UIColor grayColor]];
        [_subtitleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self.contentView addSubview:_subtitleLabel];
    }
    return _subtitleLabel;
}

- (UIImageView *)arrowView {
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
        [_arrowView setHidden:YES];
        [self.contentView addSubview:_arrowView];
    }
    return _arrowView;
}
@end
