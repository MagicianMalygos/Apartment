//
//  ZCPMultiLineTextCell.h
//  Apartment
//
//  Created by apple on 16/3/21.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"

@class ZCPMultiLineTextCellItem;

@interface ZCPMultiLineTextCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UILabel *multiLineTextLabel;       // 文本标签
@property (nonatomic, strong) ZCPMultiLineTextCellItem *item;    // item

@end

@interface ZCPMultiLineTextCellItem : ZCPDataModel

@property (nonatomic, copy) NSString *multiLineText;       // 文本

@end