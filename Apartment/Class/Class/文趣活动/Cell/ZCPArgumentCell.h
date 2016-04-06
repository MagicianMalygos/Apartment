//
//  ZCPArgumentCell.h
//  Apartment
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"

#import "ZCPArgumentModel.h"

@class ZCPArgumentCellItem;
@protocol ZCPArgumentCellDelegate;

// 论据Cell
@interface ZCPArgumentCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UIImageView *userHeadImgView;         // 用户头像标签
@property (nonatomic, strong) UILabel *userNameLabel;               // 用户名标签
@property (nonatomic, strong) UILabel *supportNumberLabel;          // 点赞人数标签
@property (nonatomic, strong) UIButton *supportButton;              // 点赞按钮
@property (nonatomic, strong) UILabel *argumentContentLabel;        // 论据内容标签
@property (nonatomic, strong) UILabel *timeLabel;                   // 论据发布时间标签
@property (nonatomic, strong) ZCPArgumentCellItem *item;            // item
@property (nonatomic, weak) id<ZCPArgumentCellDelegate> delegate;   // delegate

@end

// 论据CellItem
@interface ZCPArgumentCellItem : ZCPDataModel

@property (nonatomic, strong) ZCPArgumentModel *argumentModel;      // 论据模型
@property (nonatomic, weak) id<ZCPArgumentCellDelegate> delegate;   // delegate

@end

@protocol ZCPArgumentCellDelegate <NSObject>

// 点赞按钮点击响应事件
- (void)argumentCell:(ZCPArgumentCell *)cell supportButtonClicked:(UIButton *)button;

@end