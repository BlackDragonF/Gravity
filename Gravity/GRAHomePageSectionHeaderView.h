//
//  GRAHomePageSectionHeaderView.h
//  Gravity
//
//  Created by 陈志浩 on 16/7/7.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRAHomePageSectionHeaderView : UIView
@property (nonatomic, strong) NSString * title;
@property (nonatomic) CGFloat fontSize;
@property (nonatomic) UIEdgeInsets padding;
- (instancetype)initWithTitle:(NSString *)title
                        Frame:(CGRect)frame
                   andPadding:(UIEdgeInsets)padding;
@end
