//
//  ZCPBookDetailView.h
//  Apartment
//
//  Created by apple on 16/1/29.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZCPBookModel.h"

@interface ZCPBookDetailView : UIView

@property (nonatomic, strong) ZCPBookModel *bookModel;              // 图书模型

@property (nonatomic, strong) UIImageView *coverImageView;          // 封面图片
@property (nonatomic, strong) UILabel *nameLabel;                   // 书名标签
@property (nonatomic, strong) UILabel *authorLabel;                 // 作者标签
@property (nonatomic, strong) UILabel *publisherLabel;              // 出版社标签
@property (nonatomic, strong) UILabel *fieldLabel;                  // 所属领域标签
@property (nonatomic, strong) UILabel *publishTimeLabel;            // 出版时间标签
@property (nonatomic, strong) UILabel *contributorLabel;            // 贡献者标签
@property (nonatomic, strong) UILabel *collectNumberLabel;          // 收藏人数标签
@property (nonatomic, strong) UILabel *commentCountLabel;           // 评论人数标签

@property (nonatomic, strong) UIButton *supportButton;              // 点赞按钮
@property (nonatomic, strong) UIButton *collectionButton;           // 收藏按钮
@property (nonatomic, strong) UIButton *bookpostSearchButton;       // 相关图书贴搜索按钮
@property (nonatomic, strong) UIButton *webSearchButton;            // 网上搜索按钮

/**
 *  使用frame和
 *
 *  @param frame     <#frame description#>
 *  @param bookModel <#bookModel description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame bookModel:(ZCPBookModel *)bookModel;

@end
