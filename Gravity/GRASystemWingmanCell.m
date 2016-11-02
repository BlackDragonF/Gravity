//
//  GRASystemWingmanCell.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/9.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRASystemWingmanCell.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRASystemWingmanCell() {
    NSDictionary * _textAttributes;
}
@property (nonatomic, strong)UITextView * textView;
@end

@implementation GRASystemWingmanCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self attributeConfiguration];
        [self addConstraints];
    }
    return self;
}
- (void)attributeConfiguration {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 1.25;
    paragraphStyle.paragraphSpacing = 5.0;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    _textAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0], NSForegroundColorAttributeName:[UIColor textWhiteColor2], NSParagraphStyleAttributeName:paragraphStyle};
}
#pragma mark UI配置
- (void)addConstraints {
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).with.offset(25);
        make.right.equalTo(self.contentView.mas_right).with.offset(-25);
//        make.height.mas_equalTo([NSNumber numberWithDouble:self.textView.contentSize.height]);
//        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(25, 0, 25, 0));
    }];
}
#pragma mark set方法群
- (void)setText:(NSString *)text {
    _text = text;
    [self.textView setAttributedText:[[NSAttributedString alloc]initWithString:_text attributes:_textAttributes]];
}
#pragma mark 懒加载方法群
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.editable = NO;
        _textView.selectable = NO;
        _textView.scrollEnabled = NO;
        _textView.backgroundColor = [UIColor transparentWhiteColor];
        _textView.textContainerInset = UIEdgeInsetsMake(19, 5, 19, 5);
        [self.contentView addSubview:_textView];
    }
    return _textView;
}
@end
