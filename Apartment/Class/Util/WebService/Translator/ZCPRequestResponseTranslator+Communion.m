//
//  ZCPRequestResponseTranslator+Communion.m
//  Apartment
//
//  Created by apple on 16/2/22.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestResponseTranslator+Communion.h"

@implementation ZCPRequestResponseTranslator (Communion)

/**
 *  图书贴模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 图书贴模型
 */
+ (ZCPBookPostModel *)translateResponse_BookPostModel:(NSDictionary *)responseData {
    ZCPBookPostModel *model = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPBookPostModel modelFromDictionary:responseData];
    }
    return model;
}
/**
 *  图书贴评论模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 图书贴评论模型
 */
+ (ZCPBookPostCommentModel *)translateResponse_BookPostCommentModel:(NSDictionary *)responseData {
    ZCPBookPostCommentModel *model = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPBookPostCommentModel modelFromDictionary:responseData];
    }
    return model;
}
/**
 *  图书贴评论回复模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 图书贴评论回复模型
 */
+ (ZCPBookPostCommentReplyModel *)translateResponse_BookPostCommentReplyModel:(NSDictionary *)responseData {
    ZCPBookPostCommentReplyModel *model = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPBookPostCommentReplyModel modelFromDictionary:responseData];
    }
    return model;
}
//
/**
 *  图书贴列表模型转换
 *
 *  @param dict 列表字典
 *
 *  @return 图书贴列表模型
 */
+ (ZCPListDataModel *)translateResponse_BookPostListModel:(NSDictionary *)responseData {
    ZCPListDataModel *listModel = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        listModel = [[ZCPListDataModel alloc] init];
        NSArray *bookpostList = [responseData valueForKey:@"aList"];
        if (![bookpostList isNilOrNull]) {
            for (NSDictionary *bookpostDict in bookpostList) {
                ZCPBookPostModel *model = [ZCPRequestResponseTranslator translateResponse_BookPostModel:bookpostDict];
                [listModel.items addObject:model];
            }
        }
    }
    return listModel;
}

@end
