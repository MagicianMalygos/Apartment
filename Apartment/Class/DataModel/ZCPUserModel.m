//
//  ZCPUserModel.m
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPUserModel.h"

@implementation ZCPUserModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"userRegisterTime"]) {
        value = [ZCPUserModel dateValueFromStringValue:value];
    }
    if ([key isEqualToString:@"foucusFieldsArr"]) {
        value = [value mutableCopy];
    }
    [super setValue:value forKey:key];
}

@end
