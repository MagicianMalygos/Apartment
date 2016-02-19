//
//  ZCPCoupletModel.h
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPDataModel.h"

#import "ZCPUserModel.h"

// 点赞状态
typedef NS_ENUM(NSInteger, ZCPCoupletSupportState) {
    ZCPCurrUserNotSupportCouplet = 0,  // 未点赞
    ZCPCurrUserHaveSupportCouplet = 1  // 已点赞
};
// 收藏状态
typedef NS_ENUM(NSInteger, ZCPCoupletCollectState) {
    ZCPCurrUserNotCollectCouplet = 0,  // 未收藏
    ZCPCurrUserHaveCollectCouplet = 1  // 已收藏
};

@interface ZCPCoupletModel : ZCPDataModel

@property (nonatomic, assign) NSInteger coupletId;                  // 对联表编号
@property (nonatomic, copy) NSString *coupletContent;               // 对联内容
@property (nonatomic, assign) NSInteger coupletReplyNumber;         // 回复人数
@property (nonatomic, assign) NSInteger coupletCollectNumber;       // 收藏对联人数
@property (nonatomic, assign) NSInteger coupletSupport;             // 点赞量
@property (nonatomic, strong) NSDate *coupletTime;                  // 出对时间
@property (nonatomic, strong) ZCPUserModel *user;                   // 出对人
@property (nonatomic, assign) ZCPCoupletSupportState supported;     // 当前用户是否已经点过赞
@property (nonatomic, assign) ZCPCoupletCollectState collected;     // 当前用户是否已经收藏该对联

@end
