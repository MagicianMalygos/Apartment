//
//  ZCPBookReplyCell.h
//  Apartment
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"

@class ZCPBookReplyCellItem;

@interface ZCPBookReplyCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UIImageView *userHeadImageView;       // 用户头像视图
@property (nonatomic, strong) UILabel *userNameLabel;               // 用户名标签
@property (nonatomic, strong) UILabel *bookreplyContentLabel;       // 回复内容标签
@property (nonatomic, strong) UILabel *bookreplyTiemLabel;          // 回复时间标签
@property (nonatomic, strong) UILabel *bookreplySupportLabel;       // 点赞量标签
@property (nonatomic, strong) UIButton *supportButton;              // 点赞按钮
@property (nonatomic, strong) ZCPBookReplyCellItem *item;           // item


@end

@interface ZCPBookReplyCellItem : ZCPDataModel

@property (nonatomic, copy) NSString *userHeadImageURL;             // 用户头像URL
@property (nonatomic, copy) NSString *userName;                     // 用户名
@property (nonatomic, copy) NSString *bookreplyContent;             // 回复内容
@property (nonatomic, strong) NSDate *bookreplyTime;                // 回复时间
@property (nonatomic, assign) NSInteger bookreplySupportNumber;     // 点赞量

@end
