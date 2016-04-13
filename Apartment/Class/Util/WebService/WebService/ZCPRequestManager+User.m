//
//  ZCPRequestManager+User.m
//  Apartment
//
//  Created by apple on 16/2/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestManager+User.h"

#import "ZCPRequestResponseTranslator.h"

@implementation ZCPRequestManager (User)

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
                                                     , @"password": password}
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
 *  上传用户头像
 *
 *  @param headImage 头像
 *  @param userID    用户ID
 */
- (NSOperation *)uploadUserHeadImage:(UIImage *)headImage
                              currUserID:(NSInteger)currUserID
                             success:(void (^)(AFHTTPRequestOperation *operation, UIImage *headImage, ZCPUserModel *model))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(UPLOAD_HEAD);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currUserID": @(currUserID)}
                         constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                             
                             NSString *fileName = nil;
                             NSString *mimeType = nil;
                             NSString *extension = nil;
                             
                             NSData *headImageData = nil;
                             if ((headImageData = UIImageJPEGRepresentation(headImage, 0.1f))) {
                                 mimeType = @"image/jpeg";
                                 extension = @".jpeg";
                             } else {
                                 headImageData = UIImagePNGRepresentation(headImage);
                                 mimeType = @"image/png";
                                 extension = @".png";
                             }
                             fileName = [NSString stringWithFormat:@"%@%u%@", [NSString stringFromDate:[NSDate new] withDateFormat:@"yyyyMMddHHmmss"], SALT, extension];
                            
                             [formData appendPartWithFileData:headImageData      // 文件data
                                                         name:@"head"            // php获取参数名
                                                     fileName:fileName           // 文件名
                                                     mimeType:mimeType];         // 文件类型
                         } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             ZCPUserModel *model = nil;
                             if ([responseObject isKindOfClass:[NSDictionary class]]) {
                                 model = [ZCPRequestResponseTranslator translateResponse_UserModel:responseObject[@"data"][@"aUser"]];
                             }
        
                             if (success) {
                                 success(operation, headImage, model);
                             }
                         } failure:failure];
    
    TTDPRINT(@"request=%@\nparams=%@", operation, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    
    return operation;
}

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
                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(MODIFY_USER_INFO);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"newUserName": newUserName
                                                     , @"newUserAge": @(newUserAge)
                                                     , @"oldFieldIDArr": oldFieldIDArr
                                                     , @"newFieldIDArr": newFieldIDArr
                                                     , @"currUserID": @(currUserID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               ZCPUserModel *model = nil;
                                               BOOL isSuccess = NO;
                                               if ([responseObject isKindOfClass:[NSDictionary class]]
                                                   && ([[responseObject valueForKey:@"code"] integerValue] == 0)) {
                                                    isSuccess = YES;
                                                    model = [ZCPRequestResponseTranslator translateResponse_UserModel:responseObject[@"data"][@"aUser"]];
                                               }
                                               
                                               if (success) {
                                                   success(operation, isSuccess, model);
                                               }
                                           }
                                           failure:failure];
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  修改密码
 *
 *  @param newPassword 新密码
 *  @param oldPassword 旧密码
 *  @param userID      用户ID
 *
 */
- (NSOperation *)modifyPassword:(NSString *)newPassword
                    oldPassword:(NSString *)oldPassword
                     currUserID:(NSInteger)currUserID
                        success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess, ZCPUserModel *model))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(MODIFY_USER_PASSWORD);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"newPassword":newPassword
                                                     ,@"oldPassword":oldPassword
                                                     ,@"currUserID":@(currUserID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               ZCPUserModel *model = nil;
                                               BOOL isSuccess = NO;
                                               if ([responseObject isKindOfClass:[NSDictionary class]]
                                                   && ([[responseObject valueForKey:@"code"] integerValue] == 0)) {
                                                   isSuccess = YES;
                                                   model = [ZCPRequestResponseTranslator translateResponse_UserModel:responseObject[@"data"][@"aUser"]];
                                               }
                                               if ([[responseObject valueForKey:@"code"] integerValue] == 1) {
                                                   TTDPRINT(@"用户密码有误！");
                                                   [MBProgressHUD showError:@"原密码有误！"];
                                               } else if ([[responseObject valueForKey:@"code"] integerValue] == 2) {
                                                   TTDPRINT(@"数据库存储数据失败！");
                                                   [MBProgressHUD showError:@"修改失败！"];
                                               }
                                               
                                               if (success) {
                                                   success(operation, isSuccess, model);
                                               }
                                           }
                                           failure:failure];
    
    TTDPRINT(@"request=%@\nparams=%@", operation, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}


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
                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {

    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(COLLECTED_USER_LIST);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currUserID": @(currUserID)
                                                     , @"pagination": @(pagination)
                                                     , @"pageCount": @(pageCount)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   ZCPListDataModel *model = [ZCPRequestResponseTranslator translateResponse_UserListModel:[responseObject objectForKey:@"data"]];
                                                   success(operation, model);
                                               }
                                           }
                                           failure:failure];
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}


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
                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {

    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(CHANGE_USER_COLLECTION_STATE);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currCollected": @(currCollected)
                                                     , @"collectedUserID": @(collectedUserID)
                                                     , @"currUserID": @(currUserID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   success(operation, [[responseObject valueForKey:@"result"] boolValue]);
                                               }
                                           }
                                           failure:failure];
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  判断用户是否关注另一个用户
 *
 *  @param otherUserID 另一个用户ID
 *  @param currUserID  用户ID
 */
- (NSOperation *)judgeUserCollectOtherUserID:(NSInteger)otherUserID
                                  currUserID:(NSInteger)currUserID
                                     success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {

    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(JUDGE_USER_COLLECT_OTHERUSER);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"otherUserID": @(otherUserID)
                                                     , @"currUserID": @(currUserID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   success(operation, [[responseObject valueForKey:@"result"] boolValue]);
                                               }
                                           }
                                           failure:failure];
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

@end
