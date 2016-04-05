//
//  ZCPBookPostCell.h
//  Apartment
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"
#import "ZCPBookPostModel.h"

// 图书贴Cell
@interface ZCPBookPostCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UILabel *bpTitleLabel;            // 图书贴标题标签
@property (nonatomic, strong) UILabel *fieldLabel;              // 所属类型标签
@property (nonatomic, strong) UILabel *bookNameLabel;           // 相关书籍标签
@property (nonatomic, strong) UILabel *supportNumberLabel;      // 点赞量标签
@property (nonatomic, strong) UILabel *collectionNumberLabel;   // 收藏人数标签
@property (nonatomic, strong) UILabel *replyNumberLabel;        // 回复人数标签
@property (nonatomic, strong) ZCPBookPostModel *item;           // item

@end