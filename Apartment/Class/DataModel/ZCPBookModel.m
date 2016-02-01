//
//  ZCPBookModel.m
//  Apartment
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookModel.h"

#import "ZCPRequestResponseTranslator.h"

@implementation ZCPBookModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"bookPublishTime"]
        || [key isEqualToString:@"bookTime"]) {
        value = [value toDate];
    }
    if ([key isEqualToString:@"field"]) {
        value = [ZCPRequestResponseTranslator translateResponse_FieldModel:value];
    }
    if ([key isEqualToString:@"contributor"]) {
        value = [ZCPRequestResponseTranslator translateResponse_UserModel:value];
    }
    [super setValue:value forKey:key];
}

@end
