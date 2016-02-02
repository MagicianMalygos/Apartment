//
//  ZCPBookPostCell.h
//  Apartment
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"

@class ZCPBookPostCellItem;

// 图书贴Cell
@interface ZCPBookPostCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UILabel *bpTitleLabel;            // 图书贴标题标签
@property (nonatomic, strong) UILabel *bpContentLabel;          // 图书贴内容标签
@property (nonatomic, strong) UILabel *bpTimeLabel;             // 发帖时间标签
@property (nonatomic, strong) UILabel *uploaderLabel;           // 发帖人标签
@property (nonatomic, strong) UILabel *fieldLabel;              // 所属类型标签
@property (nonatomic, strong) UILabel *bookNameLabel;           // 相关书籍标签
@property (nonatomic, strong) UILabel *supportNumberLabel;      // 点赞量标签
@property (nonatomic, strong) UILabel *collectionNumberLabel;   // 收藏人数标签
@property (nonatomic, strong) UILabel *replyNumberLabel;        // 回复人数标签
@property (nonatomic, strong) ZCPBookPostCellItem *item;        // item

@end

@interface ZCPBookPostCellItem : ZCPDataModel

@property (nonatomic, copy) NSString *bpTitle;                  // 图书贴标题
@property (nonatomic, copy) NSString *bpContent;                // 图书贴内容
@property (nonatomic, strong) NSDate *bpTime;                   // 发帖时间
@property (nonatomic, copy) NSString *uploader;                 // 发帖人
@property (nonatomic, copy) NSString *field;                    // 所属类型
@property (nonatomic, copy) NSString *bookName;                 // 相关书籍
@property (nonatomic, assign) NSInteger supportNumber;          // 点赞量
@property (nonatomic, assign) NSInteger collectionNumber;       // 收藏人数
@property (nonatomic, assign) NSInteger replyNumber;            // 回复人数

@end
