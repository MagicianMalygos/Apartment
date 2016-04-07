//
//  ZCPJudge.h
//  Apartment
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

#define PASS_JUDGE  NSIntegerMax
// ZCPRange范围
#define ZCPLengthRangeMin   0
#define ZCPLengthRangeMax   NSUIntegerMax

/**
 *  自定义范围
 *  大于小于方向由 ZCPLengthRangeMin, ZCPLengthRangeMax决定
 *  ZCPRange(5, 15)                 :   x >= 5 && x <= 15
 *  ZCPRange(ZCPLengthRangeMin, 5)  :   x <= 5
 *  ZCPRange(5, ZCPLengthRangeMax)  :   x >= 5
 */
@interface ZCPLengthRange : NSObject

@property (nonatomic, assign) NSUInteger minValue;
@property (nonatomic, assign) NSUInteger maxValue;

+ (instancetype)rangeWithMin:(NSUInteger)minValue max:(NSUInteger)maxValue;
- (BOOL)numberInRange:(NSInteger)number;

@end

@interface ZCPJudge : NSObject

// 判断对象是否为空
+ (BOOL)judgeNullObject:(NSObject *)object;
+ (BOOL)judgeNullObject:(NSObject *)object showErrorMsg:(NSString *)errorMsg;
+ (BOOL)judgeNullObject:(NSObject *)object showErrorMsg:(NSString *)errorMsg toView:(UIView *)view;
// 判断文本是否为空
+ (BOOL)judgeNullTextInput:(NSString *)textInput;
+ (BOOL)judgeNullTextInput:(NSString *)textInput showErrorMsg:(NSString *)errorMsg;
+ (BOOL)judgeNullTextInput:(NSString *)textInput showErrorMsg:(NSString *)errorMsg toView:(UIView *)view;
// 判断文本长度是否超出指定范围
+ (BOOL)judgeOutOfRangeTextInput:(NSString *)text range:(ZCPLengthRange *)range;
+ (BOOL)judgeOutOfRangeTextInput:(NSString *)text range:(ZCPLengthRange *)range showErrorMsg:(NSString *)errorMsg;
+ (BOOL)judgeOutOfRangeTextInput:(NSString *)text range:(ZCPLengthRange *)range showErrorMsg:(NSString *)errorMsg toView:(UIView *)view;

// 判断日期是否有误
+ (BOOL)judgeWrongDateString:(NSString *)dateString;
+ (BOOL)judgeWrongDateString:(NSString *)dateString showErrorMsg:(NSString *)errorMsg;
+ (BOOL)judgeWrongDateString:(NSString *)dateString showErrorMsg:(NSString *)errorMsg toView:(UIView *)view;

@end
