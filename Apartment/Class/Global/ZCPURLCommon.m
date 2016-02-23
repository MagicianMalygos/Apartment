//
//  ZCPURLCommon.m
//  Apartment
//
//  Created by apple on 16/2/16.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPURLCommon.h"

// 协议 + host + path
NSString *ZCPMakeURLString(NSString *scheme, NSString *host, NSString *path) {
    scheme = scheme ? scheme : @"http";
    return [NSString stringWithFormat:@"%@://%@%@",scheme, host, path];
}

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

// 获取图片
#define URL_IMAGE_PATH(key, imageName)       [NSString stringWithFormat:@"/1.0/Application/Home/Images/%@/%@", key, imageName]
// 获取图片地址
NSString * imageGetURL(NSString * key,NSString * imageName) {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = URL_IMAGE_PATH(key, imageName);
    
    return ZCPMakeURLString(scheme, host, path);
}
// 获取封面图片地址
NSString * coverImageGetURL(NSString * imageName) {
    return imageGetURL(@"Cover", imageName);
}
// 获取头像图片地址
NSString * headImageGetURL(NSString * imageName) {
    return imageGetURL(@"Head", imageName);
}


@implementation ZCPURLCommon

@synthesize urlMaps = _urlMaps;

IMP_SINGLETON

- (void)initialize {
    TTDPRINT(@"Load: = = = = api map = = = =");
    self.urlMaps = @{
                     FIELD_LIST:                                @"/1.0/common/getField"
                     /* - 热门动态相关 - */
                     /* - 观点交流相关 - */
                     , BOOKPOST_LIST_BY_SORTMETHOD_FIELD:       @"/1.0/communion/getBookpostBySortMethodFieldId"
                     , OLD_BOOKPOST_LIST_BY_SORTMETHOD_FIELD:   @"/1.0/communion/getBookpostByOldId"
                     , BOOKPOST_LIST_BY_SEARCHTEXT:             @"/1.0/communion/getBookpostBySearchText"
                     /* - 文趣活动相关(Couplet) - */
                     , COUPLET_LIST_BY_TIME:                    @"/1.0/activity/getCoupletByTime"
                     , OLD_COUPLET_LIST_BY_TIME:                @"/1.0/activity/getCoupletByTimeAndOldId"
                     , COUPLET_LIST_BY_SUPPORT:                 @"/1.0/activity/getCoupletBySupport"
                     , ADD_COUPLET:                             @"/1.0/activity/addCouplet"
                     , COUPLET_REPLY_LIST:                      @"/1.0/activity/getCoupletReplyByCoupletId"
                     , ADD_COUPLET_REPLY:                       @"/1.0/activity/addCoupletReply"
                     , CHANGE_COUPLET_SUPPORT_STATE:            @"/1.0/activity/changeCoupletSupportRecord"
                     , CHANGE_COUPLET_COLLECTION_STATE:         @"/1.0/activity/changeCoupletCollectionRecord"
                     , CHANGE_COUPLET_REPLY_SUPPORT_STATE:      @"/1.0/activity/changeCoupletReplySupportRecord"
                     /* - 文趣活动相关(Thesis) - */
                     , CURRENT_THESIS:                          @"/1.0/activity/getCurrThesis"
                     , ARGUMENT_LIST_BY_BELONG:                 @"/1.0/activity/getArgumentByBelong"
                     , OLD_ARGUMENT_LIST:                       @"/1.0/activity/getArgumentByOldId"
                     , ADD_THESIS:                              @"/1.0/activity/addThesis"
                     , ADD_ARGUMENT:                            @"/1.0/activity/addArgument"
                     , CHANGE_THESIS_COLLECTION_STATE:          @"/1.0/activity/changeThesisCollectionRecord"
                     , CHANGE_ARGUMENT_SUPPORT_STATE:           @"/1.0/activity/changeArgumentSupportRecord"
                     /* - 图书馆相关 - */
                     /* - 个人中心相关 - */
                     };

}

@end
