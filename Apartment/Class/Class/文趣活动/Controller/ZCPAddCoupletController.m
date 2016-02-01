//
//  ZCPAddCoupletController.m
//  Apartment
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPAddCoupletController.h"

#import "ZCPSectionCell.h"
#import "ZCPTextFieldCell.h"
#import "ZCPButtonCell.h"

@interface ZCPAddCoupletController ()

@end

@implementation ZCPAddCoupletController

#pragma mark - life circle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"写对联";
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
    sectionItem.cellHeight = @20;
    sectionItem.backgroundColor = [UIColor lightGrayColor];
    sectionItem.sectionTitle = @"写对联";
    sectionItem.titleEdgeInset = UIEdgeInsetsZero;
    // 对联内容
    ZCPTextFieldCellItem *textItem = [[ZCPTextFieldCellItem alloc] initWithDefault];
    textItem.textFieldConfigBlock = ^(UITextField *textField) {
        textField.placeholder = @"请输入对联内容，不超过N个字...";
    };
    
    // blank
    ZCPLineCellItem *blankItem = [[ZCPLineCellItem alloc] initWithDefault];
    // 提交按钮
    ZCPButtonCellItem *determineItem = [[ZCPButtonCellItem alloc] initWithDefault];
    determineItem.buttonTitle = @"提交";
    
    
    [items addObject:sectionItem];
    [items addObject:textItem];
    
    [items addObject:blankItem];
    [items addObject:determineItem];
    
    self.tableViewAdaptor.items = items;
}
@end
