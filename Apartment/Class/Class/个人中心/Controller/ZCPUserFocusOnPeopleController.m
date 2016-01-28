//
//  ZCPUserFocusOnPeopleController.m
//  Apartment
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPUserFocusOnPeopleController.h"

@interface ZCPUserFocusOnPeopleController()

@end

@implementation ZCPUserFocusOnPeopleController

#pragma mark - life circle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"所关注人";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

#pragma mark - constructData
- (void)constructData {
    
}

@end
