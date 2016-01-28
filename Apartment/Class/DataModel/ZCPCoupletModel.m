//
//  ZCPCoupletModel.m
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPCoupletModel.h"

#import "ZCPRequestResponseTranslator.h"

@implementation ZCPCoupletModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"coupletTime"]) {
        value = [ZCPDataModel dateValueFromStringValue:value];
    }
    if ([key isEqualToString:@"user"]) {
        value = [ZCPRequestResponseTranslator translateResponse_UserModel:value];
    }
    [super setValue:value forKey:key];
}

@end
