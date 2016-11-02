//
//  GRANetworkingManager.m
//  Gravity
//
//  Created by 陈志浩 on 16/5/22.
//  Copyright © 2016年 BingyanStudio. All rights reserved.
//

#import "GRANetworkingManager.h"

@interface GRANetworkingManager()
@property (nonatomic, strong)NSString * baseURL;
@end

@implementation GRANetworkingManager
static NSString * mainURL = @"http://115.159.24.113:8099";
static NSString * uploadAvatarURL = @"/backend/api/misc/avatar";
#pragma mark 基本配置
+ (instancetype)sharedManager{
    static GRANetworkingManager * instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[GRANetworkingManager alloc]init];
    });
    return instance;
}

- (void)requestWithApplendixURL:(NSString *)url andParameters:(NSDictionary *)parameters completionHandler:(responseBlock)handler {
    _baseURL = [mainURL stringByAppendingString:url];
    [self.sessionManager POST:_baseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        NSLog(@"%@", responseObject);
        if (handler)
            handler((NSDictionary *)responseObject);
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

- (AFHTTPSessionManager *)sessionManager{
    if (!_sessionManager){
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer = self.requestSerializer;
        _sessionManager.responseSerializer = self.responseSerializer;
    }
    return _sessionManager;
}

- (AFHTTPRequestSerializer *)requestSerializer{
    if(!_requestSerializer){
        _requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    return _requestSerializer;
}

- (AFJSONResponseSerializer *)responseSerializer{
    if (!_responseSerializer){
        _responseSerializer = [AFJSONResponseSerializer serializer];
        _responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    }
    return _responseSerializer;
}
#pragma mark 具体功能
- (void)uploadAvatar:(UIImage *)avatar forUser:(NSInteger)userID{
     _baseURL = [mainURL stringByAppendingString:uploadAvatarURL];
    NSString * fileName = [NSString stringWithFormat:@"avatar-%ld-%ld.png", (long)userID, (long)[[NSDate date] timeIntervalSince1970]];
    [self.sessionManager POST:_baseURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFormData:[fileName dataUsingEncoding:NSUTF8StringEncoding] name:@"filename"];
//        [formData appendPartWithFileData:UIImagePNGRepresentation(avatar) name:@"file" fileName:fileName mimeType:@"image/png"];
        [formData appendPartWithFormData:UIImagePNGRepresentation(avatar) name:@"file"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

@end
