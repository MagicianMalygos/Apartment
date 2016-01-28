//
//  ZCPUserAchievementController.m
//  Apartment
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPUserAchievementController.h"

@interface ZCPUserAchievementController ()

@end

@implementation ZCPUserAchievementController

#pragma mark - life circle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"个人成就";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

@end
