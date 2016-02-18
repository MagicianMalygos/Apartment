//
//  ZCPRequestResponseTranslator+Couplet.m
//  Apartment
//
//  Created by apple on 16/2/17.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestResponseTranslator+Couplet.h"

@implementation ZCPRequestResponseTranslator (Couplet)


/**
 *  对联模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 对联模型
 */
+ (ZCPCoupletModel *)translateResponse_CoupletModel:(NSDictionary *)responseData {
    ZCPCoupletModel *model = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPCoupletModel modelFromDictionary:responseData];
    }
    return model;
}
/**
 *  对联回复模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 对联回复模型
 */
+ (ZCPCoupletReplyModel *)translateResponse_CoupletReplyModel:(NSDictionary *)responseData {
    ZCPCoupletReplyModel *model = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPCoupletReplyModel modelFromDictionary:responseData];
    }
    return model;
}
/**
 *  对联列表模型转换
 *
 *  @param responseData 列表字典
 *
 *  @return 对联列表模型
 */
+ (ZCPListDataModel *)translateResponse_CoupletModel_List:(NSDictionary *)responseData {
    ZCPListDataModel *listModel = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        listModel = [[ZCPListDataModel alloc] init];
        NSArray *coupletList = [responseData valueForKey:@"aList"];
        if (![coupletList isNilOrNull]) {
            for (NSDictionary *coupletDict in coupletList) {
                ZCPCoupletModel *model = [ZCPRequestResponseTranslator translateResponse_CoupletModel:coupletDict];
                [listModel.items addObject:model];
            }
        }
    }
    return listModel;
}
/**
 *  对联回复列表模型转换
 *
 *  @param responseData 列表字典
 *
 *  @return 对联回复列表模型
 */
+ (ZCPListDataModel *)translateResponse_CoupletReplyModel_List:(NSDictionary *)responseData {
    ZCPListDataModel *listModel = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        listModel = [[ZCPListDataModel alloc] init];
        NSArray *coupletReplyList = [responseData valueForKey:@"aList"];
        if (![coupletReplyList isNilOrNull]) {
            for (NSDictionary *coupletReplyDict in coupletReplyList) {
                ZCPCoupletReplyModel *model = [ZCPRequestResponseTranslator translateResponse_CoupletReplyModel:coupletReplyDict];
                [listModel.items addObject:model];
            }
        }
    }
    return listModel;
}

@end
