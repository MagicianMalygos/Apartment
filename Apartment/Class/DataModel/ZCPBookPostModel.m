//
//  ZCPBookPostModel.m
//  Apartment
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookPostModel.h"

#import "ZCPRequestResponseTranslator.h"

@implementation ZCPBookPostModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"bookpostTime"]) {
        value = [value toDate];
    }
    if ([key isEqualToString:@"book"]) {
        value = [ZCPRequestResponseTranslator translateResponse_BookModel:value];
    }
    if ([key isEqualToString:@"field"]) {
        value = [ZCPRequestResponseTranslator translateResponse_FieldModel:value];
    }
    if ([key isEqualToString:@"user"]) {
        value = [ZCPRequestResponseTranslator translateResponse_UserModel:value];
    }
    [super setValue:value forKey:key];
}

@end