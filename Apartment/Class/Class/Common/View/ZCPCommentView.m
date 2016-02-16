//
//  CommentView.m
//  Apartment
//
//  Created by apple on 16/1/21.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPCommentView.h"

@implementation ZCPCommentView
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
- (instancetype)initWithTarget:(UIViewController *)target showView:(UIView *)showView keyBoardResponder:(UIView<UITextInput>*)responder {
    if (self = [super init]) {
        CGRect bounds = [[UIScreen mainScreen] bounds];
        [self setFrame:CGRectMake(0, bounds.size.height, bounds.size.width, 44)];
        [self setBackgroundColor:[UIColor colorWithRed:220.0/255 green:220.0/255 blue:220.0/255 alpha:1.0f]];
        self.hidden = YES;
        
        if (showView != nil) {
            [self addSubview:showView];
        }
        
        // 创建可以覆盖整个视图的coverView，为其添加点击手势与响应事件
        self.coverView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [self.coverView setAlpha:0.01009f];
        [self.coverView setBackgroundColor:[UIColor whiteColor]];
        [self.coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCoverView)]];
        
        self.responder = responder;
        if ([responder isKindOfClass:[UITextField class]]) {
            ((UITextField *)self.responder).delegate = self;
        }
        else if ([responder isKindOfClass:[UITextView class]]) {
            ((UITextView *)self.responder).delegate = self;
        }
        
        self.target = target;
        // 监听键盘事件
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showCommentView:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideCommentView:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}
/**
 *  遮盖背景视图点击响应方法（隐藏键盘）
 */
- (void)tapCoverView {
    [self.responder resignFirstResponder];  // 缩回键盘
}
/**
 *  显示评论视图
 */
- (void)showCommentView:(NSNotification *)notification {
    [self.target.view addSubview:self.coverView];
    
    // 将‘响应键盘输入视图’和‘评论视图’置顶
    UIView *responderView = self.responder;
    while (![[responderView superview] isEqual:self.target.view]) {
        responderView = [responderView superview];
    }
    [self.target.view bringSubviewToFront:responderView];
    [self.target.view bringSubviewToFront:self];
    [self changeCommentViewByNotification:notification isShow:YES];
}
/**
 *  隐藏评论视图
 */
- (void)hideCommentView:(NSNotification *)notification {
    [self changeCommentViewByNotification:notification isShow:NO];
    [self.coverView removeFromSuperview];
}
/**
 *  通过键盘弹出、缩回事件，改变评论视图的位置
 *
 *  @param notification 键盘弹出、缩回通知
 *  @param isShow       设置评论视图是否显示
 */
- (void)changeCommentViewByNotification:(NSNotification *)notification isShow:(BOOL)isShow {
    NSDictionary *userInfo = [notification userInfo];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey]; // 添加移动动画，使视图跟随键盘移动
    
    // 得到键盘弹出或缩回后的键盘视图所在的y坐标
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndY = value.CGRectValue.origin.y; // 得到键盘弹出后的键盘视图所在的y坐标
    CGFloat Y = (isShow)?(keyBoardEndY - self.bounds.size.height/2.0):(keyBoardEndY + self.bounds.size.height/2.0);
    // 判断是否隐藏CommentView
    self.hidden = !isShow;
    // 如果target是UITableView或其子类，需要再加上64
//    if ([self.target isKindOfClass:[UITableViewController class]]) {
//        Y -= 64;
//    }
    Y -= 64;
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        self.center = CGPointMake(self.center.x, Y);
    }];
}
/**
 *  销毁观察者
 */
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

// ----------------------------------------------------------------------
#pragma mark - UITextFiledDelegate & UITextFiledDelegate
// ----------------------------------------------------------------------
/**
 *  响应键盘Retuen按键
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL keyBoardIsHidden = [self.delegate textInputShouldReturn:self.responder];
    textField.text = @"";
    if (keyBoardIsHidden) {
        // 缩回commentView和键盘
        [self tapCoverView];
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    BOOL keyBoardIsHidden = [self.delegate textInputShouldReturn:self.responder];
    textView.text = @"";
    if (keyBoardIsHidden) {
        // 缩回commentView和键盘
        [self tapCoverView];
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
