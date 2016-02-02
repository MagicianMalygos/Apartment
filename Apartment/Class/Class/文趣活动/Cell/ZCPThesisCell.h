//
//  ZCPThesisCell.h
//  Apartment
//
//  Created by apple on 16/2/2.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewCell.h"

#import "ZCPThesisView.h"
#import "ZCPThesisModel.h"

@class ZCPThesisCellItem;

@interface ZCPThesisCell : ZCPTableViewCell

@property (nonatomic, strong) ZCPThesisView *thesisView;            // 辩题视图
@property (nonatomic, strong) ZCPThesisCellItem *item;              // item

@end

@interface ZCPThesisCellItem : ZCPDataModel

@property (nonatomic, strong) ZCPThesisModel *thesisModel;          // 辩题模型
@property (nonatomic, weak) id<ZCPThesisViewDelegate> delegate;     // thesisView代理

@end