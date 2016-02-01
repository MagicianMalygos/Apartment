//
//  ZCPQuestionModel.m
//  Apartment
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPQuestionModel.h"

#import "ZCPRequestResponseTranslator.h"

@implementation ZCPQuestionModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"questionTime"]) {
        value = [value toDate];
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
