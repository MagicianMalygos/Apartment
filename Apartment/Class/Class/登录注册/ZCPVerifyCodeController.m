//
//  ZCPVerifyCodeController.m
//  Apartment
//
//  Created by apple on 16/4/13.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPVerifyCodeController.h"
#import "ZCPTextField.h"
#import "ZCPRequestManager+Login.h"

@interface ZCPVerifyCodeController ()

@property (nonatomic, strong) UILabel *tipInfoLabel;                // 提示信息label
@property (nonatomic, strong) ZCPTextField *verifyCodeTextField;    // 验证码输入框
@property (nonatomic, strong) UIButton *determineButton;            // 完成按钮
@property (nonatomic, strong) UILabel *resendVerifyCodeLabel;       // 重发送验证码label

@end

@implementation ZCPVerifyCodeController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tipInfoLabel];
    [self.view addSubview:self.verifyCodeTextField];
    [self.view addSubview:self.determineButton];
    [self.view addSubview:self.resendVerifyCodeLabel];
    
    // 上个视图控制器的信息验证成功，首次发送验证码
    [self tapResendVerifyCodeLabel:nil];
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
    self.tipInfoLabel.frame = CGRectMake(HorizontalMargin * 2, VerticalMargin * 2 + Height_StatusBar + Height_NavigationBar, APPLICATIONWIDTH - HorizontalMargin * 4, 20);
    [self.resendVerifyCodeLabel sizeToFit];
    self.resendVerifyCodeLabel.frame = CGRectMake(self.view.center.x - self.resendVerifyCodeLabel.width / 2, self.view.center.y - 15, self.resendVerifyCodeLabel.width, 30);
    self.determineButton.frame = CGRectMake(HorizontalMargin * 2, self.resendVerifyCodeLabel.top - HorizontalMargin * 2 - 40, APPLICATIONWIDTH - HorizontalMargin * 4, 40);
    self.verifyCodeTextField.frame = CGRectMake(HorizontalMargin * 2, (self.determineButton.top - self.tipInfoLabel.bottom) / 2 + self.tipInfoLabel.bottom - 15, APPLICATIONWIDTH - HorizontalMargin * 4, 30);
}

#pragma mark - getter / setter
- (UILabel *)tipInfoLabel {
    if (_tipInfoLabel == nil) {
        _tipInfoLabel = [[UILabel alloc] init];
        _tipInfoLabel.textAlignment = NSTextAlignmentCenter;
        _tipInfoLabel.font = [UIFont defaultFontWithSize:14.0f];
        _tipInfoLabel.text = [NSString stringWithFormat:@"短信验证码已发送至 %@ 请注意查收", _phone];
    }
    return _tipInfoLabel;
}
- (ZCPTextField *)verifyCodeTextField {
    if (_verifyCodeTextField == nil) {
        _verifyCodeTextField = [[ZCPTextField alloc] init];
        _verifyCodeTextField.placeholder = @"验证码";
        _verifyCodeTextField.font = [UIFont defaultBoldFontWithSize:20.0f];
    }
    return _verifyCodeTextField;
}
- (UIButton *)determineButton {
    if (_determineButton == nil) {
        _determineButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _determineButton.backgroundColor = [UIColor buttonDefaultColor];
        [_determineButton changeToFillet];
        [_determineButton setTitle:@"提交" forState:UIControlStateNormal];
        [_determineButton addTarget:self action:@selector(determineRegister) forControlEvents:UIControlEventTouchUpInside];
    }
    return _determineButton;
}
- (UILabel *)resendVerifyCodeLabel {
    if (_resendVerifyCodeLabel == nil) {
        _resendVerifyCodeLabel = [[UILabel alloc] init];
        _resendVerifyCodeLabel.font = [UIFont defaultFontWithSize:16.0f];
        _resendVerifyCodeLabel.textAlignment = NSTextAlignmentCenter;
        _resendVerifyCodeLabel.userInteractionEnabled = YES;
        _resendVerifyCodeLabel.textColor = [UIColor blueColor];
        _resendVerifyCodeLabel.text = @"重新发送验证码";
        
        [_resendVerifyCodeLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapResendVerifyCodeLabel:)]];
    }
    return _resendVerifyCodeLabel;
}

#pragma mark - button clicked
- (void)determineRegister {
    // 判断验证码是否有误
    [SMSSDK commitVerificationCode:self.verifyCodeTextField.text phoneNumber:self.phone zone:@"86" result:^(NSError *error) {
        if (error) {
            TTDPRINT(@"验证失败：%@", error);
            [MBProgressHUD showError:[NSString stringWithFormat:@"%@", [[error userInfo] valueForKey:@"commitVerificationCode"]]];
        } else {
            TTDPRINT(@"验证成功");
            // 提交用户信息
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] registerWithUserName:weakSelf.userName account:weakSelf.phone password:weakSelf.password success:^(AFHTTPRequestOperation *operation, NSString *msg, ZCPUserModel *userModel) {
                if (userModel) {
                    // 保存用户信息
                    [[ZCPUserCenter sharedInstance] saveUserModel:userModel];
                    // 进入主界面
                    [[ZCPNavigator sharedInstance] setupRootViewController];
                }
                TTDPRINT(@"%@", msg);
                [MBProgressHUD showError:msg];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
                [MBProgressHUD showError:@"网络异常"];
            }];
        }
    }];
}
- (void)tapResendVerifyCodeLabel:(UITapGestureRecognizer *)tapGesture {
    
    WEAK_SELF;
    // 发送验证码请求
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phone zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (error) {
            TTDPRINT(@"获取验证码失败：%@", error);
            [MBProgressHUD showError:[NSString stringWithFormat:@"%@", [[error userInfo] valueForKey:@"getVerificationCode"]]];
        } else {
            TTDPRINT(@"获取验证码成功");
        }
    }];
    
    // 设置label为不可点状态
    weakSelf.resendVerifyCodeLabel.userInteractionEnabled = NO;
    weakSelf.resendVerifyCodeLabel.textColor = [UIColor lightGrayColor];
    
    // 开定时器
    __block int timeout = 60;  // 倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);  // 每秒执行
    dispatch_source_set_event_handler(timer, ^{
        if (timeout < 0) {  // 倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                // 重新设置label
                weakSelf.resendVerifyCodeLabel.userInteractionEnabled = YES;
                weakSelf.resendVerifyCodeLabel.textColor = [UIColor blueColor];
                
                weakSelf.resendVerifyCodeLabel.text = @"重新发送验证码";
                [weakSelf.resendVerifyCodeLabel sizeToFit];
            });
        } else {  // 倒计时未结束，设置label的text
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.resendVerifyCodeLabel.text = [NSString stringWithFormat:@"%d 秒后 重新发送验证码", timeout];
                [weakSelf.resendVerifyCodeLabel sizeToFit];
                timeout --;
            });
        }
    });
    dispatch_resume(timer);
}

#pragma mark - back
- (void)backTo {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
