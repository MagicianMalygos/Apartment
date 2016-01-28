//
//  ZCPUserCenter.m
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPUserCenter.h"

@implementation ZCPUserCenter

@synthesize currentUserModel = _currentUserModel;
@synthesize login = _login;

IMP_SINGLETON

- (instancetype)init {
    if (self = [super init]) {
        self.login = NO;
    }
    return self;
}

- (void)saveUserModel:(ZCPUserModel *)userModel {
    if (userModel == nil) {
        self.currentUserModel = [ZCPUserModel new];
    }
    // 归档
    // 设置
    self.currentUserModel = userModel;
}
- (void)clearUserModel {
    [[ZCPUserCenter sharedInstance] saveUserModel:nil];
    self.login = NO;
}
- (void)logout {
    [[ZCPUserCenter sharedInstance] clearUserModel];
}

@end
