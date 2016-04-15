//
//  ZCPBookpostCommentDetailCell.h
//  Apartment
//
//  Created by apple on 16/4/4.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"
#import "ZCPBookPostCommentModel.h"

@class ZCPBookpostCommentDetailCellItem;
@protocol ZCPBookpostCommentDetailCellDelegate;

@interface ZCPBookpostCommentDetailCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UIImageView *userHeadImageView;           // 用户头像视图
@property (nonatomic, strong) UILabel *userNameLabel;                   // 用户名标签
@property (nonatomic, strong) UIButton *replyButton;                    // 回复按钮
@property (nonatomic, strong) UIButton *supportButton;                  // 点赞按钮
@property (nonatomic, strong) UILabel *commentContentLabel;             // 评论内容标签
@property (nonatomic, strong) UILabel *commentTimeLabel;                // 评论时间
@property (nonatomic, strong) ZCPBookpostCommentDetailCellItem *item;   // item

@end

@interface ZCPBookpostCommentDetailCellItem : ZCPDataModel

@property (nonatomic, strong) ZCPBookPostCommentModel *bookpostCommentModel;    // 评论模型
@property (nonatomic, weak) id<ZCPBookpostCommentDetailCellDelegate> delegate;  // delegate

@end

@protocol ZCPBookpostCommentDetailCellDelegate <NSObject>
// 回复按钮点击响应事件
- (void)bookpostCommentDetailCell:(ZCPBookpostCommentDetailCell *)cell replyButtonClicked:(UIButton *)button;
// 点赞按钮点击响应事件
- (void)bookpostCommentDetailCell:(ZCPBookpostCommentDetailCell *)cell supportButtonClicked:(UIButton *)button;

@end