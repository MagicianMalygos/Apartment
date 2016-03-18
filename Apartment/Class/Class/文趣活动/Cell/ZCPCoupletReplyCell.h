//
//  ZCPCoupletReplyCell.h
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"

#import "ZCPCoupletReplyModel.h"

@class ZCPCoupletReplyCellItem;
@protocol ZCPCoupletReplyCellDelegate;

// 对联回复Cell
@interface ZCPCoupletReplyCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UIImageView *userHeadImgView;             // 用户头像
@property (nonatomic, strong) UILabel *userNameLabel;                   // 用户名
@property (nonatomic, strong) UILabel *replySupportLabel;               // 点赞量标签
@property (nonatomic, strong) UIButton *supportButton;                  // 点赞按钮
@property (nonatomic, strong) UILabel *replyContentLabel;               // 回复内容
@property (nonatomic, strong) UILabel *replyTimeLabel;                  // 回复时间
@property (nonatomic, strong) ZCPCoupletReplyCellItem * item;           // item
@property (nonatomic, weak) id<ZCPCoupletReplyCellDelegate> delegate;   // delegate

@end

// 对联回复CellItem
@interface ZCPCoupletReplyCellItem : ZCPDataModel

@property (nonatomic, assign) NSInteger replyId;                            // 回复Id
@property (nonatomic, copy) NSString *replyContent;                         // 回复内容
@property (nonatomic, copy) NSString *userHeadImageURL;                     // 用户头像URL
@property (nonatomic, copy) NSString *userName;                             // 用户名
@property (nonatomic, strong) NSDate *replyTime;                            // 回复时间
@property (nonatomic, assign) NSInteger replySupportNumber;                 // 点赞量
@property (nonatomic, assign) ZCPCoupletReplySupportState replySupported;   // 对联回复点赞状态
@property (nonatomic, weak) id<ZCPCoupletReplyCellDelegate> delegate;       // delegate

@end


@protocol ZCPCoupletReplyCellDelegate <NSObject>

// 点赞按钮点击响应事件
- (void)coupletReplyCell:(ZCPCoupletReplyCell *)cell supportButtonClicked:(UIButton *)button;

@end
