//
//  GRANetworkingManager.h
//  Gravity
//
//  Created by 陈志浩 on 16/5/22.
//  Copyright © 2016年 BingyanStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void(^responseBlock)(NSDictionary *);

@interface GRANetworkingManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager * sessionManager;
@property (nonatomic, strong) AFJSONRequestSerializer * requestSerializer;
@property (nonatomic, strong) AFJSONResponseSerializer * responseSerializer;

+ (instancetype)sharedManager;

- (void)uploadLocation:(NSDictionary *)locationJSON withCompletionHandler:(responseBlock)handler;
- (void)verifyPhone:(NSDictionary *)phoneInfo withCompletionHandler:(responseBlock)handler;
- (void)requestLogin:(NSDictionary *)userInfo withCompletionHandler:(responseBlock)handler;
- (void)sendRetrievePasswordSMS:(NSDictionary *)phoneInfo withCompletionHandler:(responseBlock)handler;
- (void)retrievePassword:(NSDictionary *)passwordInfo withCompletionHandler:(responseBlock)handler;
- (void)sendRegisterSMS:(NSDictionary *)phoneInfo withCompletionHandler:(responseBlock)handler;
- (void)uploadAvatar:(UIImage *)avatar forUser:(NSInteger)userID withCompletionHandler:(responseBlock)handler;
- (void)requestRegister:(NSDictionary *)userInfo withCompletionHandler:(responseBlock)handler;
@end
