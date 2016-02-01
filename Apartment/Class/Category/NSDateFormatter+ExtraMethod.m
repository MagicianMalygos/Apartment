//
//  NSDateFormatter+ExtraMethod.m
//  haofang
//
//  Created by leo on 14-9-5.
//  Copyright (c) 2014年 平安好房. All rights reserved.
//

#import "NSDateFormatter+ExtraMethod.h"

static NSDateFormatter *staticDateFormatter;

@implementation NSDateFormatter (ExtraMethod)

+ (NSDateFormatter *)staticDateFormatter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        START_COUNT_TIME(start);
        staticDateFormatter = [[NSDateFormatter alloc] init];
        TTDPRINT(@"init date formatter use %f seconds", (float)END_COUNT_TIME(start)/CLOCKS_PER_SEC);
    });
    return staticDateFormatter;
}

@end
