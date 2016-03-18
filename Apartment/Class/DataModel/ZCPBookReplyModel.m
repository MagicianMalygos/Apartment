//
//  ZCPBookReplyModel.m
//  Apartment
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookReplyModel.h"

#import "ZCPRequestResponseTranslator+Library.h"

@implementation ZCPBookReplyModel

#pragma mark - synthesize
@synthesize bookreplyId         = _bookreplyId;
@synthesize bookreplyContent    = _bookreplyContent;
@synthesize bookreplySupport    = _bookreplySupport;
@synthesize bookreplyTime       = _bookreplyTime;
@synthesize user                = _user;
@synthesize book                = _book;
@synthesize supported           = _supported;

#pragma mark - kvc
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"bookreplyTime"]) {
        value = [value toDate];
    }
    if ([key isEqualToString:@"user"]) {
        value = [ZCPRequestResponseTranslator translateResponse_UserModel:value];
    }
    if ([key isEqualToString:@"book"]) {
        value = [ZCPRequestResponseTranslator translateResponse_BookModel:value];
    }
    [super setValue:value forKey:key];
}

@end
