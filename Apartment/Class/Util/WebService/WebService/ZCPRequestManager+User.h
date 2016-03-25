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
 *  修改密码
 *
 *  @param newPassword 新密码
 *  @param oldPassword 旧密码
 *  @param userID      用户ID
 */
- (NSOperation *)changePassword:(NSString *)newPassword
                    oldPassword:(NSString *)oldPassword
                         userID:(NSInteger)userID
                        success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (NSOperation *)changeSecurity;

@end
