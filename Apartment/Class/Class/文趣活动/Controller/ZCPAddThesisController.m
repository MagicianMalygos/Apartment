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
    
    // 如果未通过输入检测则不进行提交
    if (![self judgeTextInput:thesisContent pros:thesisPros cons:thesisCons reason:thesisAddReason]) {
        return;
    }
    
    TTDPRINT(@"提交辩题中...");
    [[ZCPRequestManager sharedInstance] addThesisContent:thesisContent thesisPros:thesisPros thesisCons:thesisCons thesisAddReason:thesisAddReason currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            TTDPRINT(@"提交辩题成功！正在审核中！");
            [MBProgressHUD showSuccess:@"提交辩题成功！正在审核中！" toView:[[UIApplication sharedApplication].delegate window]];
        }
        else {
            TTDPRINT(@"提交辩题失败！");
            [MBProgressHUD showError:@"提交辩题失败！" toView:[[UIApplication sharedApplication].delegate window]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"提交失败！%@", error);
        [MBProgressHUD showError:@"提交辩题失败！网络异常！" toView:[[UIApplication sharedApplication].delegate window]];
    }];
    
    // pop
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private Method
/**
 *  进行输入检测
 */
- (BOOL)judgeTextInput:(NSString *)thesisContent pros:(NSString *)thesisPros cons:(NSString *)thesisCons reason:(NSString *)thesisAddReason {
    if (thesisContent.length == 0) {
        [MBProgressHUD showError:@"辩题内容不能为空！" toView:self.view];
        return NO;
    }
    if ([thesisPros isEqualToString:@""] || [thesisCons isEqualToString:@""]) {
        [MBProgressHUD showError:@"论点不能为空！" toView:self.view];
        return NO;
    }
    if (thesisContent.length > 50) {
        [MBProgressHUD showError:@"辩题内容不得超过50字！" toView:self.view];
        return NO;
    }
    if ((thesisPros.length > 50)
        || (thesisCons.length > 50)) {
        [MBProgressHUD showError:@"论点内容不得超过50字！" toView:self.view];
        return NO;
    }
    if (thesisAddReason.length > 1000) {
        [MBProgressHUD showError:@"原因不能超过1000字！" toView:self.view];
        return NO;
    }
    return YES;
}

@end
