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

@end
