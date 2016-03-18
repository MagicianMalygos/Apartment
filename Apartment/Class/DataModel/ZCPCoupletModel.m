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

#pragma mark - synthesize
@synthesize coupletId               = _coupletId;
@synthesize coupletContent          = _coupletContent;
@synthesize coupletReplyNumber      = _coupletReplyNumber;
@synthesize coupletCollectNumber    = _coupletCollectNumber;
@synthesize coupletSupport          = _coupletSupport;
@synthesize coupletTime             = _coupletTime;
@synthesize user                    = _user;
@synthesize supported               = _supported;
@synthesize collected               = _collected;

#pragma mark - kvc
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"coupletTime"]) {
        value = [value toDate];
    }
    if ([key isEqualToString:@"user"]) {
        value = [ZCPRequestResponseTranslator translateResponse_UserModel:value];
    }
    [super setValue:value forKey:key];
}

@end
