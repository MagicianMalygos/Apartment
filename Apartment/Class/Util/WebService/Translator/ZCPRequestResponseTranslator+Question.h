//
//  ZCPRequestResponseTranslator+Question.h
//  Apartment
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestResponseTranslator.h"

@interface ZCPRequestResponseTranslator (Question)

// 问题模型转换
+ (ZCPQuestionModel *)translateResponse_QuestionModel:(NSDictionary *)dict;
// 问题列表模型转换
+ (ZCPListDataModel *)translateResponse_QuestionListModel:(NSDictionary *)responseData;

@end
