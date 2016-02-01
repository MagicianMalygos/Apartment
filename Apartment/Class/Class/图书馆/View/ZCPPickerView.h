//
//  ZCPPickerView.h
//  Apartment
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCPPickerView : UIView

@property (nonatomic, strong) UIPickerView *pickerView;         // pickerView
@property (nonatomic, strong) NSArray *optionsArr;              // picker选项
@property (nonatomic, strong) NSArray *selectedValuesArr;       // picker选中的值

@end
