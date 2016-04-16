//
//  ZCPSettingChangePwdController.m
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPSettingChangePwdController.h"
#import "ZCPSectionCell.h"
#import "ZCPButtonCell.h"
#import "ZCPTextFieldCell.h"
#import "ZCPJudge.h"
#import "ZCPRequestManager+User.h"

@interface ZCPSettingChangePwdController () <ZCPButtonCellDelegate>

@end

@implementation ZCPSettingChangePwdController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"用户设置";
    
    // 设置主题颜色
    self.tableView.backgroundColor = APP_THEME_BG_COLOR;
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar);
}

#pragma mark - constructData
- (void)constructData {
    
    // 文字主题颜色
    UIColor *textColor = ([ZCPControlingCenter sharedInstance].appTheme == LightTheme)?[UIColor blackColor]:[UIColor whiteColor];
    
    ZCPSectionCellItem *sectionItem1 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem1.backgroundColor = [UIColor lightGrayColor];;
    sectionItem1.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem1.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"请输入原密码" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    // 密码
    ZCPTextFieldCellItem *oldPwdItem = [[ZCPTextFieldCellItem alloc] initWithDefault];
    oldPwdItem.textFieldConfigBlock = ^(UITextField *textField) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入原密码" attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:15.0f], NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
        textField.secureTextEntry = YES;
    };
    
    ZCPSectionCellItem *sectionItem2 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem2.backgroundColor = [UIColor lightGrayColor];;
    sectionItem2.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem2.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"请输入新密码" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    // 密码
    ZCPTextFieldCellItem *newPwdItem = [[ZCPTextFieldCellItem alloc] initWithDefault];
    newPwdItem.textFieldConfigBlock = ^(UITextField *textField) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入新密码" attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:15.0f], NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
        textField.secureTextEntry = YES;
    };
    
    ZCPSectionCellItem *sectionItem3 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem3.backgroundColor = [UIColor lightGrayColor];;
    sectionItem3.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem3.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"请再次输入" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    // 重复密码
    ZCPTextFieldCellItem *reNewPwdItem = [[ZCPTextFieldCellItem alloc] initWithDefault];
    reNewPwdItem.textFieldConfigBlock = ^(UITextField *textField) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请再次输入" attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:15.0f], NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
        textField.secureTextEntry = YES;
    };
    
    ZCPLineCellItem *blankItem = [[ZCPLineCellItem alloc] initWithDefault];
    // 退出登录
    ZCPButtonCellItem *determineItem = [[ZCPButtonCellItem alloc] initWithDefault];
    determineItem.cellHeight = @45;
    determineItem.buttonTitle = @"确认";
    determineItem.delegate = self;
    
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:sectionItem1];
    [items addObject:oldPwdItem];
    
    [items addObject:sectionItem2];
    [items addObject:newPwdItem];
    
    [items addObject:sectionItem3];
    [items addObject:reNewPwdItem];
    
    [items addObject:blankItem];
    [items addObject:determineItem];
    self.tableViewAdaptor.items = items;
}

#pragma mark - ZCPButtonCell Delegate
- (void)cell:(UITableViewCell *)cell buttonClicked:(UIButton *)button {
    
    ZCPTextFieldCellItem *oldPwdItem = [self.tableViewAdaptor.items objectAtIndex:1];
    ZCPTextFieldCellItem *newPwdItem = [self.tableViewAdaptor.items objectAtIndex:3];
    ZCPTextFieldCellItem *reNewPwdItem = [self.tableViewAdaptor.items objectAtIndex:5];
    
    NSString *oldPwd = oldPwdItem.textInputValue;
    NSString *newPwd = newPwdItem.textInputValue;
    NSString *reNewPwd = reNewPwdItem.textInputValue;
    
    // 输入检测
    if ([ZCPJudge judgeOutOfRangeTextInput:oldPwd range:[ZCPLengthRange rangeWithMin:6 max:18] showErrorMsg:@"旧密码长度不符合规则！"]
        || [ZCPJudge judgeOutOfRangeTextInput:newPwd range:[ZCPLengthRange rangeWithMin:6 max:18] showErrorMsg:@"新密码长度不符合规则！"]) {
        return;
    }
    if (![newPwd isEqualToString:reNewPwd]) {
        [MBProgressHUD showError:@"新密码两次输入不一致"];
        return;
    }
    
    // 提交
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] modifyPassword:newPwd oldPassword:oldPwd currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess, ZCPUserModel *model) {
        STRONG_SELF;
        if (isSuccess) {
            [[ZCPUserCenter sharedInstance] saveUserModel:model];
            TTDPRINT(@"用户密码修改成功！");
            [MBProgressHUD showError:@"修改成功！"];
            
            // reload清空数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
        [MBProgressHUD showError:@"修改失败！网络异常！"];
    }];
}


@end
