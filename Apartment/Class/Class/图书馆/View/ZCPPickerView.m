//
//  ZCPPickerView.m
//  Apartment
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPPickerView.h"

@interface ZCPPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation ZCPPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 添加PickerView
        self.pickerView = [[UIPickerView alloc] initWithFrame:frame];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        [self addSubview:self.pickerView];
    }
    return self;
}

#pragma mark - UIPickerView Delegate & DataSource
/**
 *  滚动视图的数目
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.optionsArr.count;
}
/**
 *  滚动视图中选项的数目
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[self.optionsArr objectAtIndex:component] count];
}

/**
 *  选项名
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[self.optionsArr objectAtIndex:component] objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"%@", [[self.optionsArr objectAtIndex:component] objectAtIndex:row]);
}

@end
