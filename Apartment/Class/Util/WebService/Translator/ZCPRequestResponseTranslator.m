//
//  ZCPRequestResponseTranslator.m
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestResponseTranslator.h"

@implementation ZCPRequestResponseTranslator

/**
 *  用户模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 用户模型
 */
+ (ZCPUserModel *)translateResponse_UserModel:(NSDictionary *)responseData {
    ZCPUserModel *model = nil;
    
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPUserModel modelFromDictionary:responseData];
    }
    return model;
}
/**
 *  密保问题模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 密保问题模型
 */
+ (ZCPSecurityQuestionModel *)translateResponse_SecurityQuestionModel:(NSDictionary *)responseData {
    ZCPSecurityQuestionModel *model = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPSecurityQuestionModel modelFromDictionary:responseData];
    }
    return model;
}
/**
 *  领域模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 领域模型
 */
+ (ZCPFieldModel *)translateResponse_FieldModel:(NSDictionary *)responseData {
    ZCPFieldModel *model = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPFieldModel modelFromDictionary:responseData];
    }
    return model;
}
/**
 *  状态模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 状态模型
 */
+ (ZCPStateModel *)translateResponse_StateModel:(NSDictionary *)responseData {
    ZCPStateModel *model = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPStateModel modelFromDictionary:responseData];
    }
    return model;
}


/**
 *  问题模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 问题模型
 */
+ (ZCPQuestionModel *)translateResponse_QuestionModel:(NSDictionary *)responseData {
    ZCPQuestionModel *model = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPQuestionModel modelFromDictionary:responseData];
    }
    return model;
}

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
 *  对联模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 对联模型
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
 *  对联模型转换
 *
 *  @param responseData 属性字典
 *
 *  @return 对联模型
 */
+ (ZCPBookPostCommentReplyModel *)translateResponse_BookPostCommentReplyModel:(NSDictionary *)responseData {
    ZCPBookPostCommentReplyModel *model = nil;
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPBookPostCommentReplyModel modelFromDictionary:responseData];
    }
    return model;
}

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
