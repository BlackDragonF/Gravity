//
//  GRAAppSettings.h
//  Gravity
//
//  Created by 陈志浩 on 2016/11/9.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRAAppSettings : NSObject
+ (instancetype)sharedSettings;

@property (nonatomic, getter=isLogin) BOOL login;
@property (nonatomic) NSInteger userID;
@end
