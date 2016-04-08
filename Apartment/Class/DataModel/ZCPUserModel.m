//
//  ZCPUserModel.m
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPUserModel.h"
#import "ZCPFieldModel.h"

@implementation ZCPUserModel

#pragma mark - synthesize
@synthesize userId              = _userId;
@synthesize userAccount         = _userAccount;
@synthesize userPassword        = _userPassword;
@synthesize userName            = _userName;
@synthesize userAge             = _userAge;
@synthesize userFaceURL         = _userFaceURL;
@synthesize userScore           = _userScore;
@synthesize userEXP             = _userEXP;
@synthesize userRegisterTime    = _userRegisterTime;
@synthesize userLevel           = _userLevel;
@synthesize focusFieldArr       = _focusFieldArr;

#pragma mark - kvc
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"userRegisterTime"]) {
        value = [value toDate];
    }
    if ([key isEqualToString:@"focusFieldArr"]) {
        NSMutableArray *fieldArray = [NSMutableArray array];
        for (NSDictionary *fieldDict in value) {
            [fieldArray addObject:[ZCPFieldModel modelFromDictionary:fieldDict]];
        }
        value = fieldArray;
    }
    if ([key isEqualToString:@"userFaceURL"]) {
        value = headImageGetURL(value);
    }
    [super setValue:value forKey:key];
}

@end
