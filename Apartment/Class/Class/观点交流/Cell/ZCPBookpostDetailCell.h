//
//  ZCPBookpostDetailCell.h
//  Apartment
//
//  Created by apple on 16/3/30.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"
#import "ZCPBookPostModel.h"

@class ZCPBookpostDetailCellItem;
@protocol ZCPBookpostDetailCellDelegate;

@interface ZCPBookpostDetailCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UILabel *bpTitleLabel;                    // 图书贴标题标签
@property (nonatomic, strong) UILabel *bpContentLabel;                  // 图书贴内容标签
@property (nonatomic, strong) UILabel *bpTimeLabel;                     // 发帖时间标签
@property (nonatomic, strong) UILabel *uploaderLabel;                   // 发帖人标签
@property (nonatomic, strong) UILabel *fieldLabel;                      // 所属类型标签
@property (nonatomic, strong) UILabel *bookNameLabel;                   // 相关书籍标签
@property (nonatomic, strong) UILabel *supportNumberLabel;              // 点赞量标签
@property (nonatomic, strong) UILabel *collectionNumberLabel;           // 收藏人数标签
@property (nonatomic, strong) UILabel *replyNumberLabel;                // 回复人数标签
@property (nonatomic, strong) UIButton *commentButton;                  // 评论按钮
@property (nonatomic, strong) UIButton *collectionButton;               // 收藏按钮
@property (nonatomic, strong) UIButton *supportButton;                  // 点赞按钮
@property (nonatomic, strong) ZCPBookpostDetailCellItem *item;          // item
@property (nonatomic, weak) id<ZCPBookpostDetailCellDelegate> delegate; // delegate

@end

@interface ZCPBookpostDetailCellItem : ZCPDataModel

@property (nonatomic, strong) ZCPBookPostModel *bookpostModel;          // 图书贴模型
@property (nonatomic, weak) id<ZCPBookpostDetailCellDelegate> delegate; // delegate

@end

@protocol ZCPBookpostDetailCellDelegate <NSObject>

// 点赞按钮点击响应事件
- (void)bookpostDetailCell:(ZCPBookpostDetailCell *)cell supportButtonClicked:(UIButton *)button;
// 收藏按钮点击响应事件
- (void)bookpostDetailCell:(ZCPBookpostDetailCell *)cell collectButtonClicked:(UIButton *)button;
// 评论按钮点击响应事件
- (void)bookpostDetailCell:(ZCPBookpostDetailCell *)cell commentButtonClicked:(UIButton *)button;

@end