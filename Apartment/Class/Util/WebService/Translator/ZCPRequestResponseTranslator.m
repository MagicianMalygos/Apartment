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
 *  @param dict 属性字典
 *
 *  @return 用户模型
 */
+ (ZCPUserModel *)translateResponse_UserModel:(NSDictionary *)dict {
    ZCPUserModel *model = nil;
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPUserModel modelFromDictionary:dict];
    }
    return model;
}
/**
 *  密保问题模型转换
 *
 *  @param dict 属性字典
 *
 *  @return 密保问题模型
 */
+ (ZCPSecurityQuestionModel *)translateResponse_SecurityQuestionModel:(NSDictionary *)dict {
    ZCPSecurityQuestionModel *model = nil;
    if ([dict isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPSecurityQuestionModel modelFromDictionary:dict];
    }
    return model;
}
/**
 *  领域模型转换
 *
 *  @param dict 属性字典
 *
 *  @return 领域模型
 */
+ (ZCPFieldModel *)translateResponse_FieldModel:(NSDictionary *)dict {
    ZCPFieldModel *model = nil;
    if ([dict isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPFieldModel modelFromDictionary:dict];
    }
    return model;
}
/**
 *  状态模型转换
 *
 *  @param dict 属性字典
 *
 *  @return 状态模型
 */
+ (ZCPStateModel *)translateResponse_StateModel:(NSDictionary *)dict {
    ZCPStateModel *model = nil;
    if ([dict isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPStateModel modelFromDictionary:dict];
    }
    return model;
}

/**
 *  对联模型转换
 *
 *  @param dict 属性字典
 *
 *  @return 对联模型
 */
+ (ZCPCoupletModel *)translateResponse_CoupletModel:(NSDictionary *)dict {
    ZCPCoupletModel *model = nil;
    if ([dict isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPCoupletModel modelFromDictionary:dict];
    }
    return model;
}
/**
 *  对联回复模型转换
 *
 *  @param dict 属性字典
 *
 *  @return 对联回复模型
 */
+ (ZCPCoupletReplyModel *)translateResponse_CoupletReplyModel:(NSDictionary *)dict {
    ZCPCoupletReplyModel *model = nil;
    if ([dict isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPCoupletReplyModel modelFromDictionary:dict];
    }
    return model;
}
+ (ZCPListDataModel *)translateResponse_CoupletModel_List:(NSDictionary *)dict {
    ZCPListDataModel *listModel = nil;
    if ([dict isKindOfClass:[NSDictionary class]]) {
        listModel = [[ZCPListDataModel alloc] init];
    }
    return listModel;
}

/**
 *  辩题模型转换
 *
 *  @param dict 属性字典
 *
 *  @return 辩题模型
 */
+ (ZCPThesisModel *)translateResponse_ThesisModel:(NSDictionary *)dict {
    ZCPThesisModel *model = nil;
    if ([dict isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPThesisModel modelFromDictionary:dict];
    }
    return model;
}
/**
 *  论据模型转换
 *
 *  @param dict 属性字典
 *
 *  @return 论据模型
 */
+ (ZCPArgumentModel *)translateResponse_ArgumentModel:(NSDictionary *)dict {
    ZCPArgumentModel *model = nil;
    if ([dict isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPArgumentModel modelFromDictionary:dict];
    }
    return model;
}

/**
 *  问题模型转换
 *
 *  @param dict 属性字典
 *
 *  @return 问题模型
 */
+ (ZCPQuestionModel *)translateResponse_QuestionModel:(NSDictionary *)dict {
    ZCPQuestionModel *model = nil;
    if ([dict isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPQuestionModel modelFromDictionary:dict];
    }
    return model;
}

/**
 *  图书贴模型转换
 *
 *  @param dict 属性字典
 *
 *  @return 图书贴模型
 */
+ (ZCPBookPostModel *)translateResponse_BookPostModel:(NSDictionary *)dict {
    ZCPBookPostModel *model = nil;
    if ([dict isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPBookPostModel modelFromDictionary:dict];
    }
    return model;
}
/**
 *  对联模型转换
 *
 *  @param dict 属性字典
 *
 *  @return 对联模型
 */
+ (ZCPBookPostCommentModel *)translateResponse_BookPostCommentModel:(NSDictionary *)dict {
    ZCPBookPostCommentModel *model = nil;
    if ([dict isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPBookPostCommentModel modelFromDictionary:dict];
    }
    return model;
}
/**
 *  对联模型转换
 *
 *  @param dict 属性字典
 *
 *  @return 对联模型
 */
+ (ZCPBookPostCommentReplyModel *)translateResponse_BookPostCommentReplyModel:(NSDictionary *)dict {
    ZCPBookPostCommentReplyModel *model = nil;
    if ([dict isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPBookPostCommentReplyModel modelFromDictionary:dict];
    }
    return model;
}

/**
 *  图书模型转换
 *
 *  @param dict 属性字典
 *
 *  @return 图书模型
 */
+ (ZCPBookModel *)translateResponse_BookModel:(NSDictionary *)dict {
    ZCPBookModel *model = nil;
    if ([dict isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPBookModel modelFromDictionary:dict];
    }
    return model;
}
/**
 *  图书回复模型转换
 *
 *  @param dict 属性字典
 *
 *  @return 图书回复模型
 */
+ (ZCPBookReplyModel *)translateResponse_BookReplyModel:(NSDictionary *)dict {
    ZCPBookReplyModel *model = nil;
    if ([dict isKindOfClass:[NSDictionary class]]) {
        // 在此处写字典转模型代码
        model = [ZCPBookReplyModel modelFromDictionary:dict];
    }
    return model;
}

@end
