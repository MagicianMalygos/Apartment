//
//  ZCPMainHotTrendController.m
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPMainHotTrendController.h"

#import "ZCPTextView.h"
#import "ZCPCommentView.h"

@interface ZCPMainHotTrendController () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) ZCPTextView *textView;
@property (nonatomic, strong) ZCPCommentView *commentView;

@end

@implementation ZCPMainHotTrendController

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];    
    
    self.textView = [[ZCPTextView alloc] init];
    self.textView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, 100);
    self.textView.placeholder = @"请输入...";
    [self.textView setFont:[UIFont systemFontOfSize:50.0f]];
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 100, 100, 50);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.commentView = [[ZCPCommentView alloc] initWithTarget:self];
    [self.view addSubview:self.commentView];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self clearNavigationBar];
    self.title = @"热门动态";
}

- (void)btnClick:(UIButton *)sender {
    [self.commentView showCommentView];
}

@end























