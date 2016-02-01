//
//  ZCPSecurityQuestionModel.m
//  Apartment
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPSecurityQuestionModel.h"

#import "ZCPRequestResponseTranslator.h"
@implementation ZCPSecurityQuestionModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"securityTime"]) {
        value = [value toDate];
    }
    if ([key isEqualToString:@"user"]) {
        value = [ZCPRequestResponseTranslator translateResponse_UserModel:value];
    }
    [super setValue:value forKey:key];
}

@end
