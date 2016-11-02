//
//  GRAAvatarEditerController.h
//  AvatarPicker
//
//  Created by 陈志浩 on 16/7/4.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRAAvatarEditerController : UIViewController
typedef void(^getAvatarBlock)(UIImage * avatar);
@property (nonatomic, copy) getAvatarBlock getAvatar;
- (instancetype)initWithImage:(UIImage *)image;
@end
