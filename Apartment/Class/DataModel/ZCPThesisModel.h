//
//  ZCPThesisModel.h
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPDataModel.h"

#import "ZCPStateModel.h"

typedef NS_ENUM(NSInteger, ZCPThesisCollectState) {
    ZCPCurrUserNotCollectThesis = 0,  // 未收藏
    ZCPCurrUserHaveCollectThesis = 1  // 已收藏
};

@interface ZCPThesisModel : ZCPDataModel

@property (nonatomic, assign) int thesisId;                         // 辩题表编号
@property (nonatomic, copy) NSString *thesisContent;                // 辩题内容
@property (nonatomic, copy) NSString *thesisPros;                   // 正方论点
@property (nonatomic, assign) int thesisProsCount;                  // 正方支持人数
@property (nonatomic, assign) int thesisProsReplyNumber;            // 正方回复人数
@property (nonatomic, copy) NSString *thesisCons;                   // 反方论点
@property (nonatomic, assign) int thesisConsCount;                  // 反方支持人数
@property (nonatomic, assign) int thesisConsReplyNumber;            // 反方回复人数
@property (nonatomic, assign) int thesisCollectNumber;              // 收藏辩题人数
@property (nonatomic, strong) NSDate *thesisStartTime;              // 辩题开始时间
@property (nonatomic, strong) NSDate *thesisEndTime;                // 辩题结束时间
@property (nonatomic, strong) NSDate *thesisTime;                   // 记录添加时间
@property (nonatomic, strong) ZCPStateModel *state;                 // 辩题状态

@property (nonatomic, assign) ZCPThesisCollectState collected;      // 当前用户是否已经收藏该辩题

@end
