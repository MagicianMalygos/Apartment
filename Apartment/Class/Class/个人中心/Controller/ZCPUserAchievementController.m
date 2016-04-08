//
//  ZCPUserAchievementController.m
//  Apartment
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPUserAchievementController.h"

@interface ZCPUserAchievementController ()

@property (nonatomic, assign) NSInteger currUserID;                 // 用户ID
@property (nonatomic, assign) NSUInteger pagination;                // 页码

@end

@implementation ZCPUserAchievementController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"个人成就";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

@end
