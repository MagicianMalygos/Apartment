//
//  ZCPRequestManager+Login.h
//  Apartment
//
//  Created by apple on 16/4/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestManager.h"

@interface ZCPRequestManager (Login)

/**
 *  用户登录验证
 *
 *  @param account  账号
 *  @param password 密码
 */
- (NSOperation *)loginWithAccount:(NSString *)account
                         password:(NSString *)password
                          success:(void (^)(AFHTTPRequestOperation *operation, NSString *msg, ZCPUserModel *userModel))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  判断当前账号是否可以注册
 *
 *  @param account  账号
 */
- (NSOperation *)JudgeAccountCanBeRegisterWithAccount:(NSString *)account
                                              success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess, NSString *msg))success
                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  重设密码
 *
 *  @param newPassword 新密码
 *  @param account     账号
 */
- (NSOperation *)resetPassword:(NSString *)newPassword
                       account:(NSString *)account
                       success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
