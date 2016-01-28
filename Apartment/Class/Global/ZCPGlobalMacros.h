//
//  ZCPGlobalMacros.h
//  Apartment
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 zcp. All rights reserved.
//

#ifndef ZCPGlobalMacros_h
#define ZCPGlobalMacros_h

// 当前系统版本号
#define SYSTEM_VERSION                  [[UIDevice currentDevice] systemVersion].floatValue
#define APP_IS_FOR_IPHONE5              (SCREENHEIGHT > 480)                     //判断是不是iphone5的分辨率

//设备是否ipad
#define ISIPAD                          (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
// 判断是否是高清屏
#define IS_RETINA                       ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))
#define OnePoint (1/[UIScreen mainScreen].scale)

//屏幕高度
#define SCREENHEIGHT                                [[UIScreen mainScreen] bounds].size.height
//应用高度
#define APPLICATIONHEIGHT                           [[UIScreen mainScreen] applicationFrame].size.height
//应用宽度
#define APPLICATIONWIDTH                            [[UIScreen mainScreen] applicationFrame].size.width
//计算相对高度
#define RelativeHeight(originHeight)                (originHeight/480.0)*APPLICATIONHEIGHT
// 状态栏高度
#define Height_StatusBar                            20
// 导航栏高度
#define Height_NavigationBar                        44
//#define Height_TABBAR                              ((int)(APPLICATIONWIDTH *  68.0/320.0))
#define Height_TABBAR                               48

// 默认间距
#define MARGIN_DEFAULT                              8
// 水平边距
#define HorizontalMargin                            8
// 垂直边距
#define VerticalMargin                              8
// 默认控件间距
#define UIMargin                                    8

// Block循环引用
#define WEAK_SELF __weak typeof(self)weakSelf = self
#define STRONG_SELF __strong typeof(weakSelf)self = weakSelf


//从hex string获得uicolor
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// RGB色值
#define RGB(r,g,b)                      [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

// 颜色
#define COLOR_FONT_GREEN                    [UIColor colorWithRed:46.0f/255.0f green:175.0f/255.0f blue:1.0f/255.0f alpha:1.0f]
#define COLOR_FONT_DARK_GREEN               [UIColor colorWithRed:51.0f/255.0f green:153.0f/255.0f blue:0.0f/255.0f alpha:1.0f]
#define COLOR_FONT_ORANGE                   [UIColor colorWithRed:250.0f/255.0f green:87.0f/255.0f blue:40.0f/255.0f alpha:1.0f]
#define COLOR_FONT_BLACK                    [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f]
#define COLOR_FONT_DEFAULT                  [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f]
#define COLOR_FONT_GRAY                     [UIColor colorWithRed:128.0f/255.0f green:128.0f/255.0f blue:128.0f/255.0f alpha:1.0f]
#define COLOR_FONT_DARKGRAY                 [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f]
#define COLOR_FONT_MEDIUM_GRAY              [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f]
#define COLOR_GRAY                          [UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:204.0f/255.0f alpha:1.0f]
#define COLOR_VIEW                          [UIColor colorWithRed:244.0f/255.0f green:243.0f/255.0f blue:237.0f/255.0f alpha:1.0f]
#define COLOR_VIEW2                         [UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1.0f]
#define COLOR_LINE                          [UIColor colorWithRed:187.0f/255.0f green:187.0f/255.0f blue:187.0f/255.0f alpha:1.0f]

#endif /* ZCPGlobalMacros_h */
