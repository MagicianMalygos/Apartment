//
//  ZCPBookPostCommentReplyModel.h
//  Apartment
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPDataModel.h"

#import "ZCPUserModel.h"
#import "ZCPBookPostCommentModel.h"

typedef NS_ENUM(NSInteger, ZCPBookpostCommentReplySupportState){
    ZCPCurrUserNotSupportBookpostCommentReply,  //未点赞
    ZCPCurrUserHaveSupportBookpostCommentReply  //已点赞
};

@interface ZCPBookPostCommentReplyModel : ZCPDataModel

@property (nonatomic, assign) NSInteger replyId;                                // 图书评论回复表编号
@property (nonatomic, copy) NSString *replyContent;                             // 回复内容
@property (nonatomic, assign) BOOL isReplyAuthor;                               // 是否是直接对作者进行的回复
@property (nonatomic, assign) NSInteger replySupport;                           // 回复点赞量
@property (nonatomic, strong) NSDate *replyTime;                                // 回复时间
@property (nonatomic, strong) ZCPUserModel *user;                               // 回复人
@property (nonatomic, strong) ZCPUserModel *receiver;                           // 回复接收人(是回复此条评论的任意一人，不仅只是评论的作者)
@property (nonatomic, strong) ZCPBookPostCommentModel *comment;                 // 所回复的评论
@property(nonatomic, assign) ZCPBookpostCommentReplySupportState  supported;    // 当前用户是否已经点过赞

@end
