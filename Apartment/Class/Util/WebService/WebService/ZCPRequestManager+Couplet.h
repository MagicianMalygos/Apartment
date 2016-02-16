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
 *  得到按时间排序的对联列表
 *
 *  @param pageCount  一页数量
 *  @param currUserId 当前用户ID
 */
- (NSOperation *)getCoupletListByTimeWithPageCount:(NSInteger)pageCount
                                        currUserID:(NSInteger)currUserID
                                           success:(void(^)(AFHTTPRequestOperation *operation, ZCPDataModel *model))success
                                           failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  得到按点赞量排序的对联列表
 *
 *  @param pageCount  一页数量
 *  @param currUserId 当前用户ID
 */
- (NSOperation *)getCoupletListBySupportWithPageCount:(NSInteger)pageCount
                                        currUserID:(NSInteger)currUserID
                                           success:(void(^)(AFHTTPRequestOperation *operation, ZCPDataModel *model))success
                                           failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
- (NSOperation *)changeCoupletSupportRecord:(NSInteger)currSupported
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
- (NSOperation *)changeCoupletCollectionRecord:(NSInteger)currCollected
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
- (NSOperation *)changeCoupletReplySupportRecord:(ZCPCoupletSupportState)currSupported
                              currCoupletReplyID:(NSInteger)currCoupletReplyID
                                 currUserID:(NSInteger)currUserID
                                    success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end