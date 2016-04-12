//
//  ZCPQuestionModel.h
//  Apartment
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPDataModel.h"

#import "ZCPUserModel.h"
#import "ZCPStateModel.h"

// 用户收藏问题状态
typedef NS_ENUM(NSInteger, ZCPQuestionCollectState) {
    ZCPCurrUserNotCollectQuestion = 0,  // 未收藏
    ZCPCurrUserHaveCollectQuestion = 1  // 已收藏
};

@interface ZCPQuestionModel : ZCPDataModel

@property (nonatomic, assign) NSInteger questionId;                 // 题目表编号
@property (nonatomic, copy) NSString *questionContent;              // 题目内容
@property (nonatomic, copy) NSString *questionOptionOne;            // 选项一
@property (nonatomic, copy) NSString *questionOptionTwo;            // 选项二
@property (nonatomic, copy) NSString *questionOptionThree;          // 选项三
@property (nonatomic, copy) NSString *questionAnswer;               // 正确答案
@property (nonatomic, assign) NSInteger questionCollectNumber;      // 收藏题目人数
@property (nonatomic, copy) NSString *questionShowOrder;            // 选项展示顺序
@property (nonatomic, strong) NSDate *questionTime;                 // 记录添加时间
@property (nonatomic, strong) ZCPUserModel *user;                   // 出题人
@property (nonatomic, strong) ZCPStateModel *state;                 // 题目状态
@property (nonatomic, assign) ZCPQuestionCollectState collected;    // 当前用户是否收藏该问题
@property (nonatomic, strong) NSArray *optionSequence;              // 乱序后的选项数组

@end
