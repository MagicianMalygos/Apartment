//
//  ZCPHotBookpostCommentCell.h
//  Apartment
//
//  Created by apple on 16/4/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRoundCell.h"
#import "ZCPBookPostCommentModel.h"

@interface ZCPHotBookpostCommentCell : ZCPRoundCell

@property (nonatomic, strong) UIView *bpView;                       // 图书贴区域视图
@property (nonatomic, strong) UILabel *bookpostTitleLabel;          // 图书贴标题标签
@property (nonatomic, strong) UIView *lineView;                     // 分割线
@property (nonatomic, strong) UIView *bpcView;                      // 图书贴评论区域视图
@property (nonatomic, strong) UIImageView *bpcUserHeadImageView;    // 图书贴评论用户头像
@property (nonatomic, strong) UILabel *supportNumberLabel;          // 图书贴点赞人数
@property (nonatomic, strong) UILabel *bpcContentLabel;             // 图书贴内容标签

@end

@interface ZCPHotBookpostCommentCellItem : ZCPRoundCellItem

@property (nonatomic, strong) ZCPBookPostCommentModel *bpcModel;    // 图书贴评论模型

@end