//
//  ZCPImageTextCell.h
//  Apartment
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewCell.h"

#import "ZCPTableViewWithLineCell.h"
#import "ZCPUserControllerHelper.h"

@class ZCPTextCellItem;
@class ZCPImageTextCellItem;
@class ZCPImageTextSwitchCellItem;

@protocol ZCPImageTextSwitchCellItemDelegate;

#define RIGHT_WIDTH         50
#define MARGIN_IMG_TEXT     20

#pragma mark - Text Cell&Item
@interface ZCPTextCell : ZCPTableViewWithLineCell
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) ZCPDataModel *item;
@end

@interface ZCPTextCellItem : ZCPDataModel
@property (nonatomic, strong) NSMutableAttributedString *text;
@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;
@end


#pragma mark - Image Text Cell&Item
@interface ZCPImageTextCell : ZCPTextCell
@property (nonatomic, strong) UIImageView *imgIcon;
@end

@interface ZCPImageTextCellItem : ZCPTextCellItem
@property (nonatomic, copy) NSString *imageURL;
@end


#pragma mark - Image Text Switch Cell&Item
@interface ZCPImageTextSwitchCell : ZCPImageTextCell
@property (nonatomic, strong) UISwitch *switchView;
@end

@interface ZCPImageTextSwitchCellItem : ZCPImageTextCellItem
// 设置开关的初始状态
@property (nonatomic, assign) BOOL switchInitialValue;
// 按钮开关事件响应者
@property (nonatomic, weak) id<ZCPImageTextSwitchCellItemDelegate> switchResponser;
@end

@protocol ZCPImageTextSwitchCellItemDelegate <NSObject>
// 按钮开关事件响应方法
- (void)switchValueChange:(UISwitch *)switchView;
@end

