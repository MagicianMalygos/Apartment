//
//  UILabel+Category.h
//  haofang
//
//  Created by DengJinlong on 4/8/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Category)

// 指向下一级的图标 ">"
+ (id)labelWithIndicator;

//设置label行间距
- (void)setLineSpace:(CGFloat)height;

// sizeToFit的留空隙版本
- (void)sizeToFitWithEdge:(UIEdgeInsets)edgeInsets;

@end
