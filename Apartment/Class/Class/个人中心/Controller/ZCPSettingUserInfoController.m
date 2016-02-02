//
//  ZCPSettingUserInfoController.m
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPSettingUserInfoController.h"

#import "ZCPSectionCell.h"
#import "ZCPTextFieldCell.h"
#import "ZCPButtonCell.h"

@interface ZCPSettingUserInfoController () <ZCPButtonCellDelegate>

@end

@implementation ZCPSettingUserInfoController

#pragma mark - life circle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"修改个人信息";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar);
}

#pragma mark - Construct Data
- (void)constructData {
    
    // 文字主题颜色
    UIColor *textColor = (self.appTheme == LightTheme)?[UIColor blackColor]:[UIColor whiteColor];
    
    ZCPSectionCellItem *sectionItem1 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem1.backgroundColor = [UIColor lightGrayColor];
    sectionItem1.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem1.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"修改信息" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    // 昵称
    ZCPTextFieldCellItem *nameItem = [[ZCPTextFieldCellItem alloc] initWithDefault];
    nameItem.textFieldConfigBlock = ^(UITextField *textField) {
        textField.placeholder = @"请输入昵称";
    };
    // 年龄
    ZCPTextFieldCellItem *ageItem = [[ZCPTextFieldCellItem alloc] initWithDefault];
    ageItem.textFieldConfigBlock = ^(UITextField *textField) {
        textField.placeholder = @"请输入年龄";
    };
    
    ZCPSectionCellItem *sectionItem2 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem2.backgroundColor = [UIColor lightGrayColor];
    sectionItem2.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem2.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"修改领域" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    // 领域
    
    ZCPLineCellItem *blankItem = [[ZCPLineCellItem alloc] initWithDefault];
    // 退出登录
    ZCPButtonCellItem *determineItem = [[ZCPButtonCellItem alloc] initWithDefault];
    determineItem.cellHeight = @45;
    determineItem.buttonTitle = @"确认";
    determineItem.delegate = self;
    
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:sectionItem1];
    [items addObject:nameItem];
    [items addObject:ageItem];
    
    [items addObject:sectionItem2];
    
    [items addObject:blankItem];
    [items addObject:determineItem];
    self.tableViewAdaptor.items = items;
}


#pragma mark - ZCPButtonCell Delegate
- (void)cell:(UITableViewCell *)cell buttonClicked:(UIButton *)button {
    
}

@end
