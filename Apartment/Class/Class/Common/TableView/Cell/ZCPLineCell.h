//
//  ZCPLineCell.h
//  Apartment
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewCell.h"

@class ZCPLineCellItem;

@interface ZCPLineCell : ZCPTableViewCell

@property (nonatomic, strong) ZCPDataModel *item;

@end

@interface ZCPLineCellItem : ZCPDataModel

@property (nonatomic, strong) UIColor *backgroundColor;

@end
