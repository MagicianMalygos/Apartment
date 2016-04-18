//
//  ZCPRequestResponseTranslator+Thesis.m
//  Apartment
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestResponseTranslator+Thesis.h"

@implementation ZCPRequestResponseTranslator (Thesis)


/**
 *  辩题模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 辩题模型
 */
+ (ZCPThesisModel *)translateResponse_ThesisModel:(NSDictionary *)responseData {
    ZCPThesisModel *model = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPThesisModel modelFromDictionary:responseData];
    }
    return model;
}
/**
 *  论据模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 论据模型
 */
+ (ZCPArgumentModel *)translateResponse_ArgumentModel:(NSDictionary *)responseData {
    ZCPArgumentModel *model = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPArgumentModel modelFromDictionary:responseData];
    }
    return model;
}
//
/**
 *  当前辩题模型转换
 *
 *  @param dict 辩题与一个正方一个反方论据组成的字典
 *
 *  @return 辩题模型与一个正方模型一个反方论据模型组成的字典
 */
+ (NSDictionary *)translateResponse_CurrThesisAndArgument:(NSDictionary *)dict {
    NSMutableDictionary *translateResult = [NSMutableDictionary dictionary];
    
    if (![[dict valueForKey:@"currThesis"] isNilOrNull]) {
        [translateResult setObject:[ZCPThesisModel modelFromDictionary:[dict valueForKey:@"currThesis"]] forKey:@"currThesisModel"];
    }
    if (![[dict valueForKey:@"prosArgument"] isNilOrNull]) {
        [translateResult setObject:[ZCPArgumentModel modelFromDictionary:[dict valueForKey:@"prosArgument"]] forKey:@"prosArgumentModel"];
    }
    if (![[dict valueForKey:@"consArgument"] isNilOrNull]) {
        [translateResult setObject:[ZCPArgumentModel modelFromDictionary:[dict valueForKey:@"consArgument"]] forKey:@"consArgumentModel"];
    }
    return translateResult;
}

/**
 *  论据列表模型转换
 *
 *  @param dict 列表字典
 *
 *  @return 论据模型列表
 */
+ (ZCPListDataModel *)translateResponse_ThesisListModel:(NSDictionary *)responseData {
    ZCPListDataModel *listModel = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        listModel = [[ZCPListDataModel alloc] init];
        NSArray *thesisList = [responseData valueForKey:@"aList"];
        if (![thesisList isNilOrNull]) {
            for (NSDictionary *thesisDict in thesisList) {
                ZCPThesisModel *model = [ZCPRequestResponseTranslator translateResponse_ThesisModel:thesisDict];
                [listModel.items addObject:model];
            }
        }
    }
    return listModel;
}

/**
 *  论据列表模型转换
 *
 *  @param dict 列表字典
 *
 *  @return 论据模型列表
 */
+ (ZCPListDataModel *)translateResponse_ArgumentListModel:(NSDictionary *)responseData {
    ZCPListDataModel *listModel = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        listModel = [[ZCPListDataModel alloc] init];
        NSArray *argumentList = [responseData valueForKey:@"aList"];
        if (![argumentList isNilOrNull]) {
            for (NSDictionary *argumentDict in argumentList) {
                ZCPArgumentModel *model = [ZCPRequestResponseTranslator translateResponse_ArgumentModel:argumentDict];
                [listModel.items addObject:model];
            }
        }
    }
    return listModel;
}


@end
