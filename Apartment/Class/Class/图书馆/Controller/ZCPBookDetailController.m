//
//  ZCPBookDetailController.m
//  Apartment
//
//  Created by apple on 16/1/28.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookDetailController.h"

#import "ZCPBookModel.h"

@interface ZCPBookDetailController ()

@property (nonatomic, strong) ZCPBookModel *currentBookModel;       // 当前的图书模型

@end

@implementation ZCPBookDetailController

@synthesize currentBookModel = _currentBookModel;

#pragma mark - init
- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        self.currentBookModel = [params objectForKey:@"_currentBookModel"];
    }
    return self;
}


@end
