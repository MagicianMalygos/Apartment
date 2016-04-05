//
//  ZCPCoupletMainCell.h
//  Apartment
//
//  Created by apple on 16/1/22.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"
#import "ZCPCoupletModel.h"

// 对联Cell
@interface ZCPCoupletMainCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UIImageView *userHeadImgView; // 用户头像图片
@property (nonatomic, strong) UILabel *userNameLabel;       // 用户名标签
@property (nonatomic, strong) UILabel *coupletContentLabel; // 对联内容标签
@property (nonatomic, strong) UILabel *timeLabel;           // 对联发布时间标签
@property (nonatomic, strong) UILabel *supportLabel;        // 点赞人数标签
@property (nonatomic, strong) UILabel *replyNumLabel;       // 回复人数标签
@property (nonatomic, strong) ZCPCoupletModel *item;        // Item

@end