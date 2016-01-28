//
//  ZCPDataModel+Category.h
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPDataModel.h"

@interface ZCPDataModel (Category)

// ZCPDataModel中属性值的转换
+ (NSString *)stringValueFromDateValue:(NSDate *)date;
+ (NSDate *)dateValueFromStringValue:(NSString *)string;
+ (NSString *)stringValueFromDateValue:(NSDate *)date withFormat:(NSString *)format;
+ (NSDate *)dateValueFromStringValue:(NSString *)string withFormat:(NSString *)format;

@end
