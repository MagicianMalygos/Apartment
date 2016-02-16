//
//  ZCPTextView.h
//  Apartment
//
//  Created by apple on 16/2/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

// 扩展UITextView，使其具有placeholder功能
@interface ZCPTextView : UITextView

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;

@end
