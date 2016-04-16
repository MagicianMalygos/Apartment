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
#import "ZCPJudge.h"
#import "ZCPRequestManager+Question.h"

@interface ZCPAddQuestionController () <ZCPButtonCellDelegate>

@end

@implementation ZCPAddQuestionController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self clearNavigationBar];
    self.title = @"上传问题";
    
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
    
    // section
    ZCPSectionCellItem *sectionItem = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"问题" attributes:@{NSForegroundColorAttributeName: APP_THEME_TEXT_COLOR, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];;
    // 题目
    ZCPTextViewCellItem *questionItem = [[ZCPTextViewCellItem alloc] initWithDefault];
    questionItem.placeholder = @"请输入问题内容,不超过50字...";
    
    // section 1
    ZCPSectionCellItem *sectionItem1 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem1.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"选项一" attributes:@{NSForegroundColorAttributeName: APP_THEME_TEXT_COLOR, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];;
    // 选项一
    ZCPTextViewCellItem *optionItem1 = [[ZCPTextViewCellItem alloc] initWithDefault];
    optionItem1.cellHeight = @40;
    optionItem1.placeholder = @"请输入选项一,不超过10个字...";
    
    // section 2
    ZCPSectionCellItem *sectionItem2 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem2.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"选项二" attributes:@{NSForegroundColorAttributeName: APP_THEME_TEXT_COLOR, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];;
    // 选项二
    ZCPTextViewCellItem *optionItem2 = [[ZCPTextViewCellItem alloc] initWithDefault];
    optionItem2.cellHeight = @40;
    optionItem2.placeholder = @"请输入选项二,不超过10个字...";
    
    // section 3
    ZCPSectionCellItem *sectionItem3 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem3.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"选项三" attributes:@{NSForegroundColorAttributeName: APP_THEME_TEXT_COLOR, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];;
    // 选项三
    ZCPTextViewCellItem *optionItem3 = [[ZCPTextViewCellItem alloc] initWithDefault];
    optionItem3.cellHeight = @40;
    optionItem3.placeholder = @"请输入选项三,不超过10个字...";
    
    // section 4
    ZCPSectionCellItem *sectionItem4 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem4.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"正确答案" attributes:@{NSForegroundColorAttributeName: APP_THEME_TEXT_COLOR, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];;
    // 正确答案
    ZCPTextViewCellItem *answerItem = [[ZCPTextViewCellItem alloc] initWithDefault];
    answerItem.cellHeight = @40;
    answerItem.placeholder = @"请输入正确答案,不超过10个字...";
    
    // blank
    ZCPLineCellItem *blankItem = [[ZCPLineCellItem alloc] initWithDefault];
    // 提交按钮
    ZCPButtonCellItem *determineItem = [[ZCPButtonCellItem alloc] initWithDefault];
    determineItem.buttonTitle = @"提交";
    determineItem.buttonConfigBlock = ^(UIButton *button) {
        [button setTitleColor:[UIColor buttonTitleDefaultColor] forState:UIControlStateNormal];
    };
    determineItem.delegate = self;
    
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

#pragma mark - ZCPButtonCellDelegate
- (void)cell:(UITableViewCell *)cell buttonClicked:(UIButton *)button {
    
    ZCPTextViewCellItem *contentItem = [self.tableViewAdaptor.items objectAtIndex:1];
    ZCPTextViewCellItem *optionOneItem = [self.tableViewAdaptor.items objectAtIndex:3];
    ZCPTextViewCellItem *optionTwoItem = [self.tableViewAdaptor.items objectAtIndex:5];
    ZCPTextViewCellItem *optionThreeItem = [self.tableViewAdaptor.items objectAtIndex:7];
    ZCPTextViewCellItem *answerItem = [self.tableViewAdaptor.items objectAtIndex:9];
    
    NSString *content = contentItem.textInputValue;
    NSString *optionOne = optionOneItem.textInputValue;
    NSString *optionTwo = optionTwoItem.textInputValue;
    NSString *optionThree = optionThreeItem.textInputValue;
    NSString *answer = answerItem.textInputValue;
    
    // 输入检测
    if ([ZCPJudge judgeNullTextInput:content showErrorMsg:@"问题内容不可为空！"]
        || [ZCPJudge judgeNullTextInput:optionOne showErrorMsg:@"选项一不可为空！"]
        || [ZCPJudge judgeNullTextInput:optionTwo showErrorMsg:@"选项二不可为空！"]
        || [ZCPJudge judgeNullTextInput:optionThree showErrorMsg:@"选项三不可为空！"]
        || [ZCPJudge judgeNullTextInput:answer showErrorMsg:@"选项四不可为空！"]) {
        return;
    }
    if ([ZCPJudge judgeOutOfRangeTextInput:content range:[ZCPLengthRange rangeWithMin:1 max:50] showErrorMsg:@"问题内容不能超过50字！"]
        || [ZCPJudge judgeOutOfRangeTextInput:optionOne range:[ZCPLengthRange rangeWithMin:1 max:10] showErrorMsg:@"选项一不能超过10字！"]
        || [ZCPJudge judgeOutOfRangeTextInput:optionTwo range:[ZCPLengthRange rangeWithMin:1 max:10] showErrorMsg:@"选项二不能超过10字！"]
        || [ZCPJudge judgeOutOfRangeTextInput:optionThree range:[ZCPLengthRange rangeWithMin:1 max:10] showErrorMsg:@"选项三不能超过10字！"]
        || [ZCPJudge judgeOutOfRangeTextInput:answer range:[ZCPLengthRange rangeWithMin:1 max:10] showErrorMsg:@"选项四不能超过10字！"]) {
        return;
    }
    
    [[ZCPRequestManager sharedInstance] addQuestionContent:content optionOne:optionOne optionTwo:optionTwo optionThree:optionThree answer:answer currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            [MBProgressHUD showError:@"提交题目成功！正在审核中！"];
        } else {
            [MBProgressHUD showError:@"提交题目失败！"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络异常！"];
        TTDPRINT(@"%@", error);
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
