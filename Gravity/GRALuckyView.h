//
//  GRALuckyView.h
//  Gravity
//
//  Created by 陈志浩 on 16/7/11.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRALuckyView : UIView
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic) NSInteger lucky;
- (instancetype)initWithLucky:(NSInteger)lucky;
@end
