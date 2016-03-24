//
//  ZCPSettingChangeSecurityController.m
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPSettingChangeSecurityController.h"
#import "ZCPSectionCell.h"
#import "ZCPTextFieldCell.h"
#import "ZCPButtonCell.h"

@interface ZCPSettingChangeSecurityController () <ZCPButtonCellDelegate>

@end

@implementation ZCPSettingChangeSecurityController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"修改密保";
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
    sectionItem1.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"密保问题一" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    // 密码
    ZCPTextFieldCellItem *questionItem1 = [[ZCPTextFieldCellItem alloc] initWithDefault];
    questionItem1.textFieldConfigBlock = ^(UITextField *textField) {
        textField.placeholder = @"输入问题";
    };
    ZCPTextFieldCellItem *answerItem1 = [[ZCPTextFieldCellItem alloc] initWithDefault];
    answerItem1.textFieldConfigBlock = ^(UITextField *textField) {
        textField.placeholder = @"输入答案";
    };
    
    ZCPSectionCellItem *sectionItem2 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem2.backgroundColor = [UIColor lightGrayColor];;
    sectionItem2.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem2.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"密保问题二" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    // 密码
    ZCPTextFieldCellItem *questionItem2 = [[ZCPTextFieldCellItem alloc] initWithDefault];
    questionItem2.textFieldConfigBlock = ^(UITextField *textField) {
        textField.placeholder = @"输入问题";
    };
    ZCPTextFieldCellItem *answerItem2 = [[ZCPTextFieldCellItem alloc] initWithDefault];
    answerItem2.textFieldConfigBlock = ^(UITextField *textField) {
        textField.placeholder = @"输入答案";
    };
    
    ZCPSectionCellItem *sectionItem3 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem3.backgroundColor = [UIColor lightGrayColor];;
    sectionItem3.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem3.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"密保问题三" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    // 密码
    ZCPTextFieldCellItem *questionItem3 = [[ZCPTextFieldCellItem alloc] initWithDefault];
    questionItem3.textFieldConfigBlock = ^(UITextField *textField) {
        textField.placeholder = @"输入问题";
    };
    ZCPTextFieldCellItem *answerItem3 = [[ZCPTextFieldCellItem alloc] initWithDefault];
    answerItem3.textFieldConfigBlock = ^(UITextField *textField) {
        textField.placeholder = @"输入答案";
    };
    
    ZCPLineCellItem *blankItem = [[ZCPLineCellItem alloc] initWithDefault];
    // 退出登录
    ZCPButtonCellItem *determineItem = [[ZCPButtonCellItem alloc] initWithDefault];
    determineItem.cellHeight = @45;
    determineItem.buttonTitle = @"确认";
    determineItem.delegate = self;
    
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:sectionItem1];
    [items addObject:questionItem1];
    [items addObject:answerItem1];
    
    [items addObject:sectionItem2];
    [items addObject:questionItem2];
    [items addObject:answerItem2];
    
    [items addObject:sectionItem3];
    [items addObject:questionItem3];
    [items addObject:answerItem3];
    
    [items addObject:blankItem];
    [items addObject:determineItem];
    self.tableViewAdaptor.items = items;
}


#pragma mark - ZCPButtonCell Delegate
- (void)cell:(UITableViewCell *)cell buttonClicked:(UIButton *)button {
    
}

@end
