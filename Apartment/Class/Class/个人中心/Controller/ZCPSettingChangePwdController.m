//
//  ZCPSettingChangePwdController.m
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPSettingChangePwdController.h"

#import "ZCPSectionCell.h"
#import "ZCPButtonCell.h"
#import "ZCPTextFieldCell.h"

@interface ZCPSettingChangePwdController () <ZCPButtonCellDelegate>

@end

@implementation ZCPSettingChangePwdController

#pragma mark - life circle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"用户设置";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar);
}

#pragma mark - constructData
- (void)constructData {
    
    // 文字主题颜色
    UIColor *textColor = (self.appTheme == LightTheme)?[UIColor blackColor]:[UIColor whiteColor];
    
    ZCPSectionCellItem *sectionItem1 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem1.backgroundColor = [UIColor lightGrayColor];;
    sectionItem1.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem1.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"请输入旧密码" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    // 密码
    ZCPTextFieldCellItem *oldPwdItem = [[ZCPTextFieldCellItem alloc] initWithDefault];
    oldPwdItem.textFieldConfigBlock = ^(UITextField *textField) {
        textField.placeholder = @"请输入旧密码";
    };
    
    ZCPSectionCellItem *sectionItem2 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem2.backgroundColor = [UIColor lightGrayColor];;
    sectionItem2.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem2.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"请输入新密码" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    // 密码
    ZCPTextFieldCellItem *newPwdItem = [[ZCPTextFieldCellItem alloc] initWithDefault];
    newPwdItem.textFieldConfigBlock = ^(UITextField *textField) {
        textField.placeholder = @"请输入新密码";
    };
    
    ZCPSectionCellItem *sectionItem3 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem3.backgroundColor = [UIColor lightGrayColor];;
    sectionItem3.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem3.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"请再次输入" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    // 重复密码
    ZCPTextFieldCellItem *reNewPwdItem = [[ZCPTextFieldCellItem alloc] initWithDefault];
    reNewPwdItem.textFieldConfigBlock = ^(UITextField *textField) {
        textField.placeholder = @"请再次输入";
    };
    
    ZCPLineCellItem *blankItem = [[ZCPLineCellItem alloc] initWithDefault];
    // 退出登录
    ZCPButtonCellItem *determineItem = [[ZCPButtonCellItem alloc] initWithDefault];
    determineItem.cellHeight = @45;
    determineItem.buttonTitle = @"确认";
    determineItem.delegate = self;
    
    
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:sectionItem1];
    [items addObject:oldPwdItem];
    
    [items addObject:sectionItem2];
    [items addObject:newPwdItem];
    
    [items addObject:sectionItem3];
    [items addObject:reNewPwdItem];
    
    [items addObject:blankItem];
    [items addObject:determineItem];
    self.tableViewAdaptor.items = items;
}



#pragma mark - ZCPButtonCell Delegate
- (void)cell:(UITableViewCell *)cell buttonClicked:(UIButton *)button {
}


@end
