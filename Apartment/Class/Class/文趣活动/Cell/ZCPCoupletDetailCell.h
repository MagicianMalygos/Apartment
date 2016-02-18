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

@property (nonatomic, copy) NSString *coupletContent;                       // 对联内容
@property (nonatomic, assign) ZCPCoupletSupportState coupletSupported;      // 对联点赞状态
@property (nonatomic, assign) ZCPCoupletCollectState coupletCollected;      // 对联收藏状态
@property (nonatomic, copy) NSString *userHeadImageURL;                     // 用户头像URL
@property (nonatomic, copy) NSString *userName;                             // 用户名
@property (nonatomic, strong) NSDate *time;                                 // 发布时间
@property (nonatomic, assign) NSInteger *supportNumber;                     // 点赞量
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
