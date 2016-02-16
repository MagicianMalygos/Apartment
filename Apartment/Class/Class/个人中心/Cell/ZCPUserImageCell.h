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

// 用户图片和名字Cell
@interface ZCPUserImageCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UIImageView *bgImageView;             // 背景视图
@property (nonatomic, strong) UIImageView *userHeadImageView;       // 头像视图
@property (nonatomic, strong) UILabel *userNameLabel;               // 用户名标签
@property (nonatomic, strong) ZCPUserImageCellItem *item;           // item

@end

@interface ZCPUserImageCellItem : ZCPDataModel

@property (nonatomic, copy) NSString *bgImageURL;           // 背景图片url
@property (nonatomic, copy) NSString *userHeadURL;          // 用户头像url
@property (nonatomic, copy) NSString *userName;             // 用户名

@end
