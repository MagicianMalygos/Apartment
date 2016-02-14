//
//  ZCPRequestManager+Couplet.m
//  Apartment
//
//  Created by apple on 16/2/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestManager+Couplet.h"

#import "ZCPRequestResponseTranslator.h"

@implementation ZCPRequestManager (Couplet)

/**
 *  得到按时间排序的对联列表
 *
 *  @param pageCount  一页数量
 *  @param currUserId 当前用户ID
 *  @param success
 *  @param failure
 *
 *  @return
 */
- (NSOperation *)getCoupletListByTimeWithPageCount:(NSInteger)pageCount
                                        currUserId:(NSInteger)currUserId
                                           success:(void (^)(AFHTTPRequestOperation *, ZCPDataModel *))success
                                           failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    NSOperation *operation = [self GET:@"" parameters:@{@"pageCount":@(pageCount)
                                                        , @"currUserId":@(currUserId)}
                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                   if (success) {
                                       ZCPDataModel *model = [ZCPRequestResponseTranslator translateResponse_CoupletModel_List:[responseObject objectForKey:@"data"]];
                                       success(operation, model);
                                   }
                               }
                               failure:failure];
    TTDPRINT(@"request=%@", operation);
    return operation;
}

@end
