//
//  ZCPDatePicker.m
//  Apartment
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPDatePicker.h"

@implementation ZCPDatePicker

#pragma mark - synthesize
@synthesize bindingTextField    = _bindingTextField;

#pragma mark - life cycle
/**
 *  当视图移动完成后调用
 */
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    self.bindingTextField.text = [self.date toString];
    
    [self addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - action
- (void)valueChanged {
    self.bindingTextField.text = [self.date toString];
}

@end
