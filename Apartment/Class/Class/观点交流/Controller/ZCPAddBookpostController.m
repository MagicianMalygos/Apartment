//
//  ZCPAddBookpostController.m
//  Apartment
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPAddBookpostController.h"

@interface ZCPAddBookpostController ()

@end

@implementation ZCPAddBookpostController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self clearNavigationBar];
    self.tabBarController.title = @"观点交流";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar - Height_TABBAR);
}
#pragma mark - Construct Data
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    self.tableViewAdaptor.items = items;
}


@end
