//
//  ZCPRequestManager+Thesis.h
//  Apartment
//
//  Created by apple on 16/2/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestManager.h"

#import "ZCPArgumentModel.h"

@interface ZCPRequestManager (Thesis)

/**
 *  获取当前辩题信息
 *
 *  @param currUserID 当前用户ID
 */
- (NSOperation *)getCurrThesisWithCurrUserID:(NSInteger)currUserID
                                     success:(void(^)(AFHTTPRequestOperation *operation, NSDictionary *modelDict))success
                                     failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  得到某个人发表的辩题列表
 *  @param currUserID 当前用户ID
 *  @param pagination 页码
 *  @param pageCount  一页数量
 */
- (NSOperation *)getThesisListWithCurrUserID:(NSInteger) currUserID
                                  pagination:(NSInteger) pagination
                                   pageCount:(NSInteger) pageCount
                                     success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *thesisListModel))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  得到某个人收藏的辩题列表
 *  @param currUserID 当前用户ID
 *  @param pagination 页码
 *  @param pageCount  一页数量
 */
- (NSOperation *)getThesisCollectionListWithCurrUserID:(NSInteger) currUserID
                                            pagination:(NSInteger) pagination
                                             pageCount:(NSInteger) pageCount
                                               success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *thesisListModel))success
                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                                   failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
