//
//  GRARegisterSectionHeaderView.h
//  Gravity
//
//  Created by 陈志浩 on 16/6/9.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRARegisterSectionHeaderView : UIView
@property (nonatomic, strong) NSString * sectionTitle;
@property (nonatomic, strong) UILabel * sectionTitleLabel;
@property (nonatomic) BOOL isFourthViewController;
- (instancetype)initWithSectionTitle:(NSString *)title;
@end
