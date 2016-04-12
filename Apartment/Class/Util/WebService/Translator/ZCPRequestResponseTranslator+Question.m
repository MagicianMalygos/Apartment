//
//  ZCPRequestResponseTranslator+Question.m
//  Apartment
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestResponseTranslator+Question.h"

@implementation ZCPRequestResponseTranslator (Question)

/**
 *  问题模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 问题模型
 */
+ (ZCPQuestionModel *)translateResponse_QuestionModel:(NSDictionary *)responseData {
    ZCPQuestionModel *model = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPQuestionModel modelFromDictionary:responseData];
    }
    return model;
}

/**
 *  问题列表模型转换
 *
 *  @param responseData 列表字典
 *
 *  @return 问题列表模型
 */
+ (ZCPListDataModel *)translateResponse_QuestionListModel:(NSDictionary *)responseData {
    ZCPListDataModel *listModel = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        listModel = [[ZCPListDataModel alloc] init];
        NSArray *questionList = [responseData valueForKey:@"aList"];
        if (![questionList isNilOrNull]) {
            for (NSDictionary *questionDict in questionList) {
                ZCPQuestionModel *model = [ZCPRequestResponseTranslator translateResponse_QuestionModel:questionDict];
                [listModel.items addObject:model];
            }
        }
    }
    return listModel;
}
@end
