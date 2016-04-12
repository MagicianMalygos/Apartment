//
//  ZCPRequestManager+Question.h
//  Apartment
//
//  Created by apple on 16/2/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestManager.h"

@interface ZCPRequestManager (Question)

/**
*  得到问题列表
*
*  @param currUserID 当前用户ID
*/
- (NSOperation *)getQuestionListWithCurrUserID:(NSInteger)currUserID
                                       success:(void(^)(AFHTTPRequestOperation *operation, ZCPListDataModel *questionListModel))success
                                       failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  得到某个人发表的题目列表
 *  @param currUserID 当前用户ID
 *  @param pagination 页码
 *  @param pageCount  一页数量
 */
- (NSOperation *)getQuestionListWithCurrUserID:(NSInteger) currUserID
                                    pagination:(NSInteger) pagination
                                     pageCount:(NSInteger) pageCount
                                       success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *questionListModel))success
                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  得到某个人收藏的题目列表
 *  @param currUserID 当前用户ID
 *  @param pagination 页码
 *  @param pageCount  一页数量
 */
- (NSOperation *)getQuestionCollectionListWithCurrUserID:(NSInteger) currUserID
                                              pagination:(NSInteger) pagination
                                               pageCount:(NSInteger) pageCount
                                                 success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *questionListModel))success
                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  获取用户答题记录
 *
 *  @param currUserID 当前用户ID
 */
- (NSOperation *)getUserAnswersRecordWithCurrUserID:(NSInteger)currUserID
                                            success:(void(^)(AFHTTPRequestOperation *operation, BOOL userHaveAnswer, NSString *answers))success
                                            failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  提交用户答题记录
 *
 *  @param currUserID 当前用户ID
 */
- (NSOperation *)submitQuestionAnswersWithCurrUserID:(NSInteger)currUserID
                                             answers:(NSString *)answers
                                             success:(void(^)(AFHTTPRequestOperation *operation, BOOL isSuccess, NSInteger score))success
                                             failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  添加问题
 *
 *  @param questionContent 问题内容
 *  @param optionOne       选项一内容
 *  @param optionTwo       选项二内容
 *  @param optionThree     选项三内容
 *  @param answer          选项四内容
 *  @param currUserID      当前用户ID
 */
- (NSOperation *)addQuestionContent:(NSString *)questionContent
                          optionOne:(NSString *)optionOne
                          optionTwo:(NSString *)optionTwo
                        optionThree:(NSString *)optionThree
                             answer:(NSString *)answer
                         currUserID:(NSInteger)currUserID
                           success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  改变问题收藏状态
 *
 *  @param currCollected    当前收藏状态
 *  @param currQuestionID   当前问题ID
 *  @param currUserID       当前用户ID
 */
- (NSOperation *)changeQuestionCurrCollectionState:(NSInteger)currCollected
                                    currQuestionID:(NSInteger)currQuestionID
                                        currUserID:(NSInteger)currUserID
                                           success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
