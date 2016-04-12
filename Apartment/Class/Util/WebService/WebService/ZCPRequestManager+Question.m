//
//  ZCPRequestManager+Question.m
//  Apartment
//
//  Created by apple on 16/2/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestManager+Question.h"
#import "ZCPRequestResponseTranslator+Question.h"

@implementation ZCPRequestManager (Question)

/**
 *  得到问题列表
 *
 *  @param currUserID 当前用户ID
 */
- (NSOperation *)getQuestionListWithCurrUserID:(NSInteger)currUserID
                                       success:(void(^)(AFHTTPRequestOperation *operation, ZCPListDataModel *questionListModel))success
                                       failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(QUESTION_LIST);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currUserID": @(currUserID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   ZCPListDataModel *model = [ZCPRequestResponseTranslator translateResponse_QuestionListModel:[responseObject objectForKey:@"data"]];
                                                   success(operation, model);
                                               }
                                           } failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

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
                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(QUESTION_LIST_BY_USERID);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currUserID": @(currUserID)
                                                     , @"myUserID": @([ZCPUserCenter sharedInstance].currentUserModel.userId)
                                                     , @"pagination": @(pagination)
                                                     , @"pageCount": @(pageCount)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   ZCPListDataModel *model = [ZCPRequestResponseTranslator translateResponse_QuestionListModel:[responseObject objectForKey:@"data"]];
                                                   success(operation, model);
                                               }
                                           } failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

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
                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(QUESTION_COLLECTION_LIST_BY_USERID);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currUserID": @(currUserID)
                                                     , @"myUserID": @([ZCPUserCenter sharedInstance].currentUserModel.userId)
                                                     , @"pagination": @(pagination)
                                                     , @"pageCount": @(pageCount)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   ZCPListDataModel *model = [ZCPRequestResponseTranslator translateResponse_QuestionListModel:[responseObject objectForKey:@"data"]];
                                                   success(operation, model);
                                               }
                                           } failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  获取用户答题记录
 *
 *  @param currUserID 当前用户ID
 */
- (NSOperation *)getUserAnswersRecordWithCurrUserID:(NSInteger)currUserID
                                            success:(void(^)(AFHTTPRequestOperation *operation, BOOL userHaveAnswer, NSString *answers))success
                                            failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(USER_ANSWER_RECORD);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currUserID": @(currUserID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   BOOL userHaveAnswer = ([[responseObject objectForKey:@"code"] integerValue] == 0)? YES: NO;
                                                   NSString *answers = [responseObject objectForKey:@"answers"];
                                                   success(operation, userHaveAnswer, answers);
                                               }
                                           } failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  提交用户答题记录
 *
 *  @param currUserID 当前用户ID
 */
- (NSOperation *)submitQuestionAnswersWithCurrUserID:(NSInteger)currUserID
                                             answers:(NSString *)answers
                                             success:(void(^)(AFHTTPRequestOperation *operation, BOOL isSuccess, NSInteger score))success
                                             failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(SUBMIT_QUESTION_ANSWERS);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currUserID": @(currUserID)
                                                     , @"answers": answers}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   success(operation, [[responseObject valueForKey:@"result"] boolValue], [[responseObject valueForKey:@"score"] integerValue]);
                                               }
                                           }
                                           failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

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
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(ADD_QUESTION);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"questionContent": questionContent
                                                     , @"optionOne": optionOne
                                                     , @"optionTwo": optionTwo
                                                     , @"optionThree": optionThree
                                                     , @"answer": answer
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
                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(CHANGE_QUESTION_COLLECTION_STATE);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currCollected": @(currCollected)
                                                     , @"currQuestionID": @(currQuestionID)
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
