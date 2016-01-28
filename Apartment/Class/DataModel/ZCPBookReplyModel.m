//
//  ZCPBookReplyModel.m
//  Apartment
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookReplyModel.h"

#import "ZCPRequestResponseTranslator.h"

@implementation ZCPBookReplyModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"bookreplyTime"]) {
        value = [ZCPDataModel dateValueFromStringValue:value];
    }
    if ([key isEqualToString:@"user"]) {
        value = [ZCPRequestResponseTranslator translateResponse_UserModel:value];
    }
    if ([key isEqualToString:@"book"]) {
        value = [ZCPRequestResponseTranslator translateResponse_BookModel:value];
    }
    [super setValue:value forKey:key];
}

@end
