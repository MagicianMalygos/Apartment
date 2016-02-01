//
//  ZCPAddPictureCell.h
//  Apartment
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"

@class ZCPAddPictureCellItem;

@interface ZCPAddPictureCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UIImageView *uploadImageView;     // 图片视图
@property (nonatomic, strong) UILabel *tipLabel;                // 提示信息标签
@property (nonatomic, strong) ZCPAddPictureCellItem *item;      // item

@end

@interface ZCPAddPictureCellItem : ZCPDataModel

@property (nonatomic, copy) NSString *tipText;               // 提示信息

@end