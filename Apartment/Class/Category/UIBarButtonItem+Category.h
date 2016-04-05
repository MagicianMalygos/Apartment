//
//  UIBarButtonItem+Category.h
//  Apartment
//
//  Created by apple on 15/12/31.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Category)

// 创建导航栏返回按钮
+ (id)setCustomBackBarItem:(NSString *)title target:(id)target action:(SEL)action;
// 创建并设置leftBarButton
+ (id)setBackItemWithTarget:(id)target action:(SEL)action;
// 创建不带标题的leftBarButton
+ (id)setCustomBackBarItemWithTarget:(id)target action:(SEL)action;

+ (id)barItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+ (id)barItemWithTitle:(NSString *)title font:(UIFont *)font target:(id)target action:(SEL)action;

@end
