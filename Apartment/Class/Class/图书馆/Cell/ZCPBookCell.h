//
//  ZCPBookCell.h
//  Apartment
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"

@class ZCPBookCellItem;
@class ZCPBookDetailCellItem;

// 图书cell
@interface ZCPBookCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UIImageView *coverImageView;          // 封面图片
@property (nonatomic, strong) UILabel *nameLabel;                   // 书名标签
@property (nonatomic, strong) UILabel *authorLabel;                 // 作者标签
@property (nonatomic, strong) UILabel *publisherLabel;              // 出版社标签
@property (nonatomic, strong) UILabel *fieldLabel;                  // 所属领域标签
@property (nonatomic, strong) UILabel *publishTimeLabel;            // 出版时间标签
@property (nonatomic, strong) UILabel *contributorLabel;            // 贡献者标签
@property (nonatomic, strong) UILabel *collectNumberLabel;          // 收藏人数标签
@property (nonatomic, strong) UILabel *commentCountLabel;           // 评论人数标签

@property (nonatomic, strong) ZCPBookCellItem *item;                // item

@end

@interface ZCPBookCellItem : ZCPDataModel

@property (nonatomic, copy) NSString *bookCoverURL;                 // 图书封面
@property (nonatomic, copy) NSString *bookName;                     // 图书名称
@property (nonatomic, copy) NSString *bookAuthor;                   // 图书作者
@property (nonatomic, copy) NSString *bookPublisher;                // 图书出版社
@property (nonatomic, strong) NSArray *field;                       // 图书所在领域
@property (nonatomic, strong) NSDate *bookPublishTime;              // 图书出版时间
@property (nonatomic, copy) NSString *contributor;                  // 图书贡献者
@property (nonatomic, assign) NSInteger bookCollectNumber;          // 收藏数量
@property (nonatomic, assign) NSInteger bookCommentCount;           // 图书评论数量

@end


#pragma mark - ZCPBookDetailCell
// 图书详情cell
@interface ZCPBookDetailCell : ZCPBookCell

@property (nonatomic, strong) UIButton *supportButton;              // 点赞按钮
@property (nonatomic, strong) UIButton *collectionButton;           // 收藏按钮
@property (nonatomic, strong) UIButton *bookpostSearchButton;       // 相关图书贴搜索按钮
@property (nonatomic, strong) UIButton *webSearchButton;            // 网上搜索按钮

@end

@interface ZCPBookDetailCellItem : ZCPBookCellItem

@property (nonatomic, copy) NSString *bookpostSearchButtonTitle;    // 相关图书帖搜索按钮标题
@property (nonatomic, copy) NSString *webSearchButtonTitle;         // 网上搜索按钮标题

@end
