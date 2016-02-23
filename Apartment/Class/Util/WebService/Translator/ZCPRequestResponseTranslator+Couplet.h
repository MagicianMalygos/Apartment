//
//  ZCPRequestResponseTranslator+Couplet.h
//  Apartment
//
//  Created by apple on 16/2/17.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestResponseTranslator.h"

@interface ZCPRequestResponseTranslator (Couplet)

// 对联模型转换
+ (ZCPCoupletModel *)translateResponse_CoupletModel:(NSDictionary *)dict;
// 对联回复模型转换
+ (ZCPCoupletReplyModel *)translateResponse_CoupletReplyModel:(NSDictionary *)dict;
// 对联列表模型转换
+ (ZCPListDataModel *)translateResponse_CoupletListModel:(NSDictionary *)dict;
// 对联回复列表模型转换
+ (ZCPListDataModel *)translateResponse_CoupletReplyListModel:(NSDictionary *)responseData;

@end
