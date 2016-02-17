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
#import "ZCPRequestManager+Couplet.h"

@interface ZCPAddCoupletController () <ZCPButtonCellDelegate>

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
    determineItem.delegate = self;
    
    
    [items addObject:sectionItem];
    [items addObject:textItem];
    
    [items addObject:blankItem];
    [items addObject:determineItem];
    
    self.tableViewAdaptor.items = items;
}

#pragma mark - ZCPButtonCellDelegate
- (void)cell:(UITableViewCell *)cell buttonClicked:(UIButton *)button {
    
    ZCPTextFieldCellItem *textItem = [self.tableViewAdaptor.items objectAtIndex:1];
    NSString *coupletContent = textItem.textFieldInputValue;
    
    // 如果未通过输入检测则不进行提交
    if (![self judgeTextInput:coupletContent]) {
        return;
    }
    
    TTDPRINT(@"提交对联中...");
    [[ZCPRequestManager sharedInstance] addCoupletContent:coupletContent currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            TTDPRINT(@"提交对联成功！！");
            [MBProgressHUD showSuccess:@"对联添加成功！" toView:self.view];
        }
        else {
            [MBProgressHUD showError:@"对联添加失败！" toView:self.view];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"提交失败...%@", error);
        [MBProgressHUD showError:@"对联添加失败！网络异常" toView:self.view];
    }];
    
    // pop
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private Method
/**
 *  输入检测
 */
- (BOOL)judgeTextInput:(NSString *)text {
    if (text.length == 0) {
        [MBProgressHUD showError:@"评论不能为空！" toView:self.view];
        return NO;
    }
    else if (text.length > 50) {
        [MBProgressHUD showError:@"字数不得超过50字！" toView:self.view];
        return NO;
    }
    return YES;
}


@end
