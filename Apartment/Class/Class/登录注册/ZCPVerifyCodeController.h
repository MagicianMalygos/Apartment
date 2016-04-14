//
//  ZCPVerifyCodeController.h
//  Apartment
//
//  Created by apple on 16/4/13.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPViewController.h"

// 手机注册接收验证码的视图控制器
@interface ZCPVerifyCodeController : ZCPViewController

// 注册界面传过来的参数
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *password;

@end
