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
                              userID:(NSInteger)userID
                             success:(void (^)(AFHTTPRequestOperation *operation, UIImage *headImage, ZCPDataModel *model))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    AFHTTPRequestOperation *operation = [self POST:@""
                                        parameters:@{@"headImage":headImage
                                                     ,@"userID":@(userID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               
                                               ZCPDataModel *model = nil;
                                               if ([responseObject isKindOfClass:[NSDictionary class]]) {
                                                   model = [ZCPRequestResponseTranslator translateResponse_UserModel:responseObject[@"userModel"]];
                                               }
                                                
                                               if (success) {
                                                   success(operation, headImage, model);
                                               }
                                           }
                                           failure:failure];
    
    TTDPRINT(@"request=%@\nparams=%@", operation, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    
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
- (NSOperation *)changePassword:(NSString *)newPassword
                    oldPassword:(NSString *)oldPassword
                         userID:(NSInteger)userID
                        success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    AFHTTPRequestOperation *operation = [self POST:@""
                                        parameters:@{@"newPassword":newPassword
                                                     ,@"oldPassword":oldPassword
                                                     ,@"userId":@(userID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               
                                           }
                                           failure:failure];
    
    TTDPRINT(@"request=%@\nparams=%@", operation, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}


@end
