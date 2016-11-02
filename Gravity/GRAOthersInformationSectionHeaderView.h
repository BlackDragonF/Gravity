//
//  GRAOthersInformationSectionHeaderView.h
//  Gravity
//
//  Created by 陈志浩 on 16/7/13.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRAOthersInformationSectionHeaderView : UIView
@property (nonatomic, strong) UIView * contentView;

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) UIImage * icon;

- (instancetype)initWithIcon:(UIImage *)icon
                    andTitle:(NSString *)title;
@end
