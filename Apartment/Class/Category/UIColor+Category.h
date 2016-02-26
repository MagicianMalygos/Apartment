//
//  UIColor+Category.h
//  haofang
//
//  Created by PengFeiMeng on 3/26/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

// 系统的Nav颜色
+ (UIColor *)systemNavigationColor;

// button默认颜色
+ (UIColor *)buttonDefaultColor;

// - - - - - - - - - - - - - - - - - - - - - - - -
+ (UIColor *)PADefaultBackgroundColor;
+ (UIColor *)PAGrayColor;
+ (UIColor *)PALightGrayColor;
+ (UIColor *)PAOrangeColor;
+ (UIColor *)PABtnBgOrangeColor;
+ (UIColor *)PAOrangeHighlightColor;
+ (UIColor *)PAGreenColor;
+ (UIColor *)PAGreenHighlightColor;
+ (UIColor *)PABlackTextColor;
+ (UIColor *)PADimColor;
+ (UIColor *)PABlueColor;
+ (UIColor *)PARateGreenColor;
//导航条背景色
+ (UIColor *)PANavigationBarBgColor;
//工具栏、电话条背景
+ (UIColor *)PAToolBarBgColor;
//优惠icon颜色
+ (UIColor *)PAYouHuiColor;
//好房贷icon颜色
+ (UIColor *)PAHFLoanColor;
//价格颜色
+ (UIColor *)PAPriceColor;
//价格单位颜色
+ (UIColor *)PAPriceUnitColor;
//列表主标题颜色
+ (UIColor *)PATitleColor;
//列表子标题颜色
+ (UIColor *)PASubTitleColor;

// 计算器饼图颜色
+ (UIColor *)PACalRedColor;
+ (UIColor *)PACalYellowColor;
+ (UIColor *)PACalGreenColor;

//根据颜色字符串获取Color
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;
+ (UIColor *)colorFromHex:(UInt32)color;

+ (UIColor*) colorRGBonvertToHSB:(UIColor*)color withBrighnessDelta:(CGFloat)delta;

@end
