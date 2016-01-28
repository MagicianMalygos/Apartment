//
//  UIButton+Style.h
//  haofang
//
//  Created by leo on 15/4/20.
//  Copyright (c) 2015年 平安好房. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Style)

// 默认样式
- (void)configureDefault;


// 配置成钩边样式
- (void)configureBorderStyleWithColor:(UIColor *)color;

@end
