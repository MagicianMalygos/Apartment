//
//  ZCPCoupletReplyModel.m
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPCoupletReplyModel.h"

#import "ZCPRequestResponseTranslator.h"

@implementation ZCPCoupletReplyModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"replyTime"]) {
        value = [ZCPDataModel dateValueFromStringValue:value];
    }
    if ([key isEqualToString:@"user"]) {
        value = [ZCPRequestResponseTranslator translateResponse_UserModel:value];
    }
    if ([key isEqualToString:@"couplet"]) {
        value = [ZCPRequestResponseTranslator translateResponse_CoupletModel:value];
    }
    [super setValue:value forKey:key];
}

@end
