//
//  UIFont+Category.m
//  haofang
//
//  Created by Aim on 14-4-2.
//  Copyright (c) 2014年 平安好房. All rights reserved.
//

#import "UIFont+Category.h"

@implementation UIFont (Category)

// 默认字体
+ (UIFont *)defaultFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"Helvetica" size:size];
}
+ (UIFont *)defaultBoldFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"Helvetica-Bold" size:size];
}
+ (UIFont *)defaultFontWithSize:(CGFloat)size weight:(CGFloat)weight {
    return [UIFont systemFontOfSize:size weight:weight];
}

// 标题字体
+ (UIFont *)defaultCellTitleFont {
    return [UIFont systemFontOfSize:16.0f];
}

// 列表主标题字体
+ (UIFont *)defaultListTitleFont {
    return [UIFont boldSystemFontOfSize:16.0];
}

// 列表子标题字体
+ (UIFont *)defaultListSubTitleFont {
    return [UIFont systemFontOfSize:13.0];
}

@end
