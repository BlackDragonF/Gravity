//
//  GRACardPageHeaderView.h
//  Gravity
//
//  Created by 陈志浩 on 16/7/11.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRACardPageHeaderView : UIView
typedef NS_ENUM(NSInteger, Gender) {
    Man,
    Woman,
};

@property (nonatomic, strong) UIView * contentView;

@property (nonatomic, strong) NSString * date;
@property (nonatomic, strong) UIImage * avatar;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic) Gender gender;
@property (nonatomic, strong) NSString * location;

- (instancetype)initWithDate:(NSString *)date
                      Avatar:(UIImage *)avatar
                      Nickname:(NSString *)nickname
                        Gender:(Gender)gender
                   andLocation:(NSString *)location;
@end
