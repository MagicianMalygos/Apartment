//
//  ZCPRequestResponseTranslator+Communion.h
//  Apartment
//
//  Created by apple on 16/2/22.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestResponseTranslator.h"

@interface ZCPRequestResponseTranslator (Communion)

// 图书贴模型转换
+ (ZCPBookPostModel *)translateResponse_BookPostModel:(NSDictionary *)dict;
// 图书贴评论模型转换
+ (ZCPBookPostCommentModel *)translateResponse_BookPostCommentModel:(NSDictionary *)dict;
// 图书贴评论回复模型转换
+ (ZCPBookPostCommentReplyModel *)translateResponse_BookPostCommentReplyModel:(NSDictionary *)dict;
// 图书贴列表模型转换
+ (ZCPListDataModel *)translateResponse_BookPostModel_List:(NSDictionary *)dict;

@end
