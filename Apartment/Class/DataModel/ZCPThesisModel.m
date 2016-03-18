//
//  ZCPThesisModel.m
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPThesisModel.h"

#import "ZCPRequestResponseTranslator.h"

@implementation ZCPThesisModel

#pragma mark - synthesize
@synthesize thesisId                = _thesisId;
@synthesize thesisContent           = _thesisContent;
@synthesize thesisPros              = _thesisPros;
@synthesize thesisProsCount         = _thesisProsCount;
@synthesize thesisProsReplyNumber   = _thesisProsReplyNumber;
@synthesize thesisCons              = _thesisCons;
@synthesize thesisConsCount         = _thesisConsCount;
@synthesize thesisConsReplyNumber   = _thesisConsReplyNumber;
@synthesize thesisCollectNumber     = _thesisCollectNumber;
@synthesize thesisStartTime         = _thesisStartTime;;
@synthesize thesisEndTime           = _thesisEndTime;
@synthesize thesisTime              = _thesisTime;
@synthesize state                   = _state;
@synthesize collected               = _collected;

#pragma mark - kvc
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"thesisStartTime"]
        || [key isEqualToString:@"thesisEndTime"]
        || [key isEqualToString:@"thesisTime"]) {
        value = [value toDate];
    }
    if ([key isEqualToString:@"state"]) {
        value = [ZCPRequestResponseTranslator translateResponse_StateModel:value];
    }
    [super setValue:value forKey:key];
}

@end
