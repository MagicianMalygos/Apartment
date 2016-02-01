//
//  ZCPBookPostCommentModel.m
//  Apartment
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookPostCommentModel.h"

#import "ZCPRequestResponseTranslator.h"

@implementation ZCPBookPostCommentModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"commentTime"]) {
        value = [value toDate];
    }
    if ([key isEqualToString:@"bookpost"]) {
        value = [ZCPRequestResponseTranslator translateResponse_BookPostModel:value];
    }
    if ([key isEqualToString:@"user"]) {
        value = [ZCPRequestResponseTranslator translateResponse_UserModel:value];
    }
    [super setValue:value forKey:key];
}

@end
