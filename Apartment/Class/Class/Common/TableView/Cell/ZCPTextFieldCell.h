//
//  ZCPTextFieldCell.h
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"

@class ZCPTextFieldCellItem;

typedef void(^ZCPTextFieldConfigBlock)(UITextField *);

@interface ZCPTextFieldCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) ZCPTextFieldCellItem *item;

@end

@interface ZCPTextFieldCellItem : ZCPDataModel

@property (nonatomic, strong) ZCPTextFieldConfigBlock textFieldConfigBlock;
@property (nonatomic, copy) NSString *placeholder;

@end
