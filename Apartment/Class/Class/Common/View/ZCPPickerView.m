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

#pragma mark - synthesize
@synthesize pickerView          = _pickerView;
@synthesize optionsArr          = _optionsArr;
@synthesize selectedValues      = _selectedValues;
@synthesize bindingTextField    = _bindingTextField;

#pragma mark - init
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
#pragma mark - getter / setter
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    self.selectedValues = [NSMutableArray array];  // 重置数组
    for (int i = 0; i < self.optionsArr.count; i++) {
        NSInteger row = [self.pickerView selectedRowInComponent:i];
        [self.selectedValues addObject:self.optionsArr[i][row]];
    }
    
    // 设置绑定的textField的内容
    for (int i = 0; i < self.selectedValues.count; i++) {
        if (i == self.selectedValues.count - 1) {
            self.bindingTextField.text = self.selectedValues[i];
        } else {
            self.bindingTextField.text = [self.selectedValues[i] stringByAppendingString:@" "];
        }
    }
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

/**
 *  picker值发生改变
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.selectedValues replaceObjectAtIndex:component withObject:[[self.optionsArr objectAtIndex:component] objectAtIndex:row]];
    
    // 设置绑定的textField的内容
    for (int i = 0; i < self.selectedValues.count; i++) {
        if (i == self.selectedValues.count - 1) {
            self.bindingTextField.text = self.selectedValues[i];
        } else {
            self.bindingTextField.text = [self.selectedValues[i] stringByAppendingString:@" "];
        }
    }
}

@end

/**
 *  获取自定义选择器
 */
ZCPPickerView *getPicker(NSArray *optionsArr) {
    ZCPPickerView *pickerView = [[ZCPPickerView alloc] initWithFrame:CGRectMake(0, 0, APPLICATIONWIDTH, 200)];
    pickerView.optionsArr = optionsArr? @[[optionsArr mutableCopy]]: @[[NSArray array]];
    return pickerView;
}