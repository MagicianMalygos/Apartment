//
//  ZCPRequestResponseTranslator+Thesis.h
//  Apartment
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestResponseTranslator.h"

@interface ZCPRequestResponseTranslator (Thesis)

// 辩题模型转换
+ (ZCPThesisModel *)translateResponse_ThesisModel:(NSDictionary *)dict;
// 论据模型转换
+ (ZCPArgumentModel *)translateResponse_ArgumentModel:(NSDictionary *)dict;
// 当前辩题模型转换
+ (NSDictionary *)translateResponse_CurrThesisAndArgument:(NSDictionary *)dict;
// 论据列表模型转换
+ (ZCPListDataModel *)translateResponse_ArgumentListModel:(NSDictionary *)responseData;

@end
