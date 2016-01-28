//
//  ZCPStateModel.m
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPStateModel.h"

@implementation ZCPStateModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"stateTime"]) {
        value = [ZCPDataModel dateValueFromStringValue:value];
    }
    [super setValue:value forKey:key];
}

@end
