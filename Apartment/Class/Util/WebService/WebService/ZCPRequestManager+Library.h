//
//  ZCPRequestManager+Library.h
//  Apartment
//
//  Created by apple on 16/2/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestManager.h"

@interface ZCPRequestManager (Library)

/**
*  按搜索文字，排序方式，领域分类获取的图书列表
*
*  @param searchText 搜索文字
*  @param sortMethod 排序方式
*  @param fieldID    领域ID
*  @param currUserID 当前用户ID
*  @param pageCount  一页数量
*/
- (NSOperation *)getBookListWithSearchText:(NSString *)searchText
                              SortMethod:(NSInteger)sortMethod
                                 fieldID:(NSInteger)fieldID
                              currUserID:(NSInteger)currUserID
                              pagination:(NSInteger)pagination
                               pageCount:(NSInteger)pageCount
                                 success:(void(^)(AFHTTPRequestOperation *operation, ZCPListDataModel *bookListModel))success
                                 failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;




@end
