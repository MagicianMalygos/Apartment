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
                             if ((headImageData = UIImageJPEGRepresentation(headImage, 0.5f))) {
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


@end
