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
@property (nonatomic, strong) AFHTTPRequestSerializer * requestSerializer;
@property (nonatomic, strong) AFJSONResponseSerializer * responseSerializer;

+ (instancetype)sharedManager;
- (void)requestWithApplendixURL:(NSString *)url
                  andParameters:(NSDictionary *)parameters
              completionHandler:(responseBlock)handler;

- (void)uploadAvatar:(UIImage *)avatar
             forUser:(NSInteger)userID;

@end
