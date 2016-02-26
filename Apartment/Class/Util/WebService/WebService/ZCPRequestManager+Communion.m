//
//  ZCPRequestManager+Communion.m
//  Apartment
//
//  Created by apple on 16/2/22.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestManager+Communion.h"

#import "ZCPRequestResponseTranslator+Communion.h"

@implementation ZCPRequestManager (Communion)

/**
 *  得到根据field查询出的图书贴列表
 *
 *  @param sortMethod    搜索方式
 *  @param currUserID    当前用户ID
 *  @param pageCount     一页数量
 */
- (NSOperation *)getBookpostListWithSortMethod:(ZCPBookpostSortMethod)sortMethod
                                       fieldID:(NSInteger)fieldID
                                    currUserID:(NSInteger)currUserID
                                     pageCount:(NSInteger)pageCount
                                       success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel))success
                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(BOOKPOST_LIST_BY_SORTMETHOD_FIELD);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"sortMethod": @(sortMethod)
                                                     , @"fieldID": @(fieldID)
                                                     , @"currUserID": @(currUserID)
                                                     , @"pageCount": @(pageCount)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   ZCPListDataModel *model = [ZCPRequestResponseTranslator translateResponse_BookPostListModel:[responseObject objectForKey:@"data"]];
                                                   success(operation, model);
                                               }
                                           }
                                           failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  得到根据oldBookpostID和fieldID查询出的图书贴列表
 *
 *  @param sortMethod    搜索方式
 *  @param oldBookpostID 当前用户ID
 *  @param fieldID       领域ID
 *  @param currUserID    当前用户ID
 *  @param pageCount     一页数量
 */
- (NSOperation *)getOldBookpostListWithSortMethod:(ZCPBookpostSortMethod)sortMethod
                                    oldBookpostID:(NSInteger) oldBookpostID
                                          fieldID:(NSInteger)fieldID
                                       currUserID:(NSInteger)currUserID
                                        pageCount:(NSInteger)pageCount
                                          success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel))success
                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(OLD_BOOKPOST_LIST_BY_SORTMETHOD_FIELD);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"sortMethod": @(sortMethod)
                                                     , @"oldBookpostID": @(oldBookpostID)
                                                     , @"fieldID": @(fieldID)
                                                     , @"currUserID": @(currUserID)
                                                     , @"pageCount": @(pageCount)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   ZCPListDataModel *model = [ZCPRequestResponseTranslator translateResponse_BookPostListModel:[responseObject objectForKey:@"data"]];
                                                   success(operation, model);
                                               }
                                           }
                                           failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  得到根据SearchText查询出的图书贴列表
 *
 *  @param searchText 搜索条件
 *  @param sortMethod 搜索方式
 *  @param fieldID    领域ID
 *  @param currUserID 当前用户ID
 *  @param pageCount  一页数量
 */
- (NSOperation *)getBookpostWithSearchText:(NSString *) searchText
                                   sortMethod:(ZCPBookpostSortMethod) sortMethod
                                      fieldID:(NSInteger) fieldID
                                   currUserID:(NSInteger) currUserID
                                    pageCount:(NSInteger) pageCount
                                      success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel))success
                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(BOOKPOST_LIST_BY_SEARCHTEXT);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"searchText": searchText
                                                     , @"sortMethod": @(sortMethod)
                                                     , @"fieldID": @(fieldID)
                                                     , @"currUserID": @(currUserID)
                                                     , @"pageCount": @(pageCount)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   ZCPListDataModel *model = [ZCPRequestResponseTranslator translateResponse_BookPostListModel:[responseObject objectForKey:@"data"]];
                                                   success(operation, model);
                                               }
                                           }
                                           failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}


/**
 *  改变图书贴收藏状态
 *
 *  @param currCollected    当前收藏状态
 *  @param currBookpostID   当前图书贴ID
 *  @param currUserID       当前用户ID
 */
- (NSOperation *)changeBookpostCurrCollectionState:(NSInteger)currCollected
                                     currCoupletID:(NSInteger)currBookpostID
                                        currUserID:(NSInteger)currUserID
                                           success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(CHANGE_BOOKPOST_COLLECTION_STATE);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currCollected": @(currCollected)
                                                     , @"currBookpostID": @(currBookpostID)
                                                     , @"currUserID": @(currUserID)}
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
