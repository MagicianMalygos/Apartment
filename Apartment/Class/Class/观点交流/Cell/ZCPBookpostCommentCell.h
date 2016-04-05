//
//  ZCPBookpostCommentCell.h
//  Apartment
//
//  Created by apple on 16/4/4.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"
#import "ZCPBookPostCommentModel.h"

@interface ZCPBookpostCommentCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UIImageView *userHeadImageView;   // 用户头像视图
@property (nonatomic, strong) UILabel *userNameLabel;           // 用户名标签
@property (nonatomic, strong) UILabel *supportNumberLabel;      // 点赞量量标签
@property (nonatomic, strong) UILabel *commentContentLabel;     // 评论内容标签
@property (nonatomic, strong) ZCPBookPostCommentModel *item;    // item

@end
