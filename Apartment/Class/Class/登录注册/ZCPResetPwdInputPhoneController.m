//
//  ZCPResetPwdInputPhoneController.m
//  Apartment
//
//  Created by apple on 16/4/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPResetPwdInputPhoneController.h"
#import "ZCPResetPwdController.h"
#import "ZCPTextField.h"
#import "ZCPRequestManager+User.h"

@interface ZCPResetPwdInputPhoneController ()

@property (nonatomic, strong) ZCPTextField *phoneTextField; // 手机号输入框
@property (nonatomic, strong) UIButton *determineButton;    // 提交按钮

@end

@implementation ZCPResetPwdInputPhoneController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.determineButton];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 显示nav
    [self.navigationController setNavigationBarHidden:NO];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationItem.leftBarButtonItem = [UIBarButtonItem setBackItemWithTarget:self action:@selector(backTo)];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // 设置控件frame
    self.determineButton.frame = CGRectMake(HorizontalMargin * 2, 300, APPLICATIONWIDTH - HorizontalMargin * 4, 40);
    self.phoneTextField.frame = CGRectMake(HorizontalMargin * 2, 150, APPLICATIONWIDTH - HorizontalMargin * 4, 30);
}

#pragma mark - getter / setter
- (ZCPTextField *)phoneTextField {
    if (_phoneTextField == nil) {
        _phoneTextField = [[ZCPTextField alloc] init];
        _phoneTextField.placeholder = @"手机号";
    }
    return _phoneTextField;
}
- (UIButton *)determineButton {
    if (_determineButton == nil) {
        _determineButton = [[UIButton alloc] init];
        _determineButton.backgroundColor = [UIColor buttonDefaultColor];
        [_determineButton changeToFillet];
        [_determineButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_determineButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _determineButton;
}

#pragma mark - button click
- (void)buttonClick {
    
    NSString *phone = self.phoneTextField.text;
    
    // 判断此手机号是否已注册
    [[ZCPRequestManager sharedInstance] JudgeAccountCanBeRegisterWithAccount:phone success:^(AFHTTPRequestOperation *operation, BOOL isSuccess, NSString *msg) {
        // 如果未注册
        if (isSuccess) {
            [MBProgressHUD showError:@"该用户还未注册"];
        } else {  // 如果已注册，跳转到发送验证码修改密码控制器
            ZCPResetPwdController *vc = [ZCPResetPwdController new];
            vc.phone = phone;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
        [MBProgressHUD showError:@"网络异常"];
    }];
}

#pragma mark - back
- (void)backTo {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
