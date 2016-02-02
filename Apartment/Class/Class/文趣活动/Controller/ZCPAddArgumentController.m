//
//  ZCPAddArgumentController.m
//  Apartment
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPAddArgumentController.h"

#import "ZCPSectionCell.h"
#import "ZCPTextViewCell.h"
#import "ZCPSwitchRadioCell.h"
#import "ZCPButtonCell.h"

@interface ZCPAddArgumentController ()

@end

@implementation ZCPAddArgumentController

#pragma mark - life circle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"发表观点";
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
    sectionItem.sectionTitle = @"输入论据内容";
    // 论据内容
    ZCPTextViewCellItem *argumentItem = [[ZCPTextViewCellItem alloc] initWithDefault];
    argumentItem.placeholder = @"请输入论据内容,不超过50字...";
    // 选项Item
    ZCPSwitchRadioCellItem *optionItem = [[ZCPSwitchRadioCellItem alloc] initWithDefault];
    optionItem.switchInitialValue = NO;
    optionItem.switchTipText = @"匿名";
    optionItem.radioTipTextOne = @"正方";
    optionItem.radioTipTextTwo = @"反方";
    optionItem.radioButtonOneConfigBlock = ^(UIButton *button) {
        [button setImageNameNormal:@"choice_normal" Highlighted:@"choice_selected" Selected:@"choice_selected" Disabled:@"choice_normal"];
    };
    optionItem.radioButtonTwoConfigBlock = ^(UIButton *button) {
        [button setImageNameNormal:@"choice_normal" Highlighted:@"choice_selected" Selected:@"choice_selected" Disabled:@"choice_normal"];
    };
    
    // blankItem
    ZCPLineCellItem *blankItem = [[ZCPLineCellItem alloc] initWithDefault];
    // 提交按钮
    ZCPButtonCellItem *determineItem = [[ZCPButtonCellItem alloc] initWithDefault];
    determineItem.buttonTitle = @"提交";
    
    
    [items addObject:sectionItem];
    [items addObject:argumentItem];
    [items addObject:optionItem];
    
    [items addObject:blankItem];
    [items addObject:determineItem];
    self.tableViewAdaptor.items = items;
}

@end
