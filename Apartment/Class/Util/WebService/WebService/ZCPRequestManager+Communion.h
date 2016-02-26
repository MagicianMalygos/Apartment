//
//  ZCPRequestManager+Communion.h
//  Apartment
//
//  Created by apple on 16/2/22.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestManager.h"

// bookpost排序方式
typedef NS_ENUM(NSInteger, ZCPBookpostSortMethod){
    ZCPBookpostSortByTime       = 0,
    ZCPBookpostSortBySupport    = 1
};

@interface ZCPRequestManager (Communion)

/**
*  得到根据fieldID查询出的图书贴列表
*
*  @param fieldID       领域ID
*  @param sortMethod    搜索方式
*  @param currUserID    当前用户ID
*  @param pageCount     一页数量
*/
- (NSOperation *)getBookpostListWithSortMethod:(ZCPBookpostSortMethod) sortMethod
                                       fieldID:(NSInteger)fieldID
                                    currUserID:(NSInteger) currUserID
                                     pageCount:(NSInteger) pageCount
                                       success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel))success
                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                                          fieldID:(NSInteger) fieldID
                                       currUserID:(NSInteger) currUserID
                                        pageCount:(NSInteger) pageCount
                                          success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel))success
                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


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
                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
