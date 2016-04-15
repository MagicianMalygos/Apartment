//
//  ZCPRequestManager+HotTrend.h
//  Apartment
//
//  Created by apple on 16/4/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestManager.h"

@interface ZCPRequestManager (HotTrend)

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
                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
