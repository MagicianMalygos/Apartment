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

#pragma mark - synthesize

@synthesize questionId = _questionId;
@synthesize questionContent = _questionContent;
@synthesize questionOptionOne = _questionOptionOne;
@synthesize questionOptionTwo = _questionOptionTwo;
@synthesize questionOptionThree = _questionOptionThree;
@synthesize questionAnswer = _questionAnswer;
@synthesize questionCollectNumber = _questionCollectNumber;
@synthesize questionTime = _questionTime;
@synthesize user = _user;
@synthesize state = _state;
@synthesize collected = _collected;
@synthesize optionSequence = _optionSequence;

#pragma mark - kvc
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
