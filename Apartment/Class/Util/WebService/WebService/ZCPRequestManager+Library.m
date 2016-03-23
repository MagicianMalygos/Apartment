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
- (NSOperation *)getBookListWithSearchText:(NSString *)searchText
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
 *  得到图书回复列表
 *
 *  @param currBookID   当前对联ID
 *  @param currUserID   当前用户ID
 *  @param pagination   页码
 *  @param pageCount    一页数量
 */
- (NSOperation *)getBookReplyListWithCurrBookID:(NSInteger)currBookID
                                     currUserID:(NSInteger)currUserID
                                     pagination:(NSInteger)pagination
                                      pageCount:(NSInteger)pageCount
                                        success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *bookReplyListModel))success
                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(BOOK_REPLY_LIST);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currBookID": @(currBookID)
                                                     , @"currUserID": @(currUserID)
                                                     , @"pagination": @(pagination)
                                                     , @"pageCount":@(pageCount)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   ZCPListDataModel *model = [ZCPRequestResponseTranslator translateResponse_BookReplyListModel:[responseObject objectForKey:@"data"]];
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
                                    currBookID:(NSInteger)currBookID
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
                                                   success(operation, [[responseObject valueForKey:@"result"] boolValue]);
                                               }
                                           } failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  改变图书回复点赞状态
 *
 *  @param currSupported    当前点赞状态
 *  @param currBookReplyID  当前图书ID
 *  @param currUserID       当前用户ID
 */
- (NSOperation *)changeBookReplyCurrSupportState:(NSInteger)currSupported
                                 currBookReplyID:(NSInteger)currBookReplyID
                                      currUserID:(NSInteger)currUserID
                                         success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(CHANGE_BOOK_REPLY_SUPPORT_STATE);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currSupported": @(currSupported)
                                                     , @"currBookReplyID": @(currBookReplyID)
                                                     , @"currUserID": @(currUserID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   success(operation, [[responseObject valueForKey:@"result"] boolValue]);
                                               }
                                           } failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  添加图书
 *
 *  @param imageData       封面图片数据
 *  @param bookName        书名
 *  @param bookAuthor      作者
 *  @param bookPublisher   出版社
 *  @param bookPublishTime 出版日期
 *  @param fieldID         领域ID
 *  @param bookSummary     简介
 *  @param currUserID      当前用户ID
 */
- (NSOperation *)addBookCoverImage:(UIImage *)coverImage
                              bookName:(NSString *)bookName
                            bookAuthor:(NSString *)bookAuthor
                         bookPublisher:(NSString *)bookPublisher
                       bookPublishTime:(NSString *)bookPublishTime
                           bookSummary:(NSString *)bookSummary
                               fieldID:(NSInteger)fieldID
                            currUserID:(NSInteger)currUserID
                               success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(ADD_BOOK);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"bookName": bookName
                                                     , @"bookAuthor": bookAuthor
                                                     , @"bookPublisher": bookPublisher
                                                     , @"bookPublishTime": bookPublishTime
                                                     , @"bookSummary": bookSummary
                                                     , @"fieldID": @(fieldID)
                                                     , @"currUserID": @(currUserID)}
                         constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                             
                             NSString *fileName = nil;
                             NSString *mimeType = nil;
                             NSString *extension = nil;
                             
                             NSData *coverImageData = nil;
                             if ((coverImageData = UIImageJPEGRepresentation(coverImage, 0.5f))) {
                                 mimeType = @"image/jpeg";
                                 extension = @".jpeg";
                             } else {
                                 coverImageData = UIImagePNGRepresentation(coverImage);
                                 mimeType = @"image/png";
                                 extension = @".png";
                             }
                             fileName = [NSString stringWithFormat:@"%@%u%@", [NSString stringFromDate:[NSDate new] withDateFormat:@"yyyyMMddHHmmss"], (arc4random() % 9000 + 1000), extension];
                             
                             [formData appendPartWithFileData:coverImageData    // 文件data
                                                         name:@"cover"          // php获取参数名
                                                     fileName:fileName          // 文件名
                                                     mimeType:mimeType];        // 文件类型
                         } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             if (success) {
                                 success(operation, [[responseObject valueForKey:@"result"] boolValue]);
                             }
                         } failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

/**
 *  添加图书回复
 *
 *  @param bookReplyContent 对联回复内容
 *  @param currBookID       回复对联ID
 *  @param currUserID       当前用户ID
 */
- (NSOperation *)addBookReplyContent:(NSString *)bookReplyContent
                          currBookID:(NSInteger)currBookID
                          currUserID:(NSInteger)currUserID
                             success:(void (^)(AFHTTPRequestOperation *operation, BOOL isSuccess))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(ADD_BOOK_REPLY);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"bookReplyContent": bookReplyContent
                                                     , @"currBookID": @(currBookID)
                                                     , @"currUserID": @(currUserID)}
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   success(operation, [[responseObject valueForKey:@"result"] boolValue]);
                                               }
                                           } failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

@end
