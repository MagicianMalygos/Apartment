//
//  ZCPArgumentModel.h
//  Apartment
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPDataModel.h"

#import "ZCPThesisModel.h"
#import "ZCPUserModel.h"
#import "ZCPStateModel.h"

// 论点点赞状态
typedef NS_ENUM(NSInteger, ZCPArgumentSupportState) {
    ZCPCurrUserNotSupportArgument = 0,  // 未点赞
    ZCPCurrUserHaveSupportArgument = 1  // 已点赞
};
// 论点所属正反方
typedef NS_ENUM(NSInteger, ZCPArgumentBelong) {
    ZCPConsArgument = 0,
    ZCPProsArgument = 1
};
// 论点是否匿名(有点问题：是先获取的论据信息再去判断的是否匿名，如果别人使用了接口查看获取到的数据其实是能看到论据发表人的信息的)
typedef NS_ENUM(NSInteger, ZCPArgumentAnonymousState) {
    ZCPArgumentAnonymous = 0,   // 匿名
    ZCPArgumentNormal = 1       // 不匿名
};

@interface ZCPArgumentModel : ZCPDataModel

@property (nonatomic, assign) int argumentId;                       // 论据表编号
@property (nonatomic, copy) NSString *argumentContent;              // 论据内容
@property (nonatomic, assign) int argumentSupport;                  // 点赞量
@property (nonatomic, assign) int argumentBelong;                   // 所属正反方
@property (nonatomic, strong) NSDate *argumentTime;                 // 记录添加时间
@property (nonatomic, strong) ZCPThesisModel *thesis;               // 所属辩题
@property (nonatomic, strong) ZCPUserModel *user;                   // 辩题人
@property (nonatomic, strong) ZCPStateModel *state;                 // 匿名状态

@property (nonatomic, assign) ZCPArgumentSupportState supported;    // 当前用户是否已经点过赞

@end
