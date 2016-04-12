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

@interface ZCPMainHotTrendController ()

@end

@implementation ZCPMainHotTrendController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self clearNavigationBar];
    self.title = @"热门动态";
}

- (void)constructData {
    
}

@end























