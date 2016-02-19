//
//  ZCPBookPostModel.m
//  Apartment
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookPostModel.h"

#import "ZCPRequestResponseTranslator+Library.h"

@implementation ZCPBookPostModel

#pragma mark - synthesize
@synthesize bookpostId = _bookpostId;
@synthesize bookpostTitle = _bookpostTitle;
@synthesize bookpostContent = _bookpostContent;
@synthesize bookpostPosition = _bookpostPosition;
@synthesize bookpostSupport = _bookpostSupport;
@synthesize bookpostTime = _bookpostTime;
@synthesize user = _user;
@synthesize field = _field;
@synthesize book = _book;
@synthesize bookpostReplyNumber = _bookpostReplyNumber;
@synthesize bookpostCollectNumber = _bookpostCollectNumber;
@synthesize supported = _supported;
@synthesize collected = _collected;

#pragma mark - kvc
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"bookpostTime"]) {
        value = [value toDate];
    }
    if ([key isEqualToString:@"book"]) {
        value = [ZCPRequestResponseTranslator translateResponse_BookModel:value];
    }
    if ([key isEqualToString:@"field"]) {
        value = [ZCPRequestResponseTranslator translateResponse_FieldModel:value];
    }
    if ([key isEqualToString:@"user"]) {
        value = [ZCPRequestResponseTranslator translateResponse_UserModel:value];
    }
    [super setValue:value forKey:key];
}

@end
