//
//  ZCPBookModel.m
//  Apartment
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookModel.h"

#import "ZCPRequestResponseTranslator.h"

@implementation ZCPBookModel

#pragma mark - synthesize
@synthesize bookId              = _bookId;
@synthesize bookName            = _bookName;
@synthesize bookAuthor          = _bookAuthor;
@synthesize bookPublishTime     = _bookPublishTime;
@synthesize bookCoverURL        = _bookCoverURL;
@synthesize bookPublisher       = _bookPublisher;
@synthesize bookSummary         = _bookSummary;
@synthesize bookCommentCount    = _bookCommentCount;
@synthesize bookCollectNumber   = _bookCollectNumber;
@synthesize bookTime            = _bookTime;
@synthesize field               = _field;
@synthesize contributor         = _contributor;
@synthesize collected           = _collected;

#pragma mark - kvc
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"bookPublishTime"]
        || [key isEqualToString:@"bookTime"]) {
        value = [value toDate];
    }
    if ([key isEqualToString:@"field"]) {
        value = [ZCPRequestResponseTranslator translateResponse_FieldModel:value];
    }
    if ([key isEqualToString:@"contributor"]) {
        value = [ZCPRequestResponseTranslator translateResponse_UserModel:value];
    }
    [super setValue:value forKey:key];
}

@end
