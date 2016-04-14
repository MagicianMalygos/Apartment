//
//  ZCPMainLoginController.m
//  Apartment
//
//  Created by apple on 16/2/19.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPMainLoginController.h"
#import "ZCPVerifyCodeController.h"
#import "ZCPResetPwdInputPhoneController.h"
#import "ZCPTextField.h"
#import "ZCPJudge.h"
#import "ZCPRequestManager+User.h"

#define TextFieldWidth  APPLICATIONWIDTH - HorizontalMargin * 4
#define TextFieldHeight 30

typedef NS_ENUM(NSInteger, ZCPShowState) {
    ZCPShowLoginView = 1,   // 显示登陆界面
    ZCPShowRegisterView = 2 // 显示注册界面
};

@interface ZCPMainLoginController ()

@property (nonatomic, strong) UIImageView *logoImageView;           // logo图片视图
@property (nonatomic, strong) UIScrollView *inputAreaScrollView;    // 输入区滑动视图
@property (nonatomic, strong) ZCPTextField *phoneTextField;         // 账号输入框
@property (nonatomic, strong) ZCPTextField *passwordTextField;      // 密码输入框
@property (nonatomic, strong) ZCPTextField *regUserNameTextField;   // 注册界面用户名输入框
@property (nonatomic, strong) ZCPTextField *regPhoneTextField;      // 注册界面手机号输入框
@property (nonatomic, strong) ZCPTextField *regPasswordTextField;   // 注册界面面输入框
@property (nonatomic, strong) UIButton *loginRegisterButton;        // 登陆按钮
@property (nonatomic, strong) UILabel *toggleLabel;                 // 切换标签
@property (nonatomic, strong) UILabel *resetPasswordLabel;          // 重置密码标签
@property (nonatomic, assign) ZCPShowState showState;               // 显示TextField状态

@end

@implementation ZCPMainLoginController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    self.showState = ZCPShowLoginView;
    
    [self.view addSubview:self.logoImageView];
    [self.inputAreaScrollView addSubview:self.phoneTextField];
    [self.inputAreaScrollView addSubview:self.passwordTextField];
    [self.inputAreaScrollView addSubview:self.regUserNameTextField];
    [self.inputAreaScrollView addSubview:self.regPhoneTextField];
    [self.inputAreaScrollView addSubview:self.regPasswordTextField];
    [self.view addSubview:self.inputAreaScrollView];
    [self.view addSubview:self.loginRegisterButton];
    [self.view addSubview:self.toggleLabel];
    [self.view addSubview:self.resetPasswordLabel];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏nav
    [self.navigationController setNavigationBarHidden:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // 设置控件frame
    self.logoImageView.frame = CGRectMake(self.view.center.x - 40, VerticalMargin * 6, 80, 80);
    self.loginRegisterButton.frame = CGRectMake(HorizontalMargin * 2, self.view.center.y - 20, APPLICATIONWIDTH - HorizontalMargin * 4, 40);
    self.inputAreaScrollView.frame = CGRectMake(0, self.loginRegisterButton.top - 90 - UIMargin * 4, APPLICATIONWIDTH, 90 + UIMargin * 2);
    
    self.phoneTextField.frame = CGRectMake(HorizontalMargin * 2, 30 + UIMargin, TextFieldWidth, TextFieldHeight);
    self.passwordTextField.frame = CGRectMake(HorizontalMargin * 2, 60 + UIMargin * 2, TextFieldWidth, TextFieldHeight);
    self.regUserNameTextField.frame = CGRectMake(APPLICATIONWIDTH + HorizontalMargin * 2, 0, TextFieldWidth, TextFieldHeight);
    self.regPhoneTextField.frame = CGRectMake(APPLICATIONWIDTH + HorizontalMargin * 2, 30 + UIMargin, TextFieldWidth, TextFieldHeight);
    self.regPasswordTextField.frame = CGRectMake(APPLICATIONWIDTH + HorizontalMargin * 2, 60 + UIMargin * 2, TextFieldWidth, TextFieldHeight);
    [self.toggleLabel sizeToFit];
    self.toggleLabel.frame = CGRectMake(self.view.center.x - self.toggleLabel.width / 2, self.loginRegisterButton.bottom + UIMargin * 5, self.toggleLabel.width, 30);
    [self.resetPasswordLabel sizeToFit];
    self.resetPasswordLabel.frame = CGRectMake(self.view.center.x - self.resetPasswordLabel.width / 2, APPLICATIONHEIGHT - VerticalMargin * 2, self.resetPasswordLabel.width, 20);
}

