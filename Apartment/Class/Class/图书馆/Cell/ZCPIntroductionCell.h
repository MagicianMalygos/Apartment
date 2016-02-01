//
//  ZCPIntroductionCell.h
//  Apartment
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"

@class ZCPIntroductionCellItem;

@interface ZCPIntroductionCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UILabel *introductionLabel;       // 简介标签
@property (nonatomic, strong) ZCPIntroductionCellItem *item;    // item

@end

@interface ZCPIntroductionCellItem : ZCPDataModel

@property (nonatomic, copy) NSString *introductionString;       // 简介

@end