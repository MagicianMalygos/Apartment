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
 *  得到根据关键字、排序方式、领域ID获取的图书贴列表
 *
 *  @param searchText 搜索条件
 *  @param sortMethod 搜索方式
 *  @param fieldID    领域ID
 *  @param currUserID 当前用户ID
 *  @param pagination 页码
 *  @param pageCount  一页数量
 */
- (NSOperation *)getBookpostListWithSearchText:(NSString *) searchText
                                  sortMethod:(ZCPBookpostSortMethod) sortMethod
                                     fieldID:(NSInteger) fieldID
                                  currUserID:(NSInteger) currUserID
                                  pagination:(NSInteger) pagination
                                   pageCount:(NSInteger) pageCount
                                     success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(BOOKPOST_LIST_BY_MULTI_CONDITION);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"searchText": searchText
                                                     , @"sortMethod": @(sortMethod)
                                                     , @"fieldID": @(fieldID)
                                                     , @"currUserID": @(currUserID)
                                                     , @"pagination": @(pagination)
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
 *  得到某个人发表的图书贴列表
 *  @param currUserID 当前用户ID
 *  @param pagination 页码
 *  @param pageCount  一页数量
 */
- (NSOperation *)getBookpostListWithCurrUserID:(NSInteger) currUserID
                                    pagination:(NSInteger) pagination
                                     pageCount:(NSInteger) pageCount
                                       success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel))success
                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {

    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(BOOKPOST_LIST_BY_USERID);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currUserID": @(currUserID)
                                                     , @"pagination": @(pagination)
                                                     , @"pageCount": @(pageCount)
                                                     , @"myUserID": @([ZCPUserCenter sharedInstance].currentUserModel.userId)}
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
 *  得到某个人收藏的图书贴列表
 *  @param currUserID 当前用户ID
 *  @param pagination 页码
 *  @param pageCount  一页数量
 */
- (NSOperation *)getBookpostCollectionListWithCurrUserID:(NSInteger) currUserID
                                              pagination:(NSInteger) pagination
                                               pageCount:(NSInteger) pageCount
                                                 success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel))success
                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(BOOKPOST_COLLECTION_LIST_BY_USERID);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currUserID": @(currUserID)
                                                     , @"pagination": @(pagination)
                                                     , @"pageCount": @(pageCount)
                                                     , @"myUserID": @([ZCPUserCenter sharedInstance].currentUserModel.userId)}
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
 *  得到图书贴的评论列表
 *
 *  @param bookpostID 图书贴ID
 *  @param currUserID 当前用户ID
 *  @param pagination 页码
 *  @param pageCount  一页数量
 */
- (NSOperation *)getBookpostCommentListWithBookpostID:(NSInteger) bookpostID
                                           currUserID:(NSInteger) currUserID
                                           pagination:(NSInteger) pagination
                                            pageCount:(NSInteger) pageCount
                                              success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostCommentListModel))success
                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(BOOKPOSTCOMMENT_LIST_BY_BOOKPOSTID);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"bookpostID": @(bookpostID)
                                                     , @"currUserID": @(currUserID)
                                                     , @"pagination": @(pagination)
                                                     , @"pageCount": @(pageCount)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   ZCPListDataModel *model = [ZCPRequestResponseTranslator translateResponse_BookPostCommentListModel:[responseObject objectForKey:@"data"]];
                                                   success(operation, model);
                                               }
                                           }
                                           failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  得到图书贴的评论回复列表
 *
 *  @param bookpostCommentID    图书贴评论ID
 *  @param currUserID           当前用户ID
 *  @param pagination           页码
 *  @param pageCount            一页数量
 */
- (NSOperation *)getBookpostCommentReplyListWithBookpostCommentID:(NSInteger) bookpostCommentID
                                                       currUserID:(NSInteger) currUserID
                                                       pagination:(NSInteger) pagination
                                                        pageCount:(NSInteger) pageCount
                                                          success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *replyListModel))success
                                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(BOOKPOSTCOMMENTREPLY_LIST_BY_BOOKPOSTCOMMENTID);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"bookpostCommentID": @(bookpostCommentID)
                                                     , @"currUserID": @(currUserID)
                                                     , @"pagination": @(pagination)
                                                     , @"pageCount": @(pageCount)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   ZCPListDataModel *model = [ZCPRequestResponseTranslator translateResponse_BookPostCommentReplyListModel:[responseObject objectForKey:@"data"]];
                                                   success(operation, model);
                                               }
                                           }
                                           failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  改变图书贴点赞状态
 *
 *  @param currSupported    当前点赞状态
 *  @param currBookpostID   当前图书贴ID
 *  @param currUserID       当前用户ID
 */
- (NSOperation *)changeBookpostCurrSupportState:(NSInteger)currSupported
                                 currBookpostID:(NSInteger)currBookpostID
                                     currUserID:(NSInteger)currUserID
                                        success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(CHANGE_BOOKPOST_SUPPORT_STATE);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currSupported": @(currSupported)
                                                     , @"currBookpostID": @(currBookpostID)
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
 *  改变图书贴收藏状态
 *
 *  @param currCollected    当前收藏状态
 *  @param currBookpostID   当前图书贴ID
 *  @param currUserID       当前用户ID
 */
- (NSOperation *)changeBookpostCurrCollectionState:(NSInteger)currCollected
                                    currBookpostID:(NSInteger)currBookpostID
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
                                                   success(operation, [[responseObject valueForKey:@"result"] boolValue]);
                                               }
                                           }
                                           failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  改变图书贴评论点赞状态
 *
 *  @param currSupported            当前点赞状态
 *  @param currBookpostCommentID    当前图书贴评论ID
 *  @param currUserID               当前用户ID
 */
- (NSOperation *)changeBookpostCommentCurrSupportState:(NSInteger)currSupported
                                 currBookpostCommentID:(NSInteger)currBookpostCommentID
                                            currUserID:(NSInteger)currUserID
                                               success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(CHANGE_BOOKPOSTCOMMENT_SUPPORT_STATE);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currSupported": @(currSupported)
                                                     , @"currBookpostCommentID": @(currBookpostCommentID)
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
 *  改变图书贴评论回复点赞状态
 *
 *  @param currSupported                当前点赞状态
 *  @param currBookpostCommentReplyID   当前图书贴评论回复ID
 *  @param currUserID                   当前用户ID
 */
- (NSOperation *)changeBookpostCommentReplyCurrSupportState:(NSInteger)currSupported
                                 currBookpostCommentReplyID:(NSInteger)currBookpostCommentReplyID
                                                 currUserID:(NSInteger)currUserID
                                                    success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(CHANGE_BOOKPOSTCOMMENTREPLY_SUPPORT_STATE);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currSupported": @(currSupported)
                                                     , @"currBookpostCommentReplyID": @(currBookpostCommentReplyID)
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
 *  添加图书贴
 *
 *  @param title    标题
 *  @param content  内容
 *  @param bookName 相关书籍名
 */
- (NSOperation *)addBookpostWithBookpostTitle:(NSString *)bookpostTitle
                              bookpostContent:(NSString *)bookpostContent
                             bookpostBookName:(NSString *)bookpostBookName
                                   currUserID:(NSInteger)currUserID
                                      fieldID:(NSInteger)fieldID
                              success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(ADD_BOOKPOST);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"bookpostTitle": bookpostTitle
                                                     , @"bookpostContent": bookpostContent
                                                     , @"bookpostBookName": bookpostBookName
                                                     , @"currUserID": @(currUserID)
                                                     , @"fieldID": @(fieldID)}
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
 *  添加图书贴评论
 *
 *  @param bookpostCommentContent   图书贴评论内容
 *  @param bookpostID               图书贴ID
 *  @param currUserID               当前用户ID
 */
- (NSOperation *)addBookpostCommentWithBookpostCommentContent:(NSString *)bookpostCommentContent
                                                   bookpostID:(NSInteger)bookpostID
                                                   currUserID:(NSInteger)currUserID
                                                      success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(ADD_BOOKPOSTCOMMENT);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"bookpostCommentContent": bookpostCommentContent
                                                     , @"bookpostID": @(bookpostID)
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
 *  添加图书贴评论回复
 *
 *  @param bookpostCommentReplyContent 图书贴评论内容
 *  @param bookpostCommentID           图书贴ID
 *  @param currUserID                  当前用户ID
 *  @param respondentID                被回复人
 */
- (NSOperation *)addBookpostCommentReplyWithBookpostCommentReplyContent:(NSString *)bookpostCommentReplyContent
                                                          isReplyAuthor:(BOOL)isReplyAuthor
                                                      bookpostCommentID:(NSInteger)bookpostCommentID
                                                             currUserID:(NSInteger)currUserID
                                                             receiverID:(NSInteger)receiverID
                                                                success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(ADD_BOOKPOSTCOMMENTREPLY);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"bookpostCommentReplyContent": bookpostCommentReplyContent
                                                     , @"isReplyAuthor": @(isReplyAuthor)
                                                     , @"bookpostCommentID": @(bookpostCommentID)
                                                     , @"currUserID": @(currUserID)
                                                     , @"receiverID": @(receiverID)}
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
