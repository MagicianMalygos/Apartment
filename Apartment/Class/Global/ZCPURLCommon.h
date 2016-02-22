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
#pragma mark - - - - - - 热门动态相关

#pragma mark - - - - - - 观点交流相关
#define BOOKPOST_LIST_BY_SORTMETHOD_FIELD                       @"BOOKPOST_LIST_BY_SORTMETHOD_FIELD"
#define OLD_BOOKPOST_LIST_BY_SORTMETHOD_FIELD                   @"OLD_BOOKPOST_LIST_BY_SORTMETHOD_FIELD"
#define BOOKPOST_LIST_BY_SEARCHTEXT                             @"BOOKPOST_LIST_BY_SEARCHTEXT"

#pragma mark - - - - - - 文趣活动相关(Couplet)
#define COUPLET_LIST_BY_TIME                                    @"COUPLET_LIST_BY_TIME"
#define OLD_COUPLET_LIST_BY_TIME                                @"OLD_COUPLET_LIST_BY_TIME"
#define COUPLET_LIST_BY_SUPPORT                                 @"COUPLET_LIST_BY_SUPPORT"
#define COUPLET_REPLY_LIST                                      @"COUPLET_REPLY_LIST"
#define ADD_COUPLET                                             @"ADD_COUPLET"
#define ADD_COUPLET_REPLY                                       @"ADD_COUPLET_REPLY"
#define CHANGE_COUPLET_SUPPORT_STATE                            @"CHANGE_COUPLET_SUPPORT_STATE"
#define CHANGE_COUPLET_COLLECTION_STATE                         @"CHANGE_COUPLET_COLLECTION_STATE"
#define CHANGE_COUPLET_REPLY_SUPPORT_STATE                      @"CHANGE_COUPLET_REPLY_SUPPORT_STATE"
#pragma mark - - - - - - 文趣活动相关(Thesis)
#define CURRENT_THESIS                                          @"CURRENT_THESIS"
#define ARGUMENT_LIST_BY_BELONG                                 @"ARGUMENT_LIST_BY_BELONG"
#define OLD_ARGUMENT_LIST                                       @"OLD_ARGUMENT_LIST"
#define ADD_THESIS                                              @"ADD_THESIS"
#define ADD_ARGUMENT                                            @"ADD_ARGUMENT"
#define CHANGE_THESIS_COLLECTION_STATE                          @"CHANGE_THESIS_COLLECTION_STATE"
#define CHANGE_ARGUMENT_SUPPORT_STATE                           @"CHANGE_ARGUMENT_SUPPORT_STATE"

#pragma mark - - - - - - 图书馆相关
#pragma mark - - - - - - 个人中心相关

// 根据Type获取相应的协议
NSString *  schemeForType(NSString *type);
// 根据Type获取相应的host
NSString *  hostForType(NSString *type);
// 根据key获取相应的path
NSString *  urlForKey(NSString *urlKey);


@interface ZCPURLCommon : NSObject

@property (nonatomic, strong) NSDictionary *urlMaps;

DEF_SINGLETON(ZCPURLCommon)

- (void)initialize;

@end
