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
 *  得到某个人发表的图书列表
 *  @param currUserID 当前用户ID
 *  @param pagination 页码
 *  @param pageCount  一页数量
 */
- (NSOperation *)getBookListWithCurrUserID:(NSInteger) currUserID
                                pagination:(NSInteger) pagination
                                 pageCount:(NSInteger) pageCount
                                   success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *bookListModel))success
                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  得到某个人收藏的图书列表
 *  @param currUserID 当前用户ID
 *  @param pagination 页码
 *  @param pageCount  一页数量
 */
- (NSOperation *)getBookCollectionListWithCurrUserID:(NSInteger) currUserID
                                          pagination:(NSInteger) pagination
                                           pageCount:(NSInteger) pageCount
                                             success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *bookListModel))success
                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  添加图书
 *
 *  @param coverImage      封面图片
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
                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
