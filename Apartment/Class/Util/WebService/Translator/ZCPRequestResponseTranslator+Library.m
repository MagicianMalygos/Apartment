//
//  ZCPRequestResponseTranslator+Library.m
//  Apartment
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestResponseTranslator+Library.h"

@implementation ZCPRequestResponseTranslator (Library)

/**
 *  图书模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 图书模型
 */
+ (ZCPBookModel *)translateResponse_BookModel:(NSDictionary *)responseData {
    ZCPBookModel *model = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPBookModel modelFromDictionary:responseData];
    }
    return model;
}
/**
 *  图书回复模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 图书回复模型
 */
+ (ZCPBookReplyModel *)translateResponse_BookReplyModel:(NSDictionary *)responseData {
    ZCPBookReplyModel *model = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPBookReplyModel modelFromDictionary:responseData];
    }
    return model;
}

/**
 *  图书列表模型转换
 *
 *  @param responseData 列表字典
 *
 *  @return 图书列表模型
 */
+ (ZCPListDataModel *)translateResponse_BookListModel:(NSDictionary *)responseData {
    ZCPListDataModel *listModel = [[ZCPListDataModel alloc] init];
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        listModel = [[ZCPListDataModel alloc] init];
        NSArray *bookList = [responseData valueForKey:@"aList"];
        if (![bookList isNilOrNull]) {
            for (NSDictionary *bookDict in bookList) {
                ZCPBookModel *model = [ZCPRequestResponseTranslator translateResponse_BookModel:bookDict];
                [listModel.items addObject:model];
            }
        }
    }
    return listModel;
}

/**
 *  图书回复列表模型转换
 *
 *  @param responseData 列表字典
 *
 *  @return 图书回复列表模型
 */
+ (ZCPListDataModel *)translateResponse_BookReplyListModel:(NSDictionary *)responseData {
    ZCPListDataModel *listModel = [[ZCPListDataModel alloc] init];
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        listModel = [[ZCPListDataModel alloc] init];
        NSArray *bookreplyList = [responseData valueForKey:@"aList"];
        if (![bookreplyList isNilOrNull]) {
            for (NSDictionary *booreplyDict in bookreplyList) {
                ZCPBookReplyModel *model = [ZCPRequestResponseTranslator translateResponse_BookReplyModel:booreplyDict];
                [listModel.items addObject:model];
            }
        }
    }
    return listModel;
}

@end
