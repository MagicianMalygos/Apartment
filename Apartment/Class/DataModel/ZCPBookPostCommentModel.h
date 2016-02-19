//
//  ZCPBookPostCommentModel.h
//  Apartment
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPDataModel.h"

#import "ZCPUserModel.h"
#import "ZCPBookPostModel.h"

// 用户点赞状态
typedef NS_ENUM(BOOL, BPCommentSupportState){
    CurrentUserNotSupportBPComment = NO,   //未点赞
    CurrentUserSupportBPComment = YES       //已点赞
};
// 用户收藏状态
typedef NS_ENUM(NSInteger, BPCommentCollectState){
    CurrentUserNotCollectBPComment,   //未收藏
    CurrentUsercollectBPComment       //已收藏
};

@interface ZCPBookPostCommentModel : ZCPDataModel

@property (nonatomic, assign) NSInteger commentId;              // 图书贴评论表编号
@property (nonatomic, copy) NSString *commentContent;           // 评论内容
@property (nonatomic, copy) NSString *commentPosition;          // 评论人定位位置(评论人评论时所在的GPS定位位置)
@property (nonatomic, assign) NSInteger commentSupport;         // 评论点赞量
@property (nonatomic, strong) NSDate *commentTime;              // 评论时间
@property (nonatomic, strong) ZCPUserModel *user;               // 评论人
@property (nonatomic, strong) ZCPBookPostModel *bookpost;       // 所评论的帖子
@property (nonatomic ,assign) NSInteger commentReplyNumber;     // 回复数量
@property(nonatomic,assign) BPCommentSupportState supported;    // 当前用户是否已经点过赞
@property(nonatomic,assign) BPCommentCollectState collected;    // 当前用户是否已经收藏

@end
