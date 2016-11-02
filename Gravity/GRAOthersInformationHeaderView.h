//
//  GRAOthersInformationHeaderView.h
//  Gravity
//
//  Created by 陈志浩 on 16/7/12.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRAOthersInformationHeaderView : UIView
typedef NS_ENUM(NSInteger, Gender) {
    Man,
    Woman,
};
@property (nonatomic, strong) UIView * contentView;

@property (nonatomic, strong) UIImage * avatar;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic) Gender gender;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, strong) NSString * contact;

- (instancetype)initWithAvatar:(UIImage *)avatar
                      NickName:(NSString *)nickname
                        Gender:(Gender)gender
                      Location:(NSString *)location
                    andContact:(NSString *)contact;

@end
