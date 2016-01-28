//
//  ZCPBookPostCommentReplyModel.m
//  Apartment
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookPostCommentReplyModel.h"

#import "ZCPRequestResponseTranslator.h"

@implementation ZCPBookPostCommentReplyModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"replyTime"]) {
        value = [ZCPDataModel dateValueFromStringValue:value];
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
