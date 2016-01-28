//
//  ZCPNavigator.m
//  Apartment
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPNavigator.h"

#import "ZCPViewDataModel.h"

@implementation ZCPNavigator

IMP_SINGLETON

- (void)gotoViewWithIdentifier:(NSString *)identifier paramDictForInit:(NSDictionary *)paramDictForInit {
    // 通过identifier获取viewDataModel
    ZCPViewDataModel *viewDataModel = [self viewDataModelForIdentifier:identifier];
    viewDataModel.paramDictForInit = [NSMutableDictionary dictionaryWithDictionary:paramDictForInit];
    // 通过viewDataModel参数进行跳转
    [self pushViewControllerWithViewDataModel:viewDataModel animated:YES];
}

@end
