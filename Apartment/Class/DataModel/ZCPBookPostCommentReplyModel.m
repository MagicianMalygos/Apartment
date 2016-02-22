//
//  ZCPBookPostCommentReplyModel.m
//  Apartment
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookPostCommentReplyModel.h"

#import "ZCPRequestResponseTranslator+Communion.h"

@implementation ZCPBookPostCommentReplyModel

#pragma mark - synthesize
@synthesize replyId = _replyId;
@synthesize replyContent = _replyContent;
@synthesize replySupport = _replySupport;
@synthesize replyTime = _replyTime;
@synthesize user = _user;
@synthesize receiver = _receiver;
@synthesize comment = _comment;
@synthesize supported = _supported;
@synthesize collected = _collected;

#pragma mark - kvc
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"replyTime"]) {
        value = [value toDate];
    }
    if ([key isEqualToString:@"user"]
        || [key isEqualToString:@"receiver"]) {
        value = [ZCPRequestResponseTranslator translateResponse_UserModel:value];
    }
    if ([key isEqualToString:@"comment"]) {
        value = [ZCPRequestResponseTranslator translateResponse_BookPostCommentModel:value];
    }
    [super setValue:value forKey:key];
}

@end
