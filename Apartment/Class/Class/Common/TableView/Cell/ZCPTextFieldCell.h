//
//  ZCPTextFieldCell.h
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"

@class ZCPTextFieldCellItem;
@class ZCPLabelTextFieldCellItem;

typedef void(^ZCPTextFieldConfigBlock)(UITextField *);

// 只有一个TextField的Cell
@interface ZCPTextFieldCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UITextField *textField;           // 输入框
@property (nonatomic, strong) ZCPTextFieldCellItem *item;       // item

@end

@interface ZCPTextFieldCellItem : ZCPDataModel

@property (nonatomic, copy) ZCPTextFieldConfigBlock textFieldConfigBlock;     // 输入框配置块

@end


// Label + TextField
@interface ZCPLabelTextFieldCell : ZCPTextFieldCell

@property (nonatomic, strong) UILabel *label;

@end

@interface ZCPLabelTextFieldCellItem : ZCPTextFieldCellItem

@property (nonatomic, copy) NSString *labelText;

@end