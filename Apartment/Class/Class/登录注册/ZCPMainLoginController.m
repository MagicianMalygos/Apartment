//
//  ZCPMainLoginController.m
//  Apartment
//
//  Created by apple on 16/2/19.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPMainLoginController.h"

@interface ZCPMainLoginController ()

@end

@implementation ZCPMainLoginController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 重新刷新用户信息
    [self constructData];
    [self.tableView reloadData];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar - Height_TABBAR);
    
    self.appTheme = [[ZCPControlingCenter sharedInstance] appTheme];
    if (self.appTheme == LightTheme) {
        [self.tableView setBackgroundColor:[UIColor colorFromHexRGB:@"ececec"]];
    }
    else if(self.appTheme == DarkTheme) {
        [self.tableView setBackgroundColor:[UIColor lightGrayColor]];
    }
}

#pragma mark - constructData
- (void)constructData {
    
}

@end
