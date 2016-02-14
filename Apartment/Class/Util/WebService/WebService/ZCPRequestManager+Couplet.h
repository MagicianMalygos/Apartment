//
//  ZCPRequestManager+Couplet.h
//  Apartment
//
//  Created by apple on 16/2/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestManager.h"

@interface ZCPRequestManager (Couplet)

// 得到按时间排序的对联列表
- (NSOperation *)getCoupletListByTimeWithPageCount:(NSInteger)pageCount
                                        currUserId:(NSInteger)currUserId
                                           success:(void(^)(AFHTTPRequestOperation *operation, ZCPDataModel *model))success
                                           failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
