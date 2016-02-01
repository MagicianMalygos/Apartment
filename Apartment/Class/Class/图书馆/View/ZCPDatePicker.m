//
//  ZCPDatePicker.m
//  Apartment
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPDatePicker.h"

@implementation ZCPDatePicker

/**
 *  当视图移动完成后调用
 */
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if (self.superview == nil) {
        return;
    }
    if (self.date == nil
        || [[self.date toString] isEqualToString:[[NSDate date] toString]]) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

@end
