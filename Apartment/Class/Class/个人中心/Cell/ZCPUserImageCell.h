//
//  ZCPUserImageCell.h
//  Apartment
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewCell.h"

#import "ZCPTableViewWithLineCell.h"

@class ZCPUserImageCellItem;

@interface ZCPUserImageCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIButton *userHeadButton;
@property (nonatomic, strong) ZCPUserImageCellItem *item;

@end

@interface ZCPUserImageCellItem : ZCPDataModel

@property (nonatomic, copy) NSString *bgImageURL;
@property (nonatomic, copy) NSString *userHeadURL;

@end
