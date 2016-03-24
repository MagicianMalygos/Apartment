//
//  ZCPDatePicker.h
//  Apartment
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCPDatePicker : UIDatePicker

@property (nonatomic, weak) UITextField *bindingTextField;  // 绑定的TextField

@end

/**
 *  获取时间选择器
 */
ZCPDatePicker *getDatePicker();