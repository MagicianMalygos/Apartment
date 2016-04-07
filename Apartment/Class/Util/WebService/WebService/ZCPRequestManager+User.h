//
//  ZCPRequestManager+User.h
//  Apartment
//
//  Created by apple on 16/2/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestManager.h"

@interface ZCPRequestManager (User)

/**
 *  上传用户头像
 *
 *  @param headImage 头像
 *  @param userID    用户ID
 */
- (NSOperation *)uploadUserHeadImage:(UIImage *)headImage
                              currUserID:(NSInteger)currUserID
                             success:(void (^)(AFHTTPRequestOperation *operation, UIImage *headImage, ZCPUserModel *userModel))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


/**
 *  修改用户信息
 *
 *  @param newUserName      新用户名
 *  @param newUserAge       新年龄
 *  @param oldFieldIDArr    就领域ID数组
 *  @param newFieldArr      新领域ID数组
 *  @param currUserID       当前用户ID
 */
- (NSOperation *)modifyUserInfoWithNewUserName:(NSString *)newUserName
                                    newUserAge:(NSInteger)newUserAge
                                 oldFieldIDArr:(NSArray *)oldFieldIDArr
                                 newFieldIDArr:(NSArray *)newFieldIDArr
                                    currUserID:(NSInteger)currUserID
                                       success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  修改密码
 *
 *  @param newPassword 新密码
 *  @param oldPassword 旧密码
 *  @param currUserID  用户ID
 */
- (NSOperation *)modifyPassword:(NSString *)newPassword
                    oldPassword:(NSString *)oldPassword
                     currUserID:(NSInteger)currUserID
                        success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
