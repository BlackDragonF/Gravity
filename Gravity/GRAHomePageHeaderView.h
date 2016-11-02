//
//  HomepageHeaderView.h
//  Gravity
//
//  Created by 陈志浩 on 16/4/12.
//  Copyright © 2016年 UniqueStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRAHomePageHeaderView : UIView

typedef NS_ENUM(NSInteger, Gender) {
    Man,
    Woman,
};
@property (nonatomic, strong) UIView * contentView;

@property (nonatomic, strong) UIImage * avatar;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic) Gender gender;
@property (nonatomic, strong) NSString * location;

- (instancetype)initWithAvatar:(UIImage *)avatar
                      Nickname:(NSString *)nickname
                        Gender:(Gender)gender
                      andLocation:(NSString *)location;

//全能初始化方法
- (void)addTargetToButton:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
