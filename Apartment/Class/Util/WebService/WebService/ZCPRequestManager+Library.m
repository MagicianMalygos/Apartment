//
//  ZCPRequestManager+Library.m
//  Apartment
//
//  Created by apple on 16/2/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestManager+Library.h"

#import "ZCPRequestResponseTranslator+Library.h"

@implementation ZCPRequestManager (Library)

/**
 *  按搜索文字，排序方式，分类获取的图书列表
 *
 *  @param searchText 搜索文字
 *  @param sortMethod 排序方式
 *  @param fieldID    领域ID
 *  @param currUserID 当前用户ID
 *  @param pageCount  一页数量
 */
- (NSOperation *)getBookListBySearchText:(NSString *)searchText
                              SortMethod:(NSInteger)sortMethod
                                 fieldID:(NSInteger)fieldID
                              currUserID:(NSInteger)currUserID
                              pagination:(NSInteger)pagination
                               pageCount:(NSInteger)pageCount
                                 success:(void(^)(AFHTTPRequestOperation *operation, ZCPListDataModel *bookListModel))success
                                 failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(BOOK_LIST);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"searchText": searchText
                                                     , @"sortMethod": @(sortMethod)
                                                     , @"fieldID": @(fieldID)
                                                     , @"currUserID": @(currUserID)
                                                     , @"pagination": @(pagination)
                                                     , @"pageCount":@(pageCount)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   ZCPListDataModel *model = [ZCPRequestResponseTranslator translateResponse_BookListModel:[responseObject objectForKey:@"data"]];
                                                   success(operation, model);
                                               }
                                           } failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  改变图书收藏状态
 *
 *  @param currCollected 当前收藏状态
 *  @param currBookID    当前图书ID
 *  @param currUserID    当前用户ID
 */
- (NSOperation *)changeBookCurrCollectionState:(NSInteger)currCollected
                                 currCoupletID:(NSInteger)currBookID
                                    currUserID:(NSInteger)currUserID
                                       success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(CHANGE_BOOK_COLLECTION_STATE);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currCollected": @(currCollected)
                                                     , @"currBookID": @(currBookID)
                                                     , @"currUserID": @(currUserID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   success(operation, [responseObject valueForKey:@"result"]);
                                               }
                                           } failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

@end
