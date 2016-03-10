//
//  ZCPAddQuestionController.m
//  Apartment
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPAddQuestionController.h"

#import "ZCPSectionCell.h"
#import "ZCPTextViewCell.h"
#import "ZCPTextFieldCell.h"
#import "ZCPButtonCell.h"

@interface ZCPAddQuestionController ()

@end

@implementation ZCPAddQuestionController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar);
}

#pragma mark - Construct Data
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    // section
    ZCPSectionCellItem *sectionItem = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem.sectionTitle = @"问题";
    // 题目
    ZCPTextViewCellItem *questionItem = [[ZCPTextViewCellItem alloc] initWithDefault];
    questionItem.placeholder = @"请输入问题内容,不超过50字...";
    
    // section 1
    ZCPSectionCellItem *sectionItem1 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem1.sectionTitle = @"选项一";
    // 选项一
    ZCPTextFieldCellItem *optionItem1 = [[ZCPTextFieldCellItem alloc] initWithDefault];
    optionItem1.textFieldConfigBlock = ^(UITextField *textField) {
        textField.placeholder = @"请输入选项一,不超过20字...";
    };
    
    // section 2
    ZCPSectionCellItem *sectionItem2 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem2.sectionTitle = @"选项二";
    // 选项二
    ZCPTextFieldCellItem *optionItem2 = [[ZCPTextFieldCellItem alloc] initWithDefault];
    optionItem2.textFieldConfigBlock = ^(UITextField *textField) {
        textField.placeholder = @"请输入选项二,不超过20字...";
    };
    
    // section 3
    ZCPSectionCellItem *sectionItem3 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem3.sectionTitle = @"选项三";
    // 选项三
    ZCPTextFieldCellItem *optionItem3 = [[ZCPTextFieldCellItem alloc] initWithDefault];
    optionItem3.textFieldConfigBlock = ^(UITextField *textField) {
        textField.placeholder = @"请输入选项三,不超过20字...";
    };
    
    // section 4
    ZCPSectionCellItem *sectionItem4 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem4.sectionTitle = @"选项四";
    // 正确答案
    ZCPTextFieldCellItem *answerItem = [[ZCPTextFieldCellItem alloc] initWithDefault];
    answerItem.textFieldConfigBlock = ^(UITextField *textField) {
        textField.placeholder = @"请输入选项四,不超过20字...";
    };
    
    // blank
    ZCPLineCellItem *blankItem = [[ZCPLineCellItem alloc] initWithDefault];
    // 提交按钮
    ZCPButtonCellItem *determineItem = [[ZCPButtonCellItem alloc] initWithDefault];
    determineItem.buttonTitle = @"提交";
    
    [items addObject:sectionItem];
    [items addObject:questionItem];
    [items addObject:sectionItem1];
    [items addObject:optionItem1];
    [items addObject:sectionItem2];
    [items addObject:optionItem2];
    [items addObject:sectionItem3];
    [items addObject:optionItem3];
    [items addObject:sectionItem4];
    [items addObject:answerItem];
    [items addObject:blankItem];
    [items addObject:determineItem];
    self.tableViewAdaptor.items = items;
}


@end
