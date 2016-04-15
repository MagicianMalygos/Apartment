//
//  ZCPControlingCenter.m
//  Apartment
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPControlingCenter.h"

// 各tabbar主视图控制器
#import "ZCPMainHotTrendController.h"
#import "ZCPMainCommunionController.h"
#import "ZCPMainActivityController.h"
#import "ZCPMainLibraryController.h"
#import "ZCPMainUserController.h"

@interface ZCPControlingCenter ()

// TabBarController
@property (nonatomic, strong) UITabBarController *tabBarController;

@end

@implementation ZCPControlingCenter

#pragma mark - synthesize
@synthesize appTheme    = _appTheme;

IMP_SINGLETON

#pragma mark - getter / setter
- (UITabBarController *)tabBarController {
    if (_tabBarController == nil) {
        _tabBarController = [[ZCPTabBarController alloc] init];
    }
    return _tabBarController;
}
- (APPTheme)appTheme {
    // 从用户配置中读取
    APPTheme appTheme = LightTheme;
    NSNumber *appThemeNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"APP_THEME"];
    if (appThemeNumber != nil) {
        appTheme = [appThemeNumber unsignedIntegerValue];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@(appTheme) forKey:@"APP_THEME"];
    }
    return appTheme;
}
- (void)setAppTheme:(APPTheme)appTheme {
    // 存入用户配置
    [[NSUserDefaults standardUserDefaults] setObject:@(appTheme) forKey:@"APP_THEME"];
}

#pragma mark - 公有方法
/**
 *  获取应用程序根控制器
 *
 *  @return NavigationController
 */
- (UIViewController *) generateRootViewController {
    UINavigationController *navigationController = nil;

    UIViewController *rootController = [self tabBarController];
    navigationController = [[ZCPNavigationController alloc] initWithRootViewController:rootController];
    
    // 设置navigation的颜色与样式
    UINavigationBar *navigationBar = navigationController.navigationBar;
    
    if ([ZCPControlingCenter sharedInstance].appTheme == LightTheme) {
        [[UINavigationBar appearance] setTintColor:LIGHT_CELL_BG_COLOR];
        navigationBar.tintColor = [UIColor colorFromHexRGB:@"575b5f"];  // 左右按钮文字颜色
        navigationBar.barTintColor = LIGHT_CELL_BG_COLOR;               // navigationBar背景颜色
    }
    else if([ZCPControlingCenter sharedInstance].appTheme == DarkTheme) {
        [[UINavigationBar appearance] setTintColor:NIGHT_CELL_BG_COLOR];
        navigationBar.tintColor = [UIColor colorFromHexRGB:@"b1b9c6"];  // 左右按钮文字颜色
        navigationBar.barTintColor = NIGHT_CELL_BG_COLOR;               // navigationBar背景颜色
    }
    UIColor *titleColor = ([ZCPControlingCenter sharedInstance].appTheme == LightTheme)? [UIColor colorFromHexRGB:@"575b5f"]: [UIColor colorFromHexRGB:@"b1b9c6"];
    NSDictionary *navTitleDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont defaultFontWithSize:18.0f], NSFontAttributeName, titleColor, NSForegroundColorAttributeName, nil];
    [navigationBar setTitleTextAttributes:navTitleDict];
    
    navigationBar.translucent = NO; // 取消半透明效果，解决界面跳转的时候能看到导航栏的颜色发生变化
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [navigationController preferredStatusBarStyle];
    
    /**
     *  此处会有一个执行的先后顺序问题
     *  之前的tabBarController方法中会设置TabBarController的各tab
     *  然后才初始化NavigationController
     *  问题：在viewDidLoad方法中获取到的NavigationController是空
     */
    // 设置各TabBarItem上视图控制器
    [_tabBarController setViewControllers:[self getTabBarViewController]];
    
    // 设置最开始展示的tab
    _tabBarController.selectedViewController = [_tabBarController.viewControllers objectAtIndex:0];
    
    return navigationController;
}

#pragma mark - 私有方法
/**
 *  得到TabBarItem对应的各控制器
 *
 *  @return 控制器数组
 */
- (NSArray *)getTabBarViewController {
    
    ZCPMainHotTrendController *hotTrendVC = [ZCPMainHotTrendController new];
    ZCPMainCommunionController *communionVC = [ZCPMainCommunionController new];
    ZCPMainActivityController *activityVC = [ZCPMainActivityController new];
    ZCPMainLibraryController *libraryVC = [ZCPMainLibraryController new];
    ZCPMainUserController *userVC = [ZCPMainUserController new];
    
    hotTrendVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"热门动态" image:nil tag:0];
    communionVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"观点交流" image:nil tag:1];
    activityVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"文趣活动" image:nil tag:2];
    libraryVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"图书馆" image:nil tag:3];
    userVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人中心" image:nil tag:4];
    
    /*
        iOS 7 设置UIImage的渲染模式：UIImageRenderingMode
        UIImageRenderingModeAutomatic           // 根据图片的使用环境和所处的绘图上下文自动调整渲染模式。
        UIImageRenderingModeAlwaysOriginal      // 始终绘制图片原始状态，不使用Tint Color。
        UIImageRenderingModeAlwaysTemplate      // 始终根据Tint Color绘制图片，忽略图片的颜色信息
     */
    hotTrendVC.tabBarItem.image = [[UIImage imageNamed:@"HotTrendNormal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    hotTrendVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"HotTrendHighlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    communionVC.tabBarItem.image = [[UIImage imageNamed:@"CommunionNormal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    communionVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"CommunionHighlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    activityVC.tabBarItem.image = [[UIImage imageNamed:@"ActivityNormal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    activityVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"ActivityHighlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    libraryVC.tabBarItem.image = [[UIImage imageNamed:@"LibraryNormal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    libraryVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"LibraryHighlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    userVC.tabBarItem.image = [[UIImage imageNamed:@"UserNormal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    userVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"UserHighlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return @[hotTrendVC, communionVC, activityVC, libraryVC, userVC];
}



@end














