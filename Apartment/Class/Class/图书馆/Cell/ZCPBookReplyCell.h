//
//  ZCPBookReplyCell.h
//  Apartment
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"
#import "ZCPBookReplyModel.h"

@class ZCPBookReplyCellItem;
@protocol ZCPBookReplyCellDelegate;

@interface ZCPBookReplyCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UIImageView *userHeadImageView;               // 用户头像视图
@property (nonatomic, strong) UILabel *userNameLabel;                       // 用户名标签
@property (nonatomic, strong) UILabel *bookreplyContentLabel;               // 回复内容标签
@property (nonatomic, strong) UILabel *bookreplyTiemLabel;                  // 回复时间标签
@property (nonatomic, strong) UILabel *bookreplySupportLabel;               // 点赞量标签
@property (nonatomic, strong) UIButton *supportButton;                      // 点赞按钮
@property (nonatomic, strong) ZCPBookReplyCellItem *item;                   // item
@property (nonatomic, weak) id<ZCPBookReplyCellDelegate> delegate;          // delegate

@end

@interface ZCPBookReplyCellItem : ZCPDataModel

@property (nonatomic, strong) ZCPBookReplyModel *bookReplyModel;            // 图书回复模型
@property (nonatomic, weak) id<ZCPBookReplyCellDelegate> delegate;          // delegate

@end

@protocol ZCPBookReplyCellDelegate <NSObject>

// 点赞按钮点击事件
- (void)bookReplyCell:(ZCPBookReplyCell *)cell supportButtonClick:(UIButton *)button;

@end
