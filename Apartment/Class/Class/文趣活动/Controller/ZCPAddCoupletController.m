//
//  ZCPAddCoupletController.m
//  Apartment
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPAddCoupletController.h"
#import "ZCPSectionCell.h"
#import "ZCPTextViewCell.h"
#import "ZCPButtonCell.h"
#import "ZCPRequestManager+Couplet.h"

@interface ZCPAddCoupletController () <ZCPButtonCellDelegate>

@end

@implementation ZCPAddCoupletController

#pragma mark - life cycle
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
    sectionItem.sectionTitle = @"写对联";
    // 对联内容
    ZCPTextViewCellItem *textItem = [[ZCPTextViewCellItem alloc] initWithDefault];
    textItem.cellHeight = @40;
    textItem.placeholder = @"请输入对联内容，不超过50个字...";
    
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
    
    ZCPTextViewCellItem *textItem = [self.tableViewAdaptor.items objectAtIndex:1];
    NSString *coupletContent = textItem.textInputValue;
    
    // 空值检测
    if ([ZCPJudge judgeNullTextInput:coupletContent showErrorMsg:@"对联内容不能为空！"]
        || [ZCPJudge judgeOutOfRangeTextInput:coupletContent range:[ZCPLengthRange rangeWithMin:1 max:50] showErrorMsg:@"字数不得超过50字！"]) {
        return;
    }
    
    TTDPRINT(@"提交对联中...");
    [[ZCPRequestManager sharedInstance] addCoupletContent:coupletContent currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            TTDPRINT(@"提交对联成功！！");
            [MBProgressHUD showSuccess:@"对联添加成功！" toView:[[UIApplication sharedApplication].delegate window]];
        } else {
            TTDPRINT(@"提交对联失败！！");
            [MBProgressHUD showError:@"对联添加失败！" toView:[[UIApplication sharedApplication].delegate window]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"提交失败！%@", error);
        [MBProgressHUD showError:@"对联添加失败！网络异常！" toView:[[UIApplication sharedApplication].delegate window]];
    }];
    
    // pop
    [self.navigationController popViewControllerAnimated:YES];
}

@end