#pragma mark - getter / setter
- (UIImageView *)logoImageView {
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.image = [UIImage imageNamed:HEAD_IMAGE_NAME_DEFAULT];
    }
    return _logoImageView;
}
- (UIButton *)loginRegisterButton {
    if (_loginRegisterButton == nil) {
        _loginRegisterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginRegisterButton.backgroundColor = [UIColor buttonDefaultColor];
        [_loginRegisterButton setTitle:@"登陆" forState:UIControlStateNormal];
        [_loginRegisterButton changeToFillet];
        [_loginRegisterButton addTarget:self action:@selector(loginRegister) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginRegisterButton;
}
- (UIScrollView *)inputAreaScrollView {
    if (_inputAreaScrollView == nil) {
        _inputAreaScrollView = [[UIScrollView alloc] init];
        _inputAreaScrollView.contentSize = CGSizeMake(APPLICATIONWIDTH * 2, 60 + UIMargin);
        _inputAreaScrollView.scrollEnabled = NO;
        _inputAreaScrollView.showsHorizontalScrollIndicator = NO;
        _inputAreaScrollView.showsVerticalScrollIndicator = NO;
    }
    return _inputAreaScrollView;
}
- (ZCPTextField *)phoneTextField {
    if (_phoneTextField == nil) {
        _phoneTextField = [[ZCPTextField alloc] init];
        _phoneTextField.placeholder = @"手机号";
    }
    return _phoneTextField;
}
- (ZCPTextField *)passwordTextField {
    if (_passwordTextField == nil) {
        _passwordTextField = [[ZCPTextField alloc] init];
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.placeholder = @"密码";
    }
    return _passwordTextField;
}
- (ZCPTextField *)regUserNameTextField {
    if (_regUserNameTextField == nil) {
        _regUserNameTextField = [[ZCPTextField alloc] init];
        _regUserNameTextField.placeholder = @"姓名";
    }
    return _regUserNameTextField;
}
- (ZCPTextField *)regPhoneTextField {
    if (_regPhoneTextField == nil) {
        _regPhoneTextField = [[ZCPTextField alloc] init];
        _regPhoneTextField.placeholder = @"手机号（仅支持中国大陆号码）";
    }
    return _regPhoneTextField;
}
- (ZCPTextField *)regPasswordTextField {
    if (_regPasswordTextField == nil) {
        _regPasswordTextField = [[ZCPTextField alloc] init];
        _regPasswordTextField.secureTextEntry = YES;
        _regPasswordTextField.placeholder = @"密码（不少于6位）";
    }
    return _regPasswordTextField;
}
- (UILabel *)toggleLabel {
    if (_toggleLabel == nil) {
        _toggleLabel = [[UILabel alloc] init];
        _toggleLabel.textAlignment = NSTextAlignmentCenter;
        _toggleLabel.userInteractionEnabled = YES;
        _toggleLabel.text = (_showState == ZCPShowLoginView)? @"没有账号？去注册" : @"已有账号？去登陆";
        WEAK_SELF;
        [_toggleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            UITapGestureRecognizer *tap = sender;
            UILabel *label = (UILabel *)tap.view;
            CGPoint offset = CGPointZero;
            if (weakSelf.showState == ZCPShowLoginView) {
                weakSelf.showState = ZCPShowRegisterView;
                offset = CGPointMake(APPLICATIONWIDTH, 0);
                label.text = @"已有账号？去登陆";
                [weakSelf.loginRegisterButton setTitle:@"注册" forState:UIControlStateNormal];
            } else {
                weakSelf.showState = ZCPShowLoginView;
                offset = CGPointMake(0, 0);
                label.text = @"没有账号？去注册";
                [weakSelf.loginRegisterButton setTitle:@"登陆" forState:UIControlStateNormal];
            }
            [UIView animateWithDuration:0.3f animations:^{
                weakSelf.inputAreaScrollView.contentOffset = offset;
            }];
        }]];
    }
    return _toggleLabel;
}
- (UILabel *)resetPasswordLabel {
    if (_resetPasswordLabel == nil) {
        _resetPasswordLabel = [[UILabel alloc] init];
        _resetPasswordLabel.userInteractionEnabled = YES;
        _resetPasswordLabel.font = [UIFont defaultFontWithSize:13.0f];
        _resetPasswordLabel.textColor = [UIColor lightGrayColor];
        _resetPasswordLabel.text = @"登陆有问题？";
        WEAK_SELF;
        [_resetPasswordLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [weakSelf.navigationController pushViewController:[ZCPResetPwdInputPhoneController new] animated:YES];
        }]];
    }
    return _resetPasswordLabel;
}

