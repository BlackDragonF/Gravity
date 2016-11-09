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
static NSString * const mainURL = @"http://115.159.24.113:8099";
static NSString * const uploadLocationURL = @"/backend/api/user/position";
static NSString * const verifyPhoneURL = @"/backend/api/user/verify_phone";
static NSString * const loginURL = @"/backend/api/user/signin";
static NSString * const passwordSMSURL = @"/backend/api/user/password_sms";
static NSString * const passwordURL = @"/backend/api/user/password";
static NSString * const signupSMSURL = @"/backend/api/user/signup_sms";
static NSString * const uploadAvatarURL = @"/backend/api/misc/avatar";
static NSString * const signupURL = @"/backend/api/user/signup";

#pragma mark 基本配置
+ (instancetype)sharedManager{
    static GRANetworkingManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GRANetworkingManager alloc]init];
    });
    return manager;
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

- (AFJSONRequestSerializer *)requestSerializer{
    if(!_requestSerializer){
        _requestSerializer = [AFJSONRequestSerializer serializer];
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
- (void)uploadLocation:(NSDictionary *)locationJSON withCompletionHandler:(responseBlock)handler {
    _baseURL = [mainURL stringByAppendingString:uploadLocationURL];
    [self.sessionManager POST:_baseURL parameters:locationJSON progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (handler) handler((NSDictionary *)responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"地理位置上传失败:%@", [error localizedDescription]);
    }];
}

- (void)verifyPhone:(NSDictionary *)phoneInfo withCompletionHandler:(responseBlock)handler {
    _baseURL = [mainURL stringByAppendingString:verifyPhoneURL];
    [self.sessionManager POST:_baseURL parameters:phoneInfo progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (handler) handler((NSDictionary *)responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"认证手机失败:%@", [error localizedDescription]);
    }];
}

- (void)requestLogin:(NSDictionary *)userInfo withCompletionHandler:(responseBlock)handler {
    _baseURL = [mainURL stringByAppendingString:loginURL];
    [self.sessionManager POST:_baseURL parameters:userInfo progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (handler) handler((NSDictionary *)responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"登录失败:%@", [error localizedDescription]);
    }];
}

- (void)sendRetrievePasswordSMS:(NSDictionary *)phoneInfo withCompletionHandler:(responseBlock)handler {
    _baseURL = [mainURL stringByAppendingString:passwordSMSURL];
    [self.sessionManager POST:_baseURL parameters:phoneInfo progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (handler) handler((NSDictionary *)responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"发送重置密码短信失败:%@",[error localizedDescription]);
    }];
}

- (void)retrievePassword:(NSDictionary *)passwordInfo withCompletionHandler:(responseBlock)handler {
    _baseURL = [mainURL stringByAppendingString:passwordURL];
    [self.sessionManager POST:_baseURL parameters:passwordInfo progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (handler) handler((NSDictionary *)responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"重置密码失败:%@", [error localizedDescription]);
    }];
}

- (void)sendRegisterSMS:(NSDictionary *)phoneInfo withCompletionHandler:(responseBlock)handler {
    _baseURL = [mainURL stringByAppendingString:signupSMSURL];
    [self.sessionManager POST:_baseURL parameters:phoneInfo progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (handler) handler((NSDictionary *)responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"发送注册短信失败:%@", [error localizedDescription]);
    }];
}

- (void)uploadAvatar:(UIImage *)avatar forUser:(NSInteger)userID withCompletionHandler:(responseBlock)handler{
    _baseURL = [mainURL stringByAppendingString:uploadAvatarURL];
    NSString * fileName = [NSString stringWithFormat:@"avatar-%ld-%ld.png", (long)userID, (long)[[NSDate date] timeIntervalSince1970]];
    [self.sessionManager POST:_baseURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFormData:[fileName dataUsingEncoding:NSUTF8StringEncoding] name:@"filename"];
        //        [formData appendPartWithFileData:UIImagePNGRepresentation(avatar) name:@"file" fileName:fileName mimeType:@"image/png"];
        [formData appendPartWithFormData:UIImagePNGRepresentation(avatar) name:@"file"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (handler) handler((NSDictionary *)responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

- (void)requestRegister:(NSDictionary *)userInfo withCompletionHandler:(responseBlock)handler {
    _baseURL = [mainURL stringByAppendingString:signupURL];
    [self.sessionManager POST:_baseURL parameters:userInfo progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (handler) handler((NSDictionary *)responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"注册失败:%@",  [error localizedDescription]);
    }];
}
@end
