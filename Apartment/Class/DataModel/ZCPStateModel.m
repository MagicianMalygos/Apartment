//
//  ZCPStateModel.m
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPStateModel.h"

@implementation ZCPStateModel

#pragma mark - synthesize
@synthesize stateId     = _stateId;
@synthesize stateName   = _stateName;
@synthesize stateValue  = _stateValue;
@synthesize stateType   = _stateType;
@synthesize stateTime   = _stateTime;

#pragma mark - kvc
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"stateTime"]) {
        value = [value toDate];
    }
    [super setValue:value forKey:key];
}

@end
