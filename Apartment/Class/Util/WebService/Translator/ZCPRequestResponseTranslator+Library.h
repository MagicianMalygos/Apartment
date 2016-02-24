//
//  ZCPRequestResponseTranslator+Library.h
//  Apartment
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestResponseTranslator.h"

@interface ZCPRequestResponseTranslator (Library)

// 图书模型转换
+ (ZCPBookModel *)translateResponse_BookModel:(NSDictionary *)dict;
// 图书回复模型转换
+ (ZCPBookReplyModel *)translateResponse_BookReplyModel:(NSDictionary *)dict;

// 图书列表模型转换
+ (ZCPListDataModel *)translateResponse_BookListModel:(NSDictionary *)responseData;

@end
