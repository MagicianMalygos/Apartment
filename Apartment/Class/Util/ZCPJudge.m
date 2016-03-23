//
//  ZCPJudge.m
//  Apartment
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPJudge.h"

@implementation ZCPLengthRange

+ (instancetype)rangeWithMin:(NSUInteger)minValue max:(NSUInteger)maxValue {
    return [[self alloc] initWithMin:minValue max:maxValue];
}
- (instancetype)initWithMin:(NSUInteger)minValue max:(NSUInteger)maxValue {
    if (self = [super init]) {
        self.minValue = minValue;
        self.maxValue = maxValue;
    }
    return self;
}

@end

@implementation ZCPJudge

// 判断是否为空
+ (BOOL)judgeNullObject:(NSObject *)object {
    return [self judgeNullObject:object showErrorMsg:nil toView:nil];
}
+ (BOOL)judgeNullObject:(NSObject *)object showErrorMsg:(NSString *)errorMsg toView:(UIView *)view {
    if (object == nil) {
        [self showErrorMsg:errorMsg toView:view];
        return YES;
    }
    return NO;
}

// 判断文本是否为空
+ (BOOL)judgeNullTextInput:(NSString *)textInput showErrorMsg:(NSString *)errorMsg toView:(UIView *)view {
    if (textInput == nil || textInput.length == 0) {
        [self showErrorMsg:errorMsg toView:view];
        return YES;
    }
    return NO;
}
+ (BOOL)judgeNullTextInput:(NSString *)textInput {
    return [self judgeNullTextInput:textInput showErrorMsg:nil toView:nil];
}

// 判断文本长度是否超出指定范围
+ (BOOL)judgeOutOfRangeTextInput:(NSString *)text range:(ZCPLengthRange *)range showErrorMsg:(NSString *)errorMsg toView:(UIView *)view {
    if (!text || ![self length:text.length inLengthRange:range]) {
        [self showErrorMsg:errorMsg toView:view];
        return YES;
    }
    return NO;
}
+ (BOOL)judgeOutOfRangeTextInput:(NSString *)text range:(ZCPLengthRange *)range {
    return [self judgeOutOfRangeTextInput:text range:range showErrorMsg:nil toView:nil];
}
// 判断日期是否有误
+ (BOOL)judgeWrongDateString:(NSString *)dateString showErrorMsg:(NSString *)errorMsg toView:(UIView *)view {
    if (![NSDate dateFromString:dateString] && ![NSDate dateFromYDMHmsString:dateString]) {
        [self showErrorMsg:errorMsg toView:view];
        return YES;
    }
    return NO;
}
+ (BOOL)judgeWrongDateString:(NSString *)dateString {
    return [self judgeWrongDateString:dateString showErrorMsg:nil toView:nil];
}

#pragma mark - Other
// 判断长度是否在范围内
+ (BOOL)length:(NSUInteger)length inLengthRange:(ZCPLengthRange *)range {
    if (length >= range.minValue && length <= range.maxValue) {
        return YES;
    }
    return NO;
}
// 在view上显示错误信息
+ (void)showErrorMsg:(NSString *)errorMsg toView:(UIView *)view {
    if (errorMsg && view) {
        [MBProgressHUD showError:errorMsg toView:view];
    }
}

@end