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

#pragma mark - synthesize
@synthesize securityQuestionId      = _securityQuestionId;
@synthesize securityQuestionOne     = _securityQuestionOne;
@synthesize securityQuestionTwo     = _securityQuestionTwo;
@synthesize securityQuestionThree   = _securityQuestionThree;
@synthesize securityAnswerOne       = _securityAnswerOne;
@synthesize securityAnswerTwo       = _securityAnswerTwo;
@synthesize securityAnswerThree     = _securityAnswerThree;
@synthesize secutityTime            = _secutityTime;
@synthesize user                    = _user;

#pragma mark - kvc
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
