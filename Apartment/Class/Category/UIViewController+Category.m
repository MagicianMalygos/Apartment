//
//  UIViewController+Category.m
//  Apartment
//
//  Created by apple on 15/12/31.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "UIViewController+Category.h"

@implementation UIViewController (Category)

/**
 *  返回上级视图
 */
- (void)backTo {
    if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([self.tabBarController.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
        [self.tabBarController.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/**
 *  设置通用返回按钮
 */
- (void)setBackBarButton {
    // 通用返回按钮
    [UIBarButtonItem setBackItemWithTarget:self action:@selector(backTo)];
}

- (void)clearNavigationBar {
    self.tabBarController.navigationItem.titleView = nil;
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}

@end
