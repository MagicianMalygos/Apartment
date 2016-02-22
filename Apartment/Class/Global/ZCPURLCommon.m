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
    self.urlMaps = @{
                     /* - 热门动态相关 - */
                     /* - 观点交流相关 - */
                     BOOKPOST_LIST_BY_SORTMETHOD_FIELD:         @"/1.0/communion/getBookpostBySortMethodFieldId"
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
