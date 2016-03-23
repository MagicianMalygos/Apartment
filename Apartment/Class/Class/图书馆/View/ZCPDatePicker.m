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
    
    self.bindingTextField.text = [self.date toString];
    
    [self addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)valueChanged {
    self.bindingTextField.text = [self.date toString];
}

@end
