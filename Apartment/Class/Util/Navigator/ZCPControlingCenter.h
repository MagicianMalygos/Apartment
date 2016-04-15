//
//  ZCPControlingCenter.h
//  Apartment
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

// App主题
typedef NS_ENUM(NSUInteger, APPTheme) {
    LightTheme,
    DarkTheme,
};

@interface ZCPControlingCenter : NSObject

@property (nonatomic, assign) APPTheme appTheme;

DEF_SINGLETON(ZCPControlingCenter)

/**
 *  获取应用程序根控制器
 *
 *  @return NavigationController
 */
- (UIViewController *)generateRootViewController;

// 获取tabbar
- (UITabBarController *)tabBarController;

@end