#pragma mark - button click
// 登陆注册按钮点击事件
- (void)loginRegister {
    if (self.showState == ZCPShowLoginView) {
        NSString *phone = self.phoneTextField.text;
        NSString *password = self.passwordTextField.text;
        
        // 输入检测
        if ([ZCPJudge judgeNullTextInput:phone showErrorMsg:@"手机号不能为空！"]
            || [ZCPJudge judgeNullTextInput:password showErrorMsg:@"密码不能为空！"]
            || [ZCPJudge judgeOutOfRangeTextInput:phone range:[ZCPLengthRange rangeWithMin:1 max:11] showErrorMsg:@"手机号码长度超过限制！"]
            || [ZCPJudge judgeOutOfRangeTextInput:password range:[ZCPLengthRange rangeWithMin:6 max:18] showErrorMsg:@"密码长度超过限制！"]) {
            return;
        }
        
        // 尝试登陆
        [[ZCPRequestManager sharedInstance] loginWithAccount:phone password:password success:^(AFHTTPRequestOperation *operation, NSString *msg, ZCPUserModel *userModel) {
            if (userModel && [userModel isKindOfClass:[ZCPUserModel class]]) {
                [[ZCPUserCenter sharedInstance] saveUserModel:userModel];
                
                // 登录成功，进入主视图
                [[ZCPNavigator sharedInstance] setupRootViewController];
            }
            TTDPRINT(@"%@", msg);
            [MBProgressHUD showError:msg];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            TTDPRINT(@"%@", error);
            [MBProgressHUD showError:@"登录失败，网络异常！"];
        }];
        
    } else if(self.showState == ZCPShowRegisterView) {
        NSString *userName = self.regUserNameTextField.text;
        NSString *phone = self.regPhoneTextField.text;
        NSString *password = self.regPasswordTextField.text;
        
        // 输入检测
        if ([ZCPJudge judgeNullTextInput:userName showErrorMsg:@"用户名不能为空！"]
            || [ZCPJudge judgeNullTextInput:phone showErrorMsg:@"手机号不能为空！"]
            || [ZCPJudge judgeNullTextInput:password showErrorMsg:@"密码不能为空！"]
            || [ZCPJudge judgeOutOfRangeTextInput:userName range:[ZCPLengthRange rangeWithMin:1 max:10] showErrorMsg:@"用户名不能超过10个字！"]
            || [ZCPJudge judgeOutOfRangeTextInput:phone range:[ZCPLengthRange rangeWithMin:1 max:11] showErrorMsg:@"手机号码长度超过限制！"]
            || [ZCPJudge judgeOutOfRangeTextInput:password range:[ZCPLengthRange rangeWithMin:6 max:18] showErrorMsg:@"密码长度超过限制！"]) {
            return;
        }
        
        // 进入注册页面
        ZCPVerifyCodeController *verifyCodeVC = [[ZCPVerifyCodeController alloc] init];
        verifyCodeVC.userName = userName;
        verifyCodeVC.phone = phone;
        verifyCodeVC.password = password;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:verifyCodeVC];
        
        [self presentViewController:nav animated:YES completion:nil];
    }
    
}

@end
