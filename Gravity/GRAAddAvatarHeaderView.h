//
//  GRAAddAvatarHeaderView.h
//  Gravity
//
//  Created by 陈志浩 on 16/6/9.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRAAddAvatarHeaderView : UIView
@property (nonatomic, strong) UIImage * avatar;
- (void)addTarget:(id)target action:(SEL)sel forControlEvents:(UIControlEvents)controlEvents;
@end
