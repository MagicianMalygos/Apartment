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
                                       success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess, ZCPUserModel *model))success
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
                        success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess, ZCPUserModel *model))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


/**
 *  获得用户所关注人列表
 *
 *  @param currUserID 当前用户ID
 *  @param pagination 页码
 *  @param pageCount  一页数量
 */
- (NSOperation *)getCollectedUserListWithCurrUserID:(NSInteger)currUserID
                                         pagination:(NSInteger)pagination
                                          pageCount:(NSInteger)pageCount
                                            success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel* userListModel))success
                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


/**
 *  改变用户被关注状态
 *
 *  @param collectedUserID  被关注人ID
 *  @param currUserID       用户ID
 */
- (NSOperation *)changeCollectedUserCurrCollectionState:(NSInteger)currCollected
                                        collectedUserID:(NSInteger)collectedUserID
                                             currUserID:(NSInteger)currUserID
                                                success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  判断用户是否关注另一个用户
 *
 *  @param otherUserID 另一个用户ID
 *  @param currUserID  用户ID
 */
- (NSOperation *)judgeUserCollectOtherUserID:(NSInteger)otherUserID
                                  currUserID:(NSInteger)currUserID
                                     success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
