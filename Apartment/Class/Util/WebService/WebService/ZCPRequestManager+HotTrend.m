//
//  ZCPRequestManager+HotTrend.m
//  Apartment
//
//  Created by apple on 16/4/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestManager+HotTrend.h"
#import "ZCPRequestResponseTranslator+Communion.h"

@implementation ZCPRequestManager (HotTrend)

/**
 *  得到热门交流贴
 *
 *  @param currUserID 当前用户ID
 *  @param pagination 页码
 *  @param pageCount  一页数量
 */
- (NSOperation *)getHotBookpostListWithCurrUserID:(NSInteger) currUserID
                                       pagination:(NSInteger) pagination
                                        pageCount:(NSInteger) pageCount
                                          success:(void (^)(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel))success
                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(GET_HOT_BOOKPOST);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:@{@"currUserID": @(currUserID)
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

@end
