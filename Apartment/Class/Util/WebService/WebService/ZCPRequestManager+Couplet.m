//
//  ZCPRequestManager+Couplet.m
//  Apartment
//
//  Created by apple on 16/2/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestManager+Couplet.h"

#import "ZCPRequestResponseTranslator+Couplet.h"

@implementation ZCPRequestManager (Couplet)

/**
 *  得到按时间排序的对联列表
 *
 *  @param pageCount  一页数量
 *  @param currUserId 当前用户ID
 */
- (NSOperation *)getCoupletListByTimeWithPageCount:(NSInteger)pageCount
                                        currUserID:(NSInteger)currUserID
                                           success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *coupletListModel))success
                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(COUPLET_LIST_BY_TIME);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"pageCount":@(pageCount)
                                                     , @"currUserID":@(currUserID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   ZCPListDataModel *model = [ZCPRequestResponseTranslator translateResponse_CoupletModel_List:[responseObject objectForKey:@"data"]];
                                                   success(operation, model);
                                               }
                                           } failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  得到按时间排序，在oldCoupletID对应对联之后的对联列表
 *
 *  @param pageCount    一页数量
 *  @param oldCoupletID 下拉刷新最后一个对联信息
 *  @param currUserID   当前用户ID
 */
- (NSOperation *)getOldCoupletListByTimeWithPageCount:(NSInteger)pageCount
                                         oldCoupletID:(NSInteger)oldCoupletID
                                        currUserID:(NSInteger)currUserID
                                           success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *coupletListModel))success
                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(OLD_COUPLET_LIST_BY_TIME);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"pageCount":@(pageCount)
                                                     , @"oldCoupletID": @(oldCoupletID)
                                                     , @"currUserID":@(currUserID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   ZCPListDataModel *model = [ZCPRequestResponseTranslator translateResponse_CoupletModel_List:[responseObject objectForKey:@"data"]];
                                                   success(operation, model);
                                               }
                                           } failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  得到按点赞量排序的对联列表
 *
 *  @param pageCount  一页数量
 *  @param currUserId 当前用户ID
 */
- (NSOperation *)getCoupletListBySupportWithPageCount:(NSInteger)pageCount
                                           currUserID:(NSInteger)currUserID
                                              success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *coupletListModel))success
                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(COUPLET_LIST_BY_SUPPORT);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"pageCount": @(pageCount)
                                                     ,@"currUserID": @(currUserID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   ZCPListDataModel *model = [ZCPRequestResponseTranslator translateResponse_CoupletModel_List:[responseObject objectForKey:@"data"]];
                                                   success(operation, model);
                                               }
                                           }
                                           failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  得到按时间排序的对联回复列表
 *
 *  @param pageCount  一页数量
 *  @param currUserId 当前用户ID
 */
- (NSOperation *)getCoupletReplyListWithPageCount:(NSInteger)pageCount
                                    currCoupletID:(NSInteger)currCoupletID
                                        currUserID:(NSInteger)currUserID
                                            success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *coupletReplyListModel))success
                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(COUPLET_REPLY_LIST);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"pageCount": @(pageCount)
                                                     , @"currCoupletID": @(currCoupletID)
                                                     , @"currUserID": @(currUserID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   ZCPListDataModel *model = [ZCPRequestResponseTranslator translateResponse_CoupletReplyModel_List:[responseObject objectForKey:@"data"]];
                                                   success(operation, model);
                                               }
                                           }
                                           failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  添加对联
 *
 *  @param coupletContent 对联内容
 *  @param currUserID     当前用户ID
 */
- (NSOperation *)addCoupletContent:(NSString *)coupletContent
                        currUserID:(NSInteger)currUserID
                           success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(ADD_COUPLET);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"coupletContent": coupletContent
                                                     ,@"currUserID": @(currUserID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   success(operation, [responseObject valueForKey:@"result"]);
                                               }
                                           }
                                           failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  添加对联回复
 *
 *  @param coupletReplyContent 对联回复内容
 *  @param currCoupletID       回复对联ID
 *  @param currUserID          当前用户ID
 */
- (NSOperation *)addCoupletReplyContent:(NSString *)coupletReplyContent
                          currCoupletID:(NSInteger)currCoupletID
                             currUserID:(NSInteger)currUserID
                                success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(ADD_COUPLET_REPLY);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"coupletReplyContent": coupletReplyContent
                                                     ,@"currCoupletID": @(currCoupletID)
                                                     ,@"currUserID": @(currUserID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   success(operation, [responseObject valueForKey:@"result"]);
                                               }
                                           }
                                           failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  改变对联点赞状态
 *
 *  @param currSupported 当前点赞状态
 *  @param currCoupletID 当前对联ID
 *  @param currUserID    当前用户ID
 */
- (NSOperation *)changeCoupletCurrSupportState:(NSInteger)currSupported
                              currCoupletID:(NSInteger)currCoupletID
                                 currUserID:(NSInteger)currUserID
                                    success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(CHANGE_COUPLET_SUPPORT_STATE);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currSupported": @(currSupported)
                                                     ,@"currCoupletID": @(currCoupletID)
                                                     ,@"currUserID": @(currUserID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   success(operation, [responseObject valueForKey:@"result"]);
                                               }
                                           }
                                           failure:failure];
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  改变对联收藏状态
 *
 *  @param currCollection 当前收藏状态
 *  @param currCoupletID  当前对联ID
 *  @param currUserID     当前用户ID
 */
- (NSOperation *)changeCoupletCurrCollectionState:(NSInteger)currCollected
                              currCoupletID:(NSInteger)currCoupletID
                                 currUserID:(NSInteger)currUserID
                                    success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(CHANGE_COUPLET_COLLECTION_STATE);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currCollected": @(currCollected)
                                                     ,@"currCoupletID": @(currCoupletID)
                                                     ,@"currUserID": @(currUserID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   success(operation, [responseObject valueForKey:@"result"]);
                                               }
                                           }
                                           failure:failure];
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  改变对联回复点赞状态
 *
 *  @param currSupported 当前点赞状态
 *  @param currCoupletID 当前对联回复ID
 *  @param currUserID    当前用户ID
 */
- (NSOperation *)changeCoupletReplyCurrSupportState:(ZCPCoupletSupportState)currSupported
                              currCoupletReplyID:(NSInteger)currCoupletReplyID
                                      currUserID:(NSInteger)currUserID
                                         success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(CHANGE_COUPLET_REPLY_SUPPORT_STATE);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currSupported": @(currSupported)
                                                     ,@"currCoupletReplyID": @(currCoupletReplyID)
                                                     ,@"currUserID": @(currUserID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   success(operation, [responseObject valueForKey:@"result"]);
                                               }
                                           }
                                           failure:failure];
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

@end
