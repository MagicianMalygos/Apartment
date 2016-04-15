//
//  AppDelegate.m
//  Apartment
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 初始化api
    [[ZCPURLCommon sharedInstance] initialize];
    
    // 注册SMS，短信验证第三方（注册失败，则为测试用户，每天最多发20条）
    [SMSSDK registerApp:AppKey_SMS withSecret:AppSecrect_SMS];
    
    // 假数据,初始化用户信息，后面要改到通过登录注册
//    [ZCPUserCenter sharedInstance].currentUserModel = [ZCPUserModel modelFromDictionary:@{@"userId":@(1)
//                                                                                          , @"userAccount": @"1001"
//                                                                                          , @"userName": @"奥特曼"
//                                                                                          , @"userAge": @"18"
//                                                                                          , @"userFaceURL": @"201603302059038762.jpeg"
//                                                                                          , @"userScore": @"0"
//                                                                                          , @"userEXP": @"483"
//                                                                                          , @"userLevel": @"白衣文士"
//                                                                                          , @"focusFieldArr": @[@{@"fieldId":@(1), @"fieldName": @"散文"}
//                                                                                                                , @{@"fieldId":@(2), @"fieldName": @"军事"}
//                                                                                                                , @{@"fieldId":@(3), @"fieldName": @"传记"}]}];
    
    self.window = [[ZCPNavigator sharedInstance] window];
//    [[ZCPNavigator sharedInstance] setupRootViewController];
    [[ZCPNavigator sharedInstance] setupRootViewControllerLoginRegister];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
