//
//  UIButton+Style.m
//  haofang
//
//  Created by leo on 15/4/20.
//  Copyright (c) 2015年 平安好房. All rights reserved.
//

#import "UIButton+Style.h"

@implementation UIButton (Style)

- (void)configureDefault
{
    [self.layer setCornerRadius:5.0];
    [self setBackgroundColor:[UIColor PABtnBgOrangeColor]];
}

- (void)configureBorderStyleWithColor:(UIColor *)color
{
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderColor = color.CGColor;
    [self setTitleColor:color forState:UIControlStateNormal];
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = 3.0;
}

@end
