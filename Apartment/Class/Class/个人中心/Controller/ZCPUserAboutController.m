//
//  ZCPUserAboutController.m
//  Apartment
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPUserAboutController.h"

@interface ZCPUserAboutController ()

@end

@implementation ZCPUserAboutController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"关于";
    
    // 设置主题颜色
    self.tableView.backgroundColor = APP_THEME_BG_COLOR;
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

@end
