//
//  ZCPResetPwdController.h
//  Apartment
//
//  Created by apple on 16/4/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPViewController.h"

// 发送并验证验证码，进行密码重设的视图控制器
@interface ZCPResetPwdController : ZCPViewController

@property (nonatomic, strong) NSString *phone;  // 重设密码输入手机号视图控制器传过来的手机号

@end
