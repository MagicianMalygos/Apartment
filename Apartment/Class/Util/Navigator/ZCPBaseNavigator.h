//
//  ZCPBaseNavigator.h
//  Apartment
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZCPViewDataModel;
@protocol ZCPNavigatorProtocol;

@interface ZCPBaseNavigator : NSObject

#pragma mark - 属性
// 系统window，承载导航堆栈
@property (nonatomic, readonly) UIWindow *window;
// window的根视图控制器
@property (nonatomic, readonly) UIViewController *rootViewController;
// window上导航堆栈的顶部ViewController
@property (nonatomic, readonly) UIViewController *topViewController;

#pragma mark - 初始化rootViewController
- (void)setupRootViewControllerLoginRegister;
- (void)setupRootViewController;

#pragma mark - 公有方法
// 通过identifier获取视图模型
- (ZCPViewDataModel *)viewDataModelForIdentifier:(NSString *)identifier;
// 根据ViewDataModel获得视图控制器对象，并进行跳转
- (UIViewController *)pushViewControllerWithViewDataModel:(ZCPViewDataModel *)viewDataModel animated:(BOOL)animated;

@end

#pragma mark - 控制器初始化协议
// 使用导航栏导航的控制器均需要实现此协议
@protocol ZCPNavigatorProtocol <NSObject>

@required
- (instancetype)initWithParams:(NSDictionary *)params;
@optional
- (void)doInitializeWithParams:(NSDictionary *)params;

@end
