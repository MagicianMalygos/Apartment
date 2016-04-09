//
//  ZCPRequestManager+Couplet.h
//  Apartment
//
//  Created by apple on 16/2/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestManager.h"

#import "ZCPCoupletModel.h"
#import "ZCPCoupletReplyModel.h"

@interface ZCPRequestManager (Couplet)

/**
*  得到根据排序方式获取的对联列表
*
*  @param sortMethod 排序方式
*  @param currUserID 当前用户ID
*  @param pagination 页码
*  @param pageCount  一页数量
*/
- (NSOperation *)getCoupletListWithSortMethod:(NSInteger)sortMethod
                                   currUserID:(NSInteger)currUserID
                                   pagination:(NSInteger)pagination
                                    pageCount:(NSInteger)pageCount
                                      success:(void(^)(AFHTTPRequestOperation *operation, ZCPListDataModel *coupletListModel))success
                                      failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  得到某个人发表的对联列表
 *  @param currUserID 当前用户ID
 *  @param pagination 页码
 *  @param pageCount  一页数量
 */
- (NSOperation *)getCoupltListWithCurrUserID:(NSInteger) currUserID
                                  pagination:(NSInteger) pagination
                                   pageCount:(NSInteger) pageCount
                                     success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *coupltListModel))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  得到某个人收藏的对联列表
 *  @param currUserID 当前用户ID
 *  @param pagination 页码
 *  @param pageCount  一页数量
 */
- (NSOperation *)getCoupltCollectionListWithCurrUserID:(NSInteger) currUserID
                                            pagination:(NSInteger) pagination
                                             pageCount:(NSInteger) pageCount
                                               success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *coupltListModel))success
                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  得到对联回复列表
 *
 *  @param currCoupletID 当前对联ID
 *  @param currUserID    当前用户ID
 *  @param pagination    页码
 *  @param pageCount     一页数量
 */
- (NSOperation *)getCoupletReplyListWithCurrCoupletID:(NSInteger)currCoupletID
                                           currUserID:(NSInteger)currUserID
                                           pagination:(NSInteger)pagination
                                            pageCount:(NSInteger)pageCount
                                              success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *coupletReplyListModel))success
                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  添加对联
 *
 *  @param coupletContent 对联内容
 *  @param currUserID     当前用户ID
 */
- (NSOperation *)addCoupletContent:(NSString *)coupletContent
                        currUserID:(NSInteger)currUserID
                           success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  改变对联收藏状态
 *
 *  @param currCollected 当前收藏状态
 *  @param currCoupletID 当前对联ID
 *  @param currUserID    当前用户ID
 */
- (NSOperation *)changeCoupletCurrCollectionState:(NSInteger)currCollected
                                 currCoupletID:(NSInteger)currCoupletID
                                    currUserID:(NSInteger)currUserID
                                       success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  改变对联回复点赞状态
 *
 *  @param currSupported 当前点赞状态
 *  @param currCoupletID 当前对联回复ID
 *  @param currUserID    当前用户ID
 */
- (NSOperation *)changeCoupletReplyCurrSupportState:(ZCPCoupletReplySupportState)currSupported
                              currCoupletReplyID:(NSInteger)currCoupletReplyID
                                 currUserID:(NSInteger)currUserID
                                    success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
