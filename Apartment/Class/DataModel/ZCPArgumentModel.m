//
//  ZCPArgumentModel.m
//  Apartment
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPArgumentModel.h"

#import "ZCPRequestResponseTranslator.h"

@implementation ZCPArgumentModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"argumentTime"]) {
        value = [ZCPDataModel dateValueFromStringValue:value];
    }
    if ([key isEqualToString:@"thesis"]) {
        value = [ZCPRequestResponseTranslator translateResponse_ThesisModel:value];
    }
    if ([key isEqualToString:@"user"]) {
        value = [ZCPRequestResponseTranslator translateResponse_UserModel:value];
    }
    if ([key isEqualToString:@"state"]) {
        value = [ZCPRequestResponseTranslator translateResponse_StateModel:value];
    }
    [super setValue:value forKey:key];
}

@end
