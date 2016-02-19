//
//  ZCPArgumentModel.m
//  Apartment
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPArgumentModel.h"

#import "ZCPRequestResponseTranslator+Thesis.h"

@implementation ZCPArgumentModel

#pragma mark - synthesize
@synthesize argumentId = _argumentId;
@synthesize argumentContent = _argumentContent;
@synthesize argumentSupport = _argumentSupport;
@synthesize argumentBelong = _argumentBelong;
@synthesize argumentTime = _argumentTime;
@synthesize thesis = _thesis;
@synthesize user = _user;
@synthesize state = _state;
@synthesize supported = _supported;

#pragma mark - kvc
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"argumentTime"]) {
        value = [value toDate];
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
