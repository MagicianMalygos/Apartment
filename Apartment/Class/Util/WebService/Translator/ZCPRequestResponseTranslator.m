//
//  ZCPRequestResponseTranslator.m
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestResponseTranslator.h"

@implementation ZCPRequestResponseTranslator

/**
 *  用户模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 用户模型
 */
+ (ZCPUserModel *)translateResponse_UserModel:(NSDictionary *)responseData {
    ZCPUserModel *model = nil;
    
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPUserModel modelFromDictionary:responseData];
    }
    return model;
}
/**
 *  密保问题模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 密保问题模型
 */
+ (ZCPSecurityQuestionModel *)translateResponse_SecurityQuestionModel:(NSDictionary *)responseData {
    ZCPSecurityQuestionModel *model = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPSecurityQuestionModel modelFromDictionary:responseData];
    }
    return model;
}
/**
 *  领域模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 领域模型
 */
+ (ZCPFieldModel *)translateResponse_FieldModel:(NSDictionary *)responseData {
    ZCPFieldModel *model = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPFieldModel modelFromDictionary:responseData];
    }
    return model;
}
/**
 *  状态模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 状态模型
 */
+ (ZCPStateModel *)translateResponse_StateModel:(NSDictionary *)responseData {
    ZCPStateModel *model = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPStateModel modelFromDictionary:responseData];
    }
    return model;
}

/**
 *  领域列表模型转换
 *
 *  @param responseData 数据字典
 *
 *  @return 领域列表模型
 */
+ (ZCPListDataModel *)translateResponse_FieldListModel:(NSDictionary *)responseData {
    ZCPListDataModel *listModel = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        listModel = [[ZCPListDataModel alloc] init];
        NSArray *fieldList = [responseData valueForKey:@"aList"];
        if (![fieldList isNilOrNull]) {
            for (NSDictionary *fieldDict in fieldList) {
                ZCPFieldModel *model = [ZCPRequestResponseTranslator translateResponse_FieldModel:fieldDict];
                [listModel.items addObject:model];
            }
        }
    }
    return listModel;
}

@end
