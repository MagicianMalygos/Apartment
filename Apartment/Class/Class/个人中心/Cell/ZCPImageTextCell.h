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
@class ZCPImageTextButtonCellItem;

@protocol ZCPImageTextSwitchCellItemDelegate;
@protocol ZCPImageTextButtonCellItemDelegate;

typedef void(^ZCPButtonConfigBlock)(UIButton *);        // button配置块

#define RIGHT_WIDTH         50
#define MARGIN_IMG_TEXT     20

#pragma mark - Text Cell&Item
// 左边只有一个标签的cell
@interface ZCPTextCell : ZCPTableViewWithLineCell
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) ZCPDataModel *item;
@end

@interface ZCPTextCellItem : ZCPDataModel
@property (nonatomic, strong) NSMutableAttributedString *text;
@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;
@end


#pragma mark - Image Text Cell&Item
// 左边有一个图片和标签的cell
@interface ZCPImageTextCell : ZCPTextCell
@property (nonatomic, strong) UIImageView *imgIcon;
@end

@interface ZCPImageTextCellItem : ZCPTextCellItem
@property (nonatomic, copy) NSString *imageName;
@end

#pragma mark - Image Text Switch Cell&Item
// 左边有一个图片和标签，右边有一个开关的Cell
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
- (void)cell:(ZCPImageTextSwitchCell *)cell switchValueChanged:(UISwitch *)switchView;
@end

#pragma mark - Image Text Switch Cell&Item
// 左边有一个图片和标签，右边有一个按钮的Cell
@interface ZCPImageTextButtonCell : ZCPImageTextCell
@property (nonatomic, strong) UIButton *button;
@end

@interface ZCPImageTextButtonCellItem : ZCPImageTextCellItem
// 附加信息
@property (nonatomic, strong) NSObject *tagInfo;
// 按钮配置块
@property (nonatomic, copy) ZCPButtonConfigBlock buttonConfigBlock;
// 按钮点击事件响应者
@property (nonatomic, weak) id<ZCPImageTextButtonCellItemDelegate> delegate;
@end

@protocol ZCPImageTextButtonCellItemDelegate <NSObject>
// 按钮点击事件响应方法
- (void)cell:(ZCPImageTextButtonCell *)cell buttonClicked:(UIButton *)button;
@end

