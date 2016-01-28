//
//  ZCPRequestResponseTranslator.h
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZCPUserModel.h"
#import "ZCPCoupletModel.h"
#import "ZCPCoupletReplyModel.h"
#import "ZCPThesisModel.h"

#import "ZCPArgumentModel.h"
#import "ZCPBookModel.h"
#import "ZCPFieldModel.h"
#import "ZCPQuestionModel.h"
#import "ZCPBookPostModel.h"
#import "ZCPBookPostCommentModel.h"
#import "ZCPBookReplyModel.h"
#import "ZCPBookPostCommentReplyModel.h"
#import "ZCPSecurityQuestionModel.h"
#import "ZCPStateModel.h"


@interface ZCPRequestResponseTranslator : NSObject

// 用户模型转换
+ (ZCPUserModel *)translateResponse_UserModel:(NSDictionary *)dict;
// 密保问题模型转换
+ (ZCPSecurityQuestionModel *)translateResponse_SecurityQuestionModel:(NSDictionary *)dict;
// 领域模型转换
+ (ZCPFieldModel *)translateResponse_FieldModel:(NSDictionary *)dict;
// 状态模型转换
+ (ZCPStateModel *)translateResponse_StateModel:(NSDictionary *)dict;

// 对联模型转换
+ (ZCPCoupletModel *)translateResponse_CoupletModel:(NSDictionary *)dict;
// 对联回复模型转换
+ (ZCPCoupletReplyModel *)translateResponse_CoupletReplyModel:(NSDictionary *)dict;

// 辩题模型转换
+ (ZCPThesisModel *)translateResponse_ThesisModel:(NSDictionary *)dict;
// 论据模型转换
+ (ZCPArgumentModel *)translateResponse_ArgumentModel:(NSDictionary *)dict;

// 问题模型转换
+ (ZCPQuestionModel *)translateResponse_QuestionModel:(NSDictionary *)dict;

// 图书贴模型转换
+ (ZCPBookPostModel *)translateResponse_BookPostModel:(NSDictionary *)dict;
// 图书贴评论模型转换
+ (ZCPBookPostCommentModel *)translateResponse_BookPostCommentModel:(NSDictionary *)dict;
// 图书贴评论回复模型转换
+ (ZCPBookPostCommentReplyModel *)translateResponse_BookPostCommentReplyModel:(NSDictionary *)dict;

// 图书模型转换
+ (ZCPBookModel *)translateResponse_BookModel:(NSDictionary *)dict;
// 图书回复模型转换
+ (ZCPBookReplyModel *)translateResponse_BookReplyModel:(NSDictionary *)dict;


@end
