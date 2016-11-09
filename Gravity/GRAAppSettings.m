//
//  GRAAppSettings.m
//  Gravity
//
//  Created by 陈志浩 on 2016/11/9.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAAppSettings.h"

#import "GRALocationManager.h"

static NSString * const kLoginKey = @"login";
static NSString * const kUserIDKey = @"userID";

@interface GRAAppSettings()
@property (nonatomic, strong) NSUserDefaults * userDefaults;
@end

@implementation GRAAppSettings

@synthesize login = _login;
@synthesize userID = _userID;

+ (instancetype)sharedSettings {
    static GRAAppSettings * settings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settings = [[GRAAppSettings alloc] init];
    });
    return settings;
}

- (instancetype)init {
    if (self = [super init]) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
        
        [_userDefaults registerDefaults:@{
                                         kLoginKey:@NO,
                                         kUserIDKey:@0}];
        
        _login = [_userDefaults boolForKey:kLoginKey];
        _userID = [_userDefaults integerForKey:kUserIDKey];
    }
    return self;
}

- (void)setLogin:(BOOL)login {
    _login = login;
    [self.userDefaults setBool:_login forKey:kLoginKey];
    if (_login) {
        [[GRALocationManager sharedManager] setLocationMode:GRALocationForegroundMode];
    } else {
        [[GRALocationManager sharedManager] setLocationMode:GRALocationDefaultMode];
    }
}

- (BOOL)isLogin {
    return _login;
}

- (void)setUserID:(NSInteger)userID {
    _userID = userID;
    [self.userDefaults setInteger:_userID forKey:kUserIDKey];
}

- (NSInteger)userID {
    return _userID;
}
@end
