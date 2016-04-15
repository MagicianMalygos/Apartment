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

// 设备是否ipad
#define ISIPAD                          (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
// 判断是否是高清屏
#define IS_RETINA                       ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))
#define OnePoint (1/[UIScreen mainScreen].scale)

// 设备是否支持打开相机
#define PHOTO_LIBRARY_AVAILABLE [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]
// 设备是否支持打开相册
#define CAMERA_AVAILABLE        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]

// TODO: 时间性能测量用
// 结束时间除以CLOCKS_PER_SEC得到耗时秒数
#define START_COUNT_TIME(start) clock_t start = clock()
#define END_COUNT_TIME(start) (clock() - start)

// The general purpose logger. This ignores logging levels.
#ifdef DEBUG
#define TTDPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define TTDPRINT(xx, ...)  ((void)0)
#endif // #ifdef DEBUG

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
#define Height_TABBAR                               48

// 待计算
#define ToBeCalculated                              0
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
#define RGB(r,g,b)      [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define LIGHT_TEXT_COLOR    [UIColor colorFromHexRGB:@"828282"]   // 日间模式文字颜色
#define NIGHT_TEXT_COLOR    [UIColor colorFromHexRGB:@"808897"]   // 夜间模式文字颜色
#define LIGHT_CELL_BG_COLOR [UIColor colorFromHexRGB:@"ffffff"]   // 日间模式cell背景颜色
#define NIGHT_CELL_BG_COLOR [UIColor colorFromHexRGB:@"1e1e29"]   // 夜间模式cell背景颜色
#define LIGHT_BG_COLOR      [UIColor colorFromHexRGB:@"efeff4"]   // 日间模式背景颜色
#define NIGHT_BG_COLOR      [UIColor colorFromHexRGB:@"252634"]   // 夜间模式背景颜色

// 忽略PerformSelectorleak警告宏
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
    Stuff; \
    _Pragma("clang diagnostic pop") \
} while (0)

// app logo
#define APP_LOGO                            @"app_logo"
// 默认用户头像
#define HEAD_IMAGE_NAME_DEFAULT             @"head_default"
// 默认图书封面
#define COVER_IMAGE_NAME_DEFAULT            @"cover_default"
// 默认广告图片
#define ADVERTISEMEN_IMAGE_DEFAULT          @"advertisement_default"
// 默认列表一页数据量
#define PAGE_COUNT_DEFAULT                  10
// 盐，四位随机数
#define SALT                                (arc4random() % 9000 + 1000)

//SMSSDK官网公共key
#define AppKey_SMS      @"f3fc6baa9ac4"
#define AppSecrect_SMS  @"7f3dedcb36d92deebcb373af921d635a"


#endif /* ZCPGlobalMacros_h */
