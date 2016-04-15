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
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // 设置主题颜色
    if ([ZCPControlingCenter sharedInstance].appTheme == LightTheme) {
        [self.tableView setBackgroundColor:LIGHT_BG_COLOR];
    }
    else if([ZCPControlingCenter sharedInstance].appTheme == DarkTheme) {
        [self.tableView setBackgroundColor:NIGHT_BG_COLOR];
    }
}

@end
