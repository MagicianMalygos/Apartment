//
//  ZCPUserCollectionController.m
//  Apartment
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPUserCollectionController.h"

@interface ZCPUserCollectionController ()

@end

@implementation ZCPUserCollectionController

#pragma mark - life circle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"我的收藏";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

@end
