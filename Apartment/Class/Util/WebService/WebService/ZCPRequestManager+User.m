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
