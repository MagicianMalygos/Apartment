//
//  UIViewController+Category.h
//  Apartment
//
//  Created by apple on 15/12/31.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Category)

// 返回上一级视图
- (void)backTo;
// 设置返回按钮样式
- (void)setBackBarButton;

- (void) clearNavigationBar;

@end
