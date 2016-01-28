//
//  ZCPDataModel+Category.m
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPDataModel+Category.h"

@implementation ZCPDataModel (Category)

+ (NSString *)stringValueFromDateValue:(NSDate *)date {
    return [self stringValueFromDateValue:date withFormat:@"yyyy-MM-dd"];
}
+ (NSDate *)dateValueFromStringValue:(NSString *)string {
    return [self dateValueFromStringValue:string withFormat:@"yyyy-MM-dd"];
}
+ (NSString *)stringValueFromDateValue:(NSDate *)date withFormat:(NSString *)format {
    NSDateFormatter *dfm = [[NSDateFormatter alloc] init];
    [dfm setDateFormat:format];
    return [dfm stringFromDate:date];
}
+ (NSDate *)dateValueFromStringValue:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *dfm = [[NSDateFormatter alloc] init];
    [dfm setDateFormat:format];
    return [dfm dateFromString:string];
}

@end
