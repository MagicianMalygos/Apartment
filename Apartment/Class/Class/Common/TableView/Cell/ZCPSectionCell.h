//
//  ZCPSectionCell.h
//  Apartment
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewCell.h"
#import "ZCPLineCell.h"

@class ZCPSectionCellItem;

#pragma mark - Section Cell
@interface ZCPSectionCell : ZCPLineCell

@property (nonatomic, strong) UILabel *sectionTitleLabel;

@end

#pragma mark - Section CellItem
@interface ZCPSectionCellItem : ZCPLineCellItem <NSCopying>

@property (nonatomic, copy) NSString *sectionTitle;
@property (nonatomic, strong) NSAttributedString *sectionAttrTitle;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) UIEdgeInsets titleEdgeInset;

@end
