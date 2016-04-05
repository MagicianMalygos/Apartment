//
//  ZCPBookCell.h
//  Apartment
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"
#import "ZCPBookModel.h"

@class ZCPBookDetailCellItem;
@protocol ZCPBookDetailCellDelegate;

// 图书cell
@interface ZCPBookCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UIImageView *coverImageView;  // 封面图片
@property (nonatomic, strong) UILabel *nameLabel;           // 书名标签
@property (nonatomic, strong) UILabel *authorLabel;         // 作者标签
@property (nonatomic, strong) UILabel *publisherLabel;      // 出版社标签
@property (nonatomic, strong) UILabel *fieldLabel;          // 所属领域标签
@property (nonatomic, strong) UILabel *publishTimeLabel;    // 出版时间标签
@property (nonatomic, strong) UILabel *contributorLabel;    // 贡献者标签
@property (nonatomic, strong) UILabel *collectNumberLabel;  // 收藏人数标签
@property (nonatomic, strong) UILabel *commentCountLabel;   // 评论人数标签
@property (nonatomic, strong) ZCPBookModel *item;           // item

@end

#pragma mark - ZCPBookDetailCell
// 图书详情cell
@interface ZCPBookDetailCell : ZCPBookCell

@property (nonatomic, strong) UIButton *collectionButton;               // 收藏按钮
@property (nonatomic, strong) UIButton *commentButton;                  // 评论按钮
@property (nonatomic, strong) UIButton *bookpostSearchButton;           // 相关图书贴搜索按钮
@property (nonatomic, strong) UIButton *webSearchButton;                // 网上搜索按钮
@property (nonatomic, weak) id<ZCPBookDetailCellDelegate> delegate;     // delegate

@end

@interface ZCPBookDetailCellItem : ZCPBookModel

@property (nonatomic, copy) NSString *bookpostSearchButtonTitle;        // 相关图书帖搜索按钮标题
@property (nonatomic, copy) NSString *webSearchButtonTitle;             // 网上搜索按钮标题
@property (nonatomic, assign) ZCPBookCollectState bookCollected;        // 图书收藏状态
@property (nonatomic, weak) id<ZCPBookDetailCellDelegate> delegate;     // delegate

@end

@protocol ZCPBookDetailCellDelegate <NSObject>

// 收藏按钮点击事件
- (void)bookDetailCell:(ZCPBookDetailCell *)cell collectionButtonClick:(UIButton *)button;
// 评论按钮点击事件
- (void)bookDetailCell:(ZCPBookDetailCell *)cell commentButtonClick:(UIButton *)button;
// 图书贴搜索按钮点击事件
- (void)bookDetailCell:(ZCPBookDetailCell *)cell bookpostSearchButtonClick:(UIButton *)button;
// 网上搜索按钮点击事件
- (void)bookDetailCell:(ZCPBookDetailCell *)cell webSearchButtonClick:(UIButton *)button;

@end
