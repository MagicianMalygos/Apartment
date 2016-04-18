//
//  ZCPRequestManager+Login.m
//  Apartment
//
//  Created by apple on 16/4/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestManager+Login.h"
#import "ZCPRequestResponseTranslator.h"

@implementation ZCPRequestManager (Login)

/**
 *  用户登录验证
 *
 *  @param account  账号
 *  @param password 密码
 */
- (NSOperation *)loginWithAccount:(NSString *)account
                         password:(NSString *)password
                          success:(void (^)(AFHTTPRequestOperation *operation, NSString *msg, ZCPUserModel *userModel))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(LOGIN);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"account": account
                                                     , @"password": [password md5]}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               NSInteger code = [responseObject[@"code"] integerValue];
                                               NSString *msg = responseObject[@"msg"];
                                               // 如果登录成功
                                               if (code == 0) {
                                                   // 转换返回的用户模型
                                                   ZCPUserModel *userModel = [ZCPRequestResponseTranslator translateResponse_UserModel:responseObject[@"aUser"]];
                                                   success(operation, msg, userModel);
                                               } else {
                                                   success(operation, msg, nil);
                                               }
                                           }
                                           failure:failure];
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  判断当前账号是否可以注册
 *
 *  @param account  账号
 */
- (NSOperation *)JudgeAccountCanBeRegisterWithAccount:(NSString *)account
                                              success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess, NSString *msg))success
                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(ACCOUNT_CAN_BE_REGISTER);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"account": account}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               success(operation, [responseObject[@"result"] boolValue], responseObject[@"msg"]);
                                           }
                                           failure:failure];
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  用户注册
 *
 *  @param userName 用户名
 *  @param account  账号
 *  @param password 密码
 */
- (NSOperation *)registerWithUserName:(NSString *)userName
                              account:(NSString *)account
                             password:(NSString *)password
                              success:(void (^)(AFHTTPRequestOperation *operation, NSString *msg, ZCPUserModel *userModel))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(REGISTER);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"userName": userName
                                                     , @"account": account
                                                     , @"password": [password md5]}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               NSInteger code = [responseObject[@"code"] integerValue];
                                               NSString *msg = responseObject[@"msg"];
                                               // 如果登录成功
                                               if (code == 0) {
                                                   // 转换返回的用户模型
                                                   ZCPUserModel *userModel = [ZCPRequestResponseTranslator translateResponse_UserModel:responseObject[@"aUser"]];
                                                   success(operation, msg, userModel);
                                               } else {
                                                   success(operation, msg, nil);
                                               }
                                           }
                                           failure:failure];
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  重设密码
 *
 *  @param newPassword 新密码
 *  @param account     账号
 */
- (NSOperation *)resetPassword:(NSString *)newPassword
                       account:(NSString *)account
                       success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(RESET_PASSWORD);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"newPassword": [newPassword md5]
                                                     , @"account": account}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               success(operation, [responseObject[@"result"] boolValue]);
                                           }
                                           failure:failure];
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

@end
