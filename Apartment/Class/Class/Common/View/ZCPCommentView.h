//
//  ZCPCommentView.h
//  Apartment
//
//  Created by apple on 16/1/21.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UITextInput.h>

@protocol ZCPCommentViewDelegate;

@interface ZCPCommentView : UIView <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, weak) UIViewController *target;               // 目标控制器
@property (nonatomic, weak) UIView<UITextInput> *responder;         // 文本输入响应者

@property (nonatomic, strong) UIView *coverView;                    // 覆盖屏幕视图
@property (nonatomic, weak) id<ZCPCommentViewDelegate> delegate;    // delegate

// ----------------------------------------------------------------------
#pragma mark - Basic Method
// ----------------------------------------------------------------------
/**
 *  实例化方法
 *
 *  @param target    目标视图控制器
 *  @param showView  要展示在CommentView上的视图
 *  @param responder 键盘响应者
 *
 *  @return 实例化对象
 */
- (instancetype)initWithTarget:(UIViewController *)target showView:(UIView *)showView keyBoardResponder:(UIView<UITextInput>*)responder;
/**
 *  遮盖背景视图点击响应方法（隐藏键盘）
 */
- (void)tapCoverView;
/**
 *  显示评论视图
 */
- (void)showCommentView:(NSNotification *)notification;
/**
 *  隐藏评论视图
 */
- (void)hideCommentView:(NSNotification *)notification;
/**
 *  通过键盘弹出、缩回事件，改变评论视图的位置
 *
 *  @param notification 键盘弹出、缩回通知
 *  @param isShow       设置评论视图是否显示
 */
- (void)changeCommentViewByNotification:(NSNotification *)notification isShow:(BOOL)isShow;

@end



// ----------------------------------------------------------------------
#pragma mark - PROTOCOL
// ----------------------------------------------------------------------
@protocol ZCPCommentViewDelegate <NSObject>
/**
 *  键盘Retuen键点击响应方法
 *
 *  @param responder 键盘响应者
 *
 *  @return YES表示点击隐藏键盘，NO表示点击不隐藏键盘
 */
- (BOOL)textInputShouldReturn:(UIView<UITextInput> *)responder;
@end