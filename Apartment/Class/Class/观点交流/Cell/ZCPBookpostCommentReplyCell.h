//
//  ZCPBookpostCommentReplyCell.h
//  Apartment
//
//  Created by apple on 16/4/4.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"
#import "ZCPBookPostCommentReplyModel.h"

@class ZCPBookpostCommentReplyCellItem;
@protocol ZCPBookpostCommentReplyCellDelegate;

@interface ZCPBookpostCommentReplyCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UIImageView *userHeadImageView;           // 用户头像视图
@property (nonatomic, strong) UILabel *userNameLabel;                   // 用户名标签
@property (nonatomic, strong) UILabel *replyTimeLabel;                  // 回复时间标签
@property (nonatomic, strong) UILabel *replyContentLabel;               // 回复内容标签
@property (nonatomic, strong) UIButton *supportButton;                  // 点赞按钮
@property (nonatomic, strong) UILabel *supportNumberLabel;              // 点赞人数标签
@property (nonatomic, strong) ZCPBookpostCommentReplyCellItem *item;    // item

@end

@interface ZCPBookpostCommentReplyCellItem : ZCPDataModel

@property (nonatomic, strong) ZCPBookPostCommentReplyModel *replyModel;         // 回复模型
@property (nonatomic, weak) id<ZCPBookpostCommentReplyCellDelegate> delegate;   // delegate

@end

@protocol ZCPBookpostCommentReplyCellDelegate <NSObject>

// 点赞按钮点击响应事件
- (void)bookpostCommentReplyCell:(ZCPBookpostCommentReplyCell *)cell supportButtonClicked:(UIButton *)button;

@end