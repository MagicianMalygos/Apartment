//
//  ZCPRequestResponseTranslator.h
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZCPListDataModel.h"
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
#import "ZCPStateModel.h"


@interface ZCPRequestResponseTranslator : NSObject

// 用户模型转换
+ (ZCPUserModel *)translateResponse_UserModel:(NSDictionary *)dict;
// 领域模型转换
+ (ZCPFieldModel *)translateResponse_FieldModel:(NSDictionary *)dict;
// 状态模型转换
+ (ZCPStateModel *)translateResponse_StateModel:(NSDictionary *)dict;

// 领域模型转换
+ (ZCPListDataModel *)translateResponse_FieldListModel:(NSDictionary *)responseData;
// 用户模型列表转换
+ (ZCPListDataModel *)translateResponse_UserListModel:(NSDictionary *)responseData;

@end
