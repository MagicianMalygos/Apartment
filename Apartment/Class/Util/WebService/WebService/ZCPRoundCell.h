//
//  ZCPRoundCell.h
//  Apartment
//
//  Created by apple on 16/4/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPLineCell.h"

@class ZCPRoundCellItem;

// 内容视图为圆形的cell
@interface ZCPRoundCell : ZCPLineCell

@property (nonatomic, strong) UIView *roundContentView;     // 圆形内容视图

@end
