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

@interface ZCPHeadImageCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UIButton *bigButton;
@property (nonatomic, strong) UIButton *middleButton;
@property (nonatomic, strong) UIButton *smallButton;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) ZCPHeadImageCellItem *item;
@property (nonatomic, weak) id<ZCPHeadImageCellDelegate> delegate;

@end

@interface ZCPHeadImageCellItem : ZCPDataModel

@property (nonatomic, copy) NSString *headImageURL;
@property (nonatomic, weak) id<ZCPHeadImageCellDelegate> delegate;

@end

@protocol ZCPHeadImageCellDelegate <NSObject>

- (void)cell:(UITableViewCell *)cell headImageButtonClicked:(UIButton *)button;

@end
