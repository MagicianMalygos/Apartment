//
//  ZCPURLCommon.h
//  Apartment
//
//  Created by apple on 16/2/16.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>


// 通用host
#define kURLTypeCommon                                          @"__url_common__"
// 需要加密
#define kSchemeTypeSecurity                                     @"__scheme_security__"

#pragma mark - - - - - - API PATH KEY - - - - - -
#define FIELD_LIST                                              @"FIELD_LIST"

#pragma mark - - - - - - 登录注册相关
#define LOGIN                                                   @"LOGIN"
#define ACCOUNT_CAN_BE_REGISTER                                 @"ACCOUNT_CAN_BE_REGISTER"
#define REGISTER                                                @"REGISTER"
#define RESET_PASSWORD                                          @"RESET_PASSWORD"

#pragma mark - - - - - - 热门动态相关
#define GET_HOT_BOOKPOST                                        @"GET_HOT_BOOKPOST"
#define GET_HOT_BOOKPOSTCOMMENT                                 @"GET_HOT_BOOKPOSTCOMMENT"

#pragma mark - - - - - - 观点交流相关
#define BOOKPOST_LIST_BY_MULTI_CONDITION                        @"BOOKPOST_LIST_BY_MULTI_CONDITION"
#define BOOKPOST_LIST_BY_USERID                                 @"BOOKPOST_LIST_BY_USERID"
#define BOOKPOST_COLLECTION_LIST_BY_USERID                      @"BOOKPOST_COLLECTION_LIST_BY_USERID"
#define BOOKPOSTCOMMENT_LIST_BY_BOOKPOSTID                      @"BOOKPOSTCOMMENT_LIST_BY_BOOKPOSTID"
#define BOOKPOSTCOMMENTREPLY_LIST_BY_BOOKPOSTCOMMENTID          @"BOOKPOSTCOMMENTREPLY_LIST_BY_BOOKPOSTCOMMENTID"
#define CHANGE_BOOKPOST_SUPPORT_STATE                           @"CHANGE_BOOKPOST_SUPPORT_STATE"
#define CHANGE_BOOKPOST_COLLECTION_STATE                        @"CHANGE_BOOKPOST_COLLECTION_STATE"
#define CHANGE_BOOKPOSTCOMMENT_SUPPORT_STATE                    @"CHANGE_BOOKPOSTCOMMENT_SUPPORT_STATE"
#define CHANGE_BOOKPOSTCOMMENTREPLY_SUPPORT_STATE               @"CHANGE_BOOKPOSTCOMMENTREPLY_SUPPORT_STATE"
#define ADD_BOOKPOST                                            @"ADD_BOOKPOST"
#define ADD_BOOKPOSTCOMMENT                                     @"ADD_BOOKPOSTCOMMENT"
#define ADD_BOOKPOSTCOMMENTREPLY                                @"ADD_BOOKPOSTCOMMENTREPLY"

