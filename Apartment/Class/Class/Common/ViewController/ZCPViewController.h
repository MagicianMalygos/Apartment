//
//  ZCPViewController.h
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

// 视图控制器基类
@interface ZCPViewController : UIViewController <ZCPNavigatorProtocol>

// tap事件
@property (nonatomic, strong) UITapGestureRecognizer *tap;
// 是否需要在键盘显示之后，点击页面让键盘消失
@property (nonatomic, strong) NSNumber *needsTapToDismissKeyboard;

#pragma mark - 键盘事件
// 注册键盘通知事件监听
- (void)registerKeyboardNotification;
// 移除键盘事件监听
- (void)breakdown;
- (void)dismissKeyboard;

- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardDidShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;
- (void)keyboardDidHide:(NSNotification *)notification;
// version >= 5.0
- (void)keyboardWillChangeFrame:(NSNotification *)notification;
- (void)keyboardDidChangeFrame:(NSNotification *)notification;

// IQKeyboardManager
- (void)registerKeyboardIQ;
- (void)unregisterKeyboardIQ;

#pragma mark - NavigationBar
// 重写此方法，返回YES为隐藏
- (BOOL)isHideLeftBarButton;
// 统一初始化，清除导航栏方法
- (void)initNavigationBar;

@end
