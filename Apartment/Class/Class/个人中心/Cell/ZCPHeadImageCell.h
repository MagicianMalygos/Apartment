//
//  ZCPHeadImageCell.h
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"

@class ZCPHeadImageCellItem;
@protocol ZCPHeadImageCellDelegate;

// 修改用户头像Cell
@interface ZCPHeadImageCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UIButton *bigButton;                      // 大头像按钮
@property (nonatomic, strong) UIButton *middleButton;                   // 中等头像按钮
@property (nonatomic, strong) UIButton *smallButton;                    // 小头像按钮
@property (nonatomic, strong) UIImageView *bgImageView;                 // 背景图片
@property (nonatomic, strong) ZCPHeadImageCellItem *item;               // item
@property (nonatomic, weak) id<ZCPHeadImageCellDelegate> delegate;      // 代理，处理按钮点击事件

@end

@interface ZCPHeadImageCellItem : ZCPDataModel

@property (nonatomic, copy) NSString *headImageURL;                     // 头像url
@property (nonatomic, weak) id<ZCPHeadImageCellDelegate> delegate;      // 传递代理，处理按钮点击事件

@end

@protocol ZCPHeadImageCellDelegate <NSObject>

/**
 *  头像按钮点击事件
 *
 *  @param cell   当前cell
 *  @param button 响应按钮
 */
- (void)cell:(UITableViewCell *)cell headImageButtonClicked:(UIButton *)button;

@end
