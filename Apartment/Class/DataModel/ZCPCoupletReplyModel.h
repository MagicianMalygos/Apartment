//
//  ZCPCoupletReplyModel.h
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPDataModel.h"

#import "ZCPUserModel.h"
#import "ZCPCoupletModel.h"

typedef NS_ENUM(NSInteger, ZCPCoupletReplySupportState) {
    ZCPCurrUserNotSupportCoupletReply = 0,  // 未点赞
    ZCPCurrUserHaveSupportCoupletReply = 1  // 已点赞
};

@interface ZCPCoupletReplyModel : ZCPDataModel

@property (nonatomic, assign) NSInteger replyId;                        // 对联回复表编号
@property (nonatomic, copy) NSString *replyContent;                     // 回复内容
@property (nonatomic, assign) NSInteger replySupport;                   // 回复点赞量
@property (nonatomic, strong) NSDate *replyTime;                        // 回复时间
@property (nonatomic, strong) ZCPCoupletModel *couplet;                 // 所回复的对联
@property (nonatomic, strong) ZCPUserModel *user;                       // 回复人
@property (nonatomic, assign) ZCPCoupletReplySupportState supported;    // 当前用户是否已经点过赞

@end
