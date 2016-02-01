//
//  UIFont+Category.h
//  haofang
//
//  Created by Aim on 14-4-2.
//  Copyright (c) 2014年 平安好房. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Category)

//使用平安好房字体
+ (UIFont *)defaultFontWithSize:(CGFloat)size;
+ (UIFont *)defaultBoldFontWithSize:(CGFloat)size;
+ (UIFont *)defaultFontWithSize:(CGFloat)size weight:(CGFloat)weight;

+ (UIFont *)defaultCellTitleFont;
+ (UIFont *)defaultListTitleFont;
+ (UIFont *)defaultListSubTitleFont;
@end
