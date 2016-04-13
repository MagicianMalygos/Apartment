//
//  UIBarButtonItem+Category.h
//  Apartment
//
//  Created by apple on 15/12/31.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Category)

// 创建并设置leftBarButton
+ (instancetype)setBackItemWithTarget:(id)target action:(SEL)action;

+ (instancetype)barItemWithTitle:(NSString *)title font:(UIFont *)font target:(id)target action:(SEL)action;

@end
