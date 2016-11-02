//
//  GRASignatureTextView.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/7.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRASignatureTextView.h"

#import "ColorMacro.h"

@interface GRASignatureTextView()<UITextViewDelegate> {
    BOOL _hasPlaceholder;
}
@property (nonatomic, strong) NSDictionary * placeholderAttributes;
@property (nonatomic, strong) NSDictionary * textAttributes;
@end

@implementation GRASignatureTextView
- (instancetype)init {
    if (self = [super init]) {
        [self attributeConfiguration];
        _hasPlaceholder = NO;
        _maxLength = 30;
        self.delegate = self;
    }
    return self;
}

- (void)attributeConfiguration {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 15.0;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    _placeholderAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0], NSForegroundColorAttributeName:[UIColor textWhiteColor], NSParagraphStyleAttributeName:paragraphStyle};
    _textAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0], NSForegroundColorAttributeName:[UIColor textWhiteColor2], NSParagraphStyleAttributeName:paragraphStyle};
}
#pragma mark set方法群
- (void)setText:(NSString *)text {
    [self setAttributedText:[[NSAttributedString alloc]initWithString:text attributes:_textAttributes]];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    _hasPlaceholder = YES;
    [self setAttributedText:[[NSAttributedString alloc]initWithString:_placeholder attributes:_placeholderAttributes]];
}
#pragma mark 代理方法
- (CGRect)caretRectForPosition:(UITextPosition *)position {
    CGRect originalRect = [super caretRectForPosition:position];
    originalRect.size.height = 18.0;
    return originalRect;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (_hasPlaceholder == YES) {
        [self setAttributedText:[[NSAttributedString alloc]initWithString:@"\0" attributes:_textAttributes]];
        [self setAttributedText:[[NSAttributedString alloc]init]];
//        [self setAttributedText:[[NSAttributedString alloc]initWithString:[NSString string] attributes:_textAttributes]];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSInteger mixedLength = [self getMixedLength:textView.attributedText.string] + [self getMixedLength:text] - [self getMixedLength:[textView.attributedText.string substringWithRange:range]];
    if (mixedLength > 2 * self.maxLength) {
        return NO;
    } else {
        self.characterUpdate(self.maxLength - mixedLength / 2);
        return YES;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.attributedText.length == 0) {
        [self setAttributedText:[[NSAttributedString alloc]initWithString:_placeholder attributes:_placeholderAttributes]];
        _hasPlaceholder = YES;
    } else {
        _hasPlaceholder = NO;
    }
}
#pragma mark 字符长度判断
- (int)getMixedLength:(NSString*)string
{
    int strlength = 0;
    char * strPtr = (char*)[string cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int count = 0 ; count < [string lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ; count++) {
        if (*strPtr) {
            strPtr++;
            strlength++;
        }
        else {
            strPtr++;
        }
    }
    return strlength;
}
@end
