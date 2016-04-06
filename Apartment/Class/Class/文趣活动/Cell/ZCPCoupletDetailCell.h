//
//  ZCPCoupletDetailCell.h
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"

#import "ZCPCoupletModel.h"

@class ZCPCoupletDetailCellItem;
@protocol ZCPCoupletDetailCellDelegate;

// 对联详情Cell
@interface ZCPCoupletDetailCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UIButton *commentButton;                  // 评论按钮
@property (nonatomic, strong) UIButton *collectionButton;               // 收藏按钮
@property (nonatomic, strong) UIButton *supportButton;                  // 点赞按钮
@property (nonatomic, strong) UILabel *coupletContentLabel;             // 对联内容标签
@property (nonatomic, strong) UIImageView *userHeadImgView;             // 用户头像视图
@property (nonatomic, strong) UILabel *userNameLabel;                   // 用户名标签
@property (nonatomic, strong) UILabel *timeLabel;                       // 对联发布时间标签
@property (nonatomic, strong) ZCPCoupletDetailCellItem *item;           // item
@property (nonatomic, weak) id<ZCPCoupletDetailCellDelegate> delegate;  // delegate

@end

// 对联详情CellItem
@interface ZCPCoupletDetailCellItem : ZCPDataModel

@property (nonatomic, strong) ZCPCoupletModel *coupletModel;                // 对联模型
@property (nonatomic, weak) id<ZCPCoupletDetailCellDelegate> delegate;      // delegate

@end

@protocol ZCPCoupletDetailCellDelegate <NSObject>

// 评论按钮点击响应事件
- (void)coupletDetailCell:(ZCPCoupletDetailCell *)cell commentButtonClicked:(UIButton *)button;
// 收藏按钮点击响应事件
- (void)coupletDetailCell:(ZCPCoupletDetailCell *)cell collectButtonClicked:(UIButton *)button;
// 点赞按钮点击响应事件
- (void)coupletDetailCell:(ZCPCoupletDetailCell *)cell supportButtonClicked:(UIButton *)button;

@end
