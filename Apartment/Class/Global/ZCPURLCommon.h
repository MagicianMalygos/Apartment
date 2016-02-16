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
#pragma mark - - - - - - 文趣活动相关
#define COUPLET_LIST_BY_TIME                                    @"COUPLET_LIST_BY_TIME"
#define COUPLET_LIST_BY_SUPPORT                                 @"COUPLET_LIST_BY_SUPPORT"

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
