//
//  ZCPAddThesisController.m
//  Apartment
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPAddThesisController.h"

#import "ZCPSectionCell.h"
#import "ZCPTextViewCell.h"
#import "ZCPButtonCell.h"

@interface ZCPAddThesisController ()

@end

@implementation ZCPAddThesisController

#pragma mark - life circle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"分享辩题";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar);
}

#pragma mark - Construct Data
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    // section 1
    ZCPSectionCellItem *sectionItem1 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem1.sectionTitle = @"你希望辩题的内容是";
    // 期望辩题内容
    ZCPTextViewCellItem *hopeThesisItem = [[ZCPTextViewCellItem alloc] initWithDefault];
    hopeThesisItem.placeholder = @"请输入辩题内容,不超过50字...";
    
    // section 2
    ZCPSectionCellItem *sectionItem2 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem2.sectionTitle = @"正方论点";
    // 正方论点
    ZCPTextViewCellItem *prosArgumentItem = [[ZCPTextViewCellItem alloc] initWithDefault];
    prosArgumentItem.placeholder = @"请输入正方论点内容,不超过50字...";
    
    // section 3
    ZCPSectionCellItem *sectionItem3 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem3.sectionTitle = @"反方论点";
    // 反方论点
    ZCPTextViewCellItem *consArgumentItem = [[ZCPTextViewCellItem alloc] initWithDefault];
    consArgumentItem.placeholder = @"请输入反方论点内容,不超过50字...";
    
    // section 4
    ZCPSectionCellItem *sectionItem4 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem4.sectionTitle = @"为什么选择这个辩题";
    // 为什么选择这个辩题
    ZCPTextViewCellItem *reasonItem = [[ZCPTextViewCellItem alloc] initWithDefault];
    reasonItem.placeholder = @"请输入原因...";
    
    
    // blank item
    ZCPLineCellItem *blackItem = [[ZCPLineCellItem alloc] initWithDefault];
    // 提交按钮
    ZCPButtonCellItem *determineItem = [[ZCPButtonCellItem alloc] initWithDefault];
    determineItem.buttonTitle = @"提交";
    
    
    [items addObject:sectionItem1];
    [items addObject:hopeThesisItem];
    
    [items addObject:sectionItem2];
    [items addObject:prosArgumentItem];
    
    [items addObject:sectionItem3];
    [items addObject:consArgumentItem];
    
    [items addObject:sectionItem4];
    [items addObject:reasonItem];
    
    [items addObject:blackItem];
    [items addObject:determineItem];
    self.tableViewAdaptor.items = items;
}


@end
