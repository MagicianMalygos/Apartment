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

@synthesize appTheme = _appTheme;

IMP_SINGLETON

#pragma mark - getter / setter
- (UITabBarController *)tabBarController {
    if (_tabBarController == nil) {
        _tabBarController = [[ZCPTabBarController alloc] init];
    }
    return _tabBarController;
}
- (APPTheme)appTheme {
    return _appTheme;
}
- (void)setAppTheme:(APPTheme)appTheme {
    _appTheme = appTheme;
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
    UIColor *color = [UIColor grayColor];
    [[UINavigationBar appearance] setTintColor:color];
    navigationBar.tintColor = color;                    // 左右按钮文字颜色
    navigationBar.barTintColor = [UIColor greenColor];  // navigationBar背景颜色
    navigationBar.translucent = NO;                     // 取消半透明效果，解决界面跳转的时候能看到导航栏的颜色发生变化
    NSDictionary *navTitleDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont defaultFontWithSize:18.0f], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [navigationBar setTitleTextAttributes:navTitleDict];
    
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
    
    return @[hotTrendVC, communionVC, activityVC, libraryVC, userVC];
}



@end














