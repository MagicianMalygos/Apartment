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
#import "ZCPRequestManager+Thesis.h"

@interface ZCPAddThesisController () <ZCPButtonCellDelegate>

@end

@implementation ZCPAddThesisController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerKeyboardIQ];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"自定辩题";
    
    // 设置主题颜色
    self.tableView.backgroundColor = APP_THEME_BG_COLOR;
    // 更新cell颜色
    [self constructData];
    [self.tableView reloadData];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar);
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self unregisterKeyboardIQ];
}

#pragma mark - Construct Data
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    // section 1
    ZCPSectionCellItem *sectionItem1 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem1.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"你希望的辩题内容是" attributes:@{NSForegroundColorAttributeName: APP_THEME_TEXT_COLOR, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];;
    // 期望辩题内容
    ZCPTextViewCellItem *hopeThesisItem = [[ZCPTextViewCellItem alloc] initWithDefault];
    hopeThesisItem.placeholder = @"请输入辩题内容,不超过50字...";
    
    // section 2
    ZCPSectionCellItem *sectionItem2 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem2.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"正方论点" attributes:@{NSForegroundColorAttributeName: APP_THEME_TEXT_COLOR, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];;
    // 正方论点
    ZCPTextViewCellItem *prosArgumentItem = [[ZCPTextViewCellItem alloc] initWithDefault];
    prosArgumentItem.placeholder = @"请输入正方论点内容,不超过50字...";
    
    // section 3
    ZCPSectionCellItem *sectionItem3 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem3.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"反方论点" attributes:@{NSForegroundColorAttributeName: APP_THEME_TEXT_COLOR, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];;
    // 反方论点
    ZCPTextViewCellItem *consArgumentItem = [[ZCPTextViewCellItem alloc] initWithDefault];
    consArgumentItem.placeholder = @"请输入反方论点内容,不超过50字...";
    
    // section 4
    ZCPSectionCellItem *sectionItem4 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem4.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"为什么选择这个辩题" attributes:@{NSForegroundColorAttributeName: APP_THEME_TEXT_COLOR, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];;
    // 为什么选择这个辩题
    ZCPTextViewCellItem *reasonItem = [[ZCPTextViewCellItem alloc] initWithDefault];
    reasonItem.placeholder = @"请输入原因...";
    
    // blank item
    ZCPLineCellItem *blackItem = [[ZCPLineCellItem alloc] initWithDefault];
    // 提交按钮
    ZCPButtonCellItem *determineItem = [[ZCPButtonCellItem alloc] initWithDefault];
    determineItem.buttonTitle = @"提交";
    determineItem.buttonConfigBlock = ^(UIButton *button) {
        [button setTitleColor:[UIColor buttonTitleDefaultColor] forState:UIControlStateNormal];
    };
    determineItem.delegate = self;
    
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


#pragma mark - ZCPButtonCellDelegate
- (void)cell:(UITableViewCell *)cell buttonClicked:(UIButton *)button {
    
    ZCPTextViewCellItem *hopeThesisItem = [self.tableViewAdaptor.items objectAtIndex:1];
    ZCPTextViewCellItem *prosArgumentItem = [self.tableViewAdaptor.items objectAtIndex:3];
    ZCPTextViewCellItem *consArgumentItem = [self.tableViewAdaptor.items objectAtIndex:5];
    ZCPTextViewCellItem *reasonItem = [self.tableViewAdaptor.items objectAtIndex:7];
    
    NSString *thesisContent = hopeThesisItem.textInputValue;
    NSString *thesisPros = prosArgumentItem.textInputValue;
    NSString *thesisCons = consArgumentItem.textInputValue;
    NSString *thesisAddReason = reasonItem.textInputValue;
    
    // 空值检测
    if ([ZCPJudge judgeNullTextInput:thesisContent showErrorMsg:@"辩题内容不能为空！"]
        || [ZCPJudge judgeNullTextInput:thesisPros showErrorMsg:@"正方论点不能为空！"]
        || [ZCPJudge judgeNullTextInput:thesisCons showErrorMsg:@"反方论点不能为空！"]) {
        return;
    }
    // 长度检测
    if ([ZCPJudge judgeOutOfRangeTextInput:thesisContent range:[ZCPLengthRange rangeWithMin:1 max:50] showErrorMsg:@"辩题内容不得超过50字！"]
        || [ZCPJudge judgeOutOfRangeTextInput:thesisPros range:[ZCPLengthRange rangeWithMin:1 max:50] showErrorMsg:@"正方论点不得超过50字！"]
        || [ZCPJudge judgeOutOfRangeTextInput:thesisCons range:[ZCPLengthRange rangeWithMin:1 max:50] showErrorMsg:@"正方论点不得超过50字！"]
        || [ZCPJudge judgeOutOfRangeTextInput:thesisAddReason range:[ZCPLengthRange rangeWithMin:1 max:500] showErrorMsg:@"原因不得超过1000字！"]) {
        return;
    }
    
    TTDPRINT(@"提交辩题中...");
    [[ZCPRequestManager sharedInstance] addThesisContent:thesisContent thesisPros:thesisPros thesisCons:thesisCons thesisAddReason:thesisAddReason currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            TTDPRINT(@"提交辩题成功！正在审核中！");
            [MBProgressHUD showSuccess:@"提交辩题成功！正在审核中！"];
        }
        else {
            TTDPRINT(@"提交辩题失败！");
            [MBProgressHUD showError:@"提交辩题失败！"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"提交失败！%@", error);
        [MBProgressHUD showError:@"提交辩题失败！网络异常！"];
    }];
    
    // pop
    [self.navigationController popViewControllerAnimated:YES];
}

@end
