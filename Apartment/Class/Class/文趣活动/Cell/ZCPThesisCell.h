//
//  ZCPThesisCell.h
//  Apartment
//
//  Created by apple on 16/2/2.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"
#import "ZCPThesisView.h"
#import "ZCPThesisModel.h"

@class ZCPThesisCellItem;

// 辩题cell
@interface ZCPThesisCell : ZCPTableViewCell

@property (nonatomic, strong) ZCPThesisView *thesisView;            // 辩题视图
@property (nonatomic, strong) ZCPThesisCellItem *item;              // item

@end

@interface ZCPThesisCellItem : ZCPDataModel

@property (nonatomic, strong) ZCPThesisModel *thesisModel;          // 辩题模型
@property (nonatomic, weak) id<ZCPThesisViewDelegate> delegate;     // thesisView代理

@end

// 辩题展示cell
@interface ZCPThesisShowCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UILabel *thesisContentLabel;      // 辩题内容
@property (nonatomic, strong) UILabel *thesisProsLabel;         // 辩题正方论点
@property (nonatomic, strong) UILabel *thesisConsLabel;         // 辩题反方论点
@property (nonatomic, strong) UILabel *replyNumberLabel;        // 回复人数标签
@property (nonatomic, strong) UILabel *collectionNumberLabel;   // 收藏人数标签
@property (nonatomic, strong) ZCPThesisModel *item;             // item

@end