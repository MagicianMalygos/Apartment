//
//  ZCPArgumentCell.h
//  Apartment
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"

@class ZCPArgumentCellItem;

// 论据Cell
@interface ZCPArgumentCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UIImageView *userHeadImgView;   // 用户头像标签
@property (nonatomic, strong) UILabel *userNameLabel;         // 用户名标签
@property (nonatomic, strong) UILabel *supportNumberLabel;    // 点赞人数标签
@property (nonatomic, strong) UIButton *supportButton;        // 点赞按钮
@property (nonatomic, strong) UILabel *argumentContentLabel;  // 论据内容标签
@property (nonatomic, strong) UILabel *timeLabel;             // 论据发布时间标签
@property (nonatomic, strong) ZCPArgumentCellItem *item;      // item

@end

// 论据CellItem
@interface ZCPArgumentCellItem : ZCPDataModel

@property (nonatomic, copy) NSString *userHeadImgURL;         // 用户头像URL
@property (nonatomic, copy) NSString *userName;               // 用户名
@property (nonatomic, copy) NSString *argumentContent;        // 论据内容
@property (nonatomic, strong) NSDate *time;                   // 论据发布时间
@property (nonatomic, assign) NSInteger supportNumber;       // 点赞人数

@end