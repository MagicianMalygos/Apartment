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

#pragma mark - - - - - - 热门动态相关

#pragma mark - - - - - - 观点交流相关
#define BOOKPOST_LIST_BY_MULTI_CONDITION                        @"BOOKPOST_LIST_BY_MULTI_CONDITION"
#define CHANGE_BOOKPOST_COLLECTION_STATE                        @"CHANGE_BOOKPOST_COLLECTION_STATE"

#pragma mark - - - - - - 文趣活动相关(Couplet)
#define COUPLET_LIST_BY_MULTI_CONDITION                         @"COUPLET_LIST_BY_MULTI_CONDITION"
#define COUPLET_REPLY_LIST                                      @"COUPLET_REPLY_LIST"
#define ADD_COUPLET                                             @"ADD_COUPLET"
#define ADD_COUPLET_REPLY                                       @"ADD_COUPLET_REPLY"
#define CHANGE_COUPLET_SUPPORT_STATE                            @"CHANGE_COUPLET_SUPPORT_STATE"
#define CHANGE_COUPLET_COLLECTION_STATE                         @"CHANGE_COUPLET_COLLECTION_STATE"
#define CHANGE_COUPLET_REPLY_SUPPORT_STATE                      @"CHANGE_COUPLET_REPLY_SUPPORT_STATE"
#pragma mark - - - - - - 文趣活动相关(Thesis)
#define CURRENT_THESIS                                          @"CURRENT_THESIS"
#define ARGUMENT_LIST_BY_BELONG                                 @"ARGUMENT_LIST_BY_BELONG"
#define ADD_THESIS                                              @"ADD_THESIS"
#define ADD_ARGUMENT                                            @"ADD_ARGUMENT"
#define CHANGE_THESIS_COLLECTION_STATE                          @"CHANGE_THESIS_COLLECTION_STATE"
#define CHANGE_ARGUMENT_SUPPORT_STATE                           @"CHANGE_ARGUMENT_SUPPORT_STATE"

#pragma mark - - - - - - 图书馆相关
#define BOOK_LIST                                               @"BOOK_LIST"
#define BOOK_REPLY_LIST                                         @"BOOK_REPLY_LIST"
#define ADD_BOOK                                                @"ADD_BOOK"
#define ADD_BOOK_REPLY                                          @"ADD_BOOK_REPLY"
#define CHANGE_BOOK_COLLECTION_STATE                            @"CHANGE_BOOK_COLLECTION_STATE"
#define CHANGE_BOOK_REPLY_SUPPORT_STATE                         @"CHANGE_BOOK_REPLY_SUPPORT_STATE"

#pragma mark - - - - - - 个人中心相关

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


@interface ZCPURLCommon : NSObject

@property (nonatomic, strong) NSDictionary *urlMaps;

DEF_SINGLETON(ZCPURLCommon)

- (void)initialize;

@end