#pragma mark - - - - - - 文趣活动相关(Couplet)
#define COUPLET_LIST_BY_MULTI_CONDITION                         @"COUPLET_LIST_BY_MULTI_CONDITION"
#define COUPLET_LIST_BY_USERID                                  @"COUPLET_LIST_BY_USERID"
#define COUPLET_COLLECTION_LIST_BY_USERID                       @"COUPLET_COLLECTION_LIST_BY_USERID"
#define COUPLET_REPLY_LIST                                      @"COUPLET_REPLY_LIST"
#define ADD_COUPLET                                             @"ADD_COUPLET"
#define ADD_COUPLET_REPLY                                       @"ADD_COUPLET_REPLY"
#define CHANGE_COUPLET_SUPPORT_STATE                            @"CHANGE_COUPLET_SUPPORT_STATE"
#define CHANGE_COUPLET_COLLECTION_STATE                         @"CHANGE_COUPLET_COLLECTION_STATE"
#define CHANGE_COUPLET_REPLY_SUPPORT_STATE                      @"CHANGE_COUPLET_REPLY_SUPPORT_STATE"
#pragma mark - - - - - - 文趣活动相关(Thesis)
#define CURRENT_THESIS                                          @"CURRENT_THESIS"
#define THESIS_LIST_BY_USERID                                   @"THESIS_LIST_BY_USERID"
#define THESIS_COLLECTION_LIST_BY_USERID                        @"THESIS_COLLECTION_LIST_BY_USERID"
#define ARGUMENT_LIST_BY_BELONG                                 @"ARGUMENT_LIST_BY_BELONG"
#define ADD_THESIS                                              @"ADD_THESIS"
#define ADD_ARGUMENT                                            @"ADD_ARGUMENT"
#define CHANGE_THESIS_COLLECTION_STATE                          @"CHANGE_THESIS_COLLECTION_STATE"
#define CHANGE_ARGUMENT_SUPPORT_STATE                           @"CHANGE_ARGUMENT_SUPPORT_STATE"
#pragma mark - - - - - - 文趣活动相关(Question)
#define QUESTION_LIST                                           @"QUESTION_LIST"
#define QUESTION_LIST_BY_USERID                                 @"QUESTION_LIST_BY_USERID"
#define QUESTION_COLLECTION_LIST_BY_USERID                      @"QUESTION_COLLECTION_LIST_BY_USERID"
#define USER_ANSWER_RECORD                                      @"USER_ANSWER_RECORD"
#define SUBMIT_QUESTION_ANSWERS                                 @"SUBMIT_QUESTION_ANSWERS"
#define ADD_QUESTION                                            @"ADD_QUESTION"
#define CHANGE_QUESTION_COLLECTION_STATE                        @"CHANGE_QUESTION_COLLECTION_STATE"

#pragma mark - - - - - - 图书馆相关
#define BOOK_LIST                                               @"BOOK_LIST"
#define BOOK_LIST_BY_USERID                                     @"BOOK_LIST_BY_USERID"
#define BOOK_COLLECTION_LIST_BY_USERID                          @"BOOK_COLLECTION_LIST_BY_USERID"
#define BOOK_REPLY_LIST                                         @"BOOK_REPLY_LIST"
#define ADD_BOOK                                                @"ADD_BOOK"
#define ADD_BOOK_REPLY                                          @"ADD_BOOK_REPLY"
#define CHANGE_BOOK_COLLECTION_STATE                            @"CHANGE_BOOK_COLLECTION_STATE"
#define CHANGE_BOOK_REPLY_SUPPORT_STATE                         @"CHANGE_BOOK_REPLY_SUPPORT_STATE"

#pragma mark - - - - - - 个人中心相关
#define UPLOAD_HEAD                                             @"UPLOAD_HEAD"
#define MODIFY_USER_INFO                                        @"MODIFY_USER_INFO"
#define MODIFY_USER_PASSWORD                                    @"MODIFY_USER_PASSWORD"
#define COLLECTED_USER_LIST                                     @"COLLECTED_USER_LIST"
#define CHANGE_USER_COLLECTION_STATE                            @"CHANGE_USER_COLLECTION_STATE"
#define JUDGE_USER_COLLECT_OTHERUSER                            @"JUDGE_USER_COLLECT_OTHERUSER"

// 协议 + host + path
NSString *  ZCPMakeURLString(NSString *scheme, NSString *host, NSString *path);
// 根据Type获取相应的协议
NSString *  schemeForType(NSString *type);
// 根据Type获取相应的host
NSString *  hostForType(NSString *type);
// 根据key获取相应的path
NSString *  urlForKey(NSString *urlKey);

// 获取图片地址
NSString * imageGetURL(NSString * key,NSString * imageName);
// 获取封面图片地址
NSString * coverImageGetURL(NSString * imageName);
// 获取头像图片地址
NSString * headImageGetURL(NSString * imageName);
// 获取广告图片地址
NSString * advertisementGetURL(NSString * imageName);



@interface ZCPURLCommon : NSObject

@property (nonatomic, strong) NSDictionary *urlMaps;

DEF_SINGLETON(ZCPURLCommon)

- (void)initialize;

@end
