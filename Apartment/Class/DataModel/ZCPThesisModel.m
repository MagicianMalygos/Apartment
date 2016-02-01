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
