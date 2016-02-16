//
//  ZCPMainHotTrendController.m
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPMainHotTrendController.h"

#import "ZCPTextView.h"

@interface ZCPMainHotTrendController () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) ZCPTextView *textView;

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
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self clearNavigationBar];
    self.title = @"热门动态";
}

@end























