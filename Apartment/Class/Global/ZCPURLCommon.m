//
//  ZCPURLCommon.m
//  Apartment
//
//  Created by apple on 16/2/16.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPURLCommon.h"

// 根据Type获取相应的协议
NSString *  schemeForType(NSString *type) {
    NSString * scheme = nil;
    
    if ([type isEqualToString:kURLTypeCommon]) {
        scheme = @"http";
    }
    else if ([type isEqualToString:kSchemeTypeSecurity]) {
    }
    
    return scheme;
}
// 根据Type获取相应的host
NSString *  hostForType(NSString *type) {
    NSString *host = nil;
    if ([type isEqualToString:kURLTypeCommon]) {
//        host = @"127.0.0.1:8888";
        host = @"localhost:8888";
    }
    return host;
}
// 根据key获取相应的path
NSString *  urlForKey(NSString *urlKey) {
    NSString * url  = [ZCPURLCommon sharedInstance].urlMaps[urlKey];
    if (url == nil) {
        @throw [NSException exceptionWithName:@"API_NOT_EXISTS" reason:[NSString stringWithFormat:@"urlKey's url is nil (%@)", urlKey] userInfo:nil];
    }
    return url;
}

@implementation ZCPURLCommon

@synthesize urlMaps = _urlMaps;

IMP_SINGLETON

- (void)initialize {
    TTDPRINT(@"Load: = = = = api map = = = =");
    self.urlMaps = @{COUPLET_LIST_BY_TIME: @"/1.0/activity/getCoupletByTime"
                     , COUPLET_LIST_BY_SUPPORT: @"/1.0/activity/getCoupletBySupport"
                     };
}

@end
