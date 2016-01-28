//
//  ZCPSwitchRadioCell.h
//  Apartment
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"

@class ZCPSwitchRadioCellItem;
@protocol ZCPSwitchRadioCellItemDelegate;

// 开关按钮+单选框 Cell（添加论点中匿名开关和选择正反方单选框）
@interface ZCPSwitchRadioCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UISwitch *switchView;             // 开关
@property (nonatomic, strong) UILabel *switchLabel;             // 开关文本
@property (nonatomic, strong) UIButton *radioButtonOne;         // 单选框按钮一
@property (nonatomic, strong) UILabel *radioLabelOne;           // 单选框文本标签一
@property (nonatomic, strong) UIButton *radioButtonTwo;         // 单选框按钮二
@property (nonatomic, strong) UILabel *radioLabelTwo;           // 单选框文本标签二

@property (nonatomic, strong) ZCPSwitchRadioCellItem * item;    // item

@end

@interface ZCPSwitchRadioCellItem : ZCPDataModel


@property (nonatomic, assign) BOOL switchInitialValue;                             // 设置按钮的初始开关状态
@property (nonatomic, weak) id<ZCPSwitchRadioCellItemDelegate> switchResponser;    // 按钮开关事件响应者

@property (nonatomic, copy) NSString *switchTipText;                               // 开关文本
@property (nonatomic, copy) NSString *radioTipTextOne;                             // 单选框文本一
@property (nonatomic, copy) NSString *radioTipTextTwo;                             // 单选框文本二

@end


@protocol ZCPSwitchRadioCellItemDelegate <NSObject>
// 按钮开关事件响应方法
- (void)switchValueChange:(UISwitch *)switchView;
@end
