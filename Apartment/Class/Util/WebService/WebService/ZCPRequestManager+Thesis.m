//
//  ZCPRequestManager+Thesis.m
//  Apartment
//
//  Created by apple on 16/2/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestManager+Thesis.h"

#import "ZCPRequestResponseTranslator+Thesis.h"

@implementation ZCPRequestManager (Thesis)

/**
 *  获取当前辩题信息
 *
 *  @param currUserID 当前用户ID
 */
- (NSOperation *)getCurrThesisWithCurrUserID:(NSInteger)currUserID
                                     success:(void (^)(AFHTTPRequestOperation *operation, NSDictionary *modelDict))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(CURRENT_THESIS);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currUserID": @(currUserID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   NSDictionary *modelDict = [ZCPRequestResponseTranslator translateResponse_CurrThesisAndArgument:[responseObject valueForKey:@"data"]];
                                                   success(operation, modelDict);
                                               }
                                           }
                                           failure:failure];
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  得到某个人发表的辩题列表
 *  @param currUserID 当前用户ID
 *  @param pagination 页码
 *  @param pageCount  一页数量
 */
- (NSOperation *)getThesisWithCurrUserID:(NSInteger) currUserID
                              pagination:(NSInteger) pagination
                               pageCount:(NSInteger) pageCount
                                 success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *thesisListModel))success
                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(THESIS_LIST_BY_USERID);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currUserID": @(currUserID)
                                                     , @"pagination": @(pagination)
                                                     , @"pageCount": @(pageCount)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   ZCPListDataModel *model = [ZCPRequestResponseTranslator translateResponse_ThesisListModel:[responseObject objectForKey:@"data"]];
                                                   success(operation, model);
                                               }
                                           }
                                           failure:failure];
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  获取当前辩题的论据列表
 *
 *  @param belong     所属正反方
 *  @param currUserID 当前用户ID
 *  @param pagination 页码
 *  @param pageCount  一页个数
 */
- (NSOperation *)getArgumentListWithBelong:(ZCPArgumentBelong)belong
                                currUserID:(NSInteger)currUserID
                                pagination:(NSInteger)pagination
                                 pageCount:(NSInteger)pageCount
                                   success:(void(^)(AFHTTPRequestOperation *operation, ZCPListDataModel *argumentListModel))success
                                   failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(ARGUMENT_LIST_BY_BELONG);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"belong": @(belong)
                                                     , @"currUserID": @(currUserID)
                                                     , @"pagination": @(pagination)
                                                     , @"pageCount": @(pageCount)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   ZCPListDataModel *model = [ZCPRequestResponseTranslator translateResponse_ArgumentListModel:[responseObject objectForKey:@"data"]];
                                                   success(operation, model);
                                               }
                                           }
                                           failure:failure];
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  改变辩题收藏状态
 *
 *  @param currCollected 当前收藏状态
 *  @param currThesisID  当前辩题ID
 *  @param currUserID    当前用户ID
 */
- (NSOperation *)changeThesisCurrCollectionState:(NSInteger)currCollected
                                    currThesisID:(NSInteger)currThesisID
                                      currUserID:(NSInteger)currUserID
                                         success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(CHANGE_THESIS_COLLECTION_STATE);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currCollected": @(currCollected)
                                                     , @"currThesisID": @(currThesisID)
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
 *  改变论据点赞状态
 *
 *  @param currSupported  当前点赞状态
 *  @param currArgumentID 当前论据ID
 *  @param currUserID     当前用户ID
 */
- (NSOperation *)changeArgumentCurrSupportedState:(NSInteger)currSupported
                                   currArgumentID:(NSInteger)currArgumentID
                                       currUserID:(NSInteger)currUserID
                                          success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(CHANGE_ARGUMENT_SUPPORT_STATE);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currSupported": @(currSupported)
                                                     , @"currArgumentID": @(currArgumentID)
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
 *  添加辩题
 *
 *  @param thesisContent   辩题内容
 *  @param thesisPros      正方论点
 *  @param thesisCons      反方论点
 *  @param thesisAddReason 添加辩题原因
 *  @param currUserID      当前用户ID
 */
- (NSOperation *)addThesisContent:(NSString *)thesisContent
                       thesisPros:(NSString *)thesisPros
                       thesisCons:(NSString *)thesisCons
                  thesisAddReason:(NSString *)thesisAddReason
                       currUserID:(NSInteger)currUserID
                          success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(ADD_THESIS);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"thesisContent": thesisContent
                                                     , @"thesisPros": thesisPros
                                                     , @"thesisCons": thesisCons
                                                     , @"thesisAddReson": thesisAddReason
                                                     , @"currUserID": @(currUserID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   NSDictionary *modelDict = [ZCPRequestResponseTranslator translateResponse_CurrThesisAndArgument:[responseObject valueForKey:@"data"]];
                                                   success(operation, modelDict);
                                               }
                                           }
                                           failure:failure];
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  添加论据
 *
 *  @param argumentContent 论据内容
 *  @param argumentBelong  论据所属正反方
 *  @param isAnonymous     是否匿名
 *  @param currThesisID    当前辩题ID
 *  @param currUserID      当前用户ID
 */
- (NSOperation *)addArgumentContent:(NSString *)argumentContent
                     argumentBelong:(ZCPArgumentBelong)argumentBelong
                        isAnonymous:(BOOL)isAnonymous
                       currThesisID:(NSInteger)currThesisID
                         currUserID:(NSInteger)currUserID
                            success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(ADD_ARGUMENT);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"argumentContent": argumentContent
                                                     , @"argumentBelong": @(argumentBelong)
                                                     , @"isAnonymous": @(isAnonymous)
                                                     , @"currThesisID": @(currThesisID)
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
