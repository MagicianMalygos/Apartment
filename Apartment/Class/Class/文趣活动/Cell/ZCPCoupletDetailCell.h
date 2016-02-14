//
//  ZCPCoupletDetailCell.h
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"

@class ZCPCoupletDetailCellItem;

// 对联详情Cell
@interface ZCPCoupletDetailCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UIButton *commentButton;          // 评论按钮
@property (nonatomic, strong) UIButton *collectionButton;       // 收藏按钮
@property (nonatomic, strong) UIButton *supportButton;          // 点赞按钮
@property (nonatomic, strong) UILabel *coupletContentLabel;     // 对联内容
@property (nonatomic, strong) UIImageView *userHeadImgView;     // 用户头像
@property (nonatomic, strong) UILabel *userNameLabel;           // 用户名
@property (nonatomic, strong) UILabel *timeLabel;               // 对联发布时间
@property (nonatomic, strong) ZCPCoupletDetailCellItem *item;   // item

@end

// 对联详情CellItem
@interface ZCPCoupletDetailCellItem : ZCPDataModel

@property (nonatomic, copy) NSString *coupletContent;
@property (nonatomic, copy) NSString *userHeadImageURL;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, strong) NSDate *time;
@property (nonatomic, assign) NSInteger *supportNumber;

@end
