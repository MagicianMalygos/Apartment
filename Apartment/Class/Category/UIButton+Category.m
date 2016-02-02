//
//  UIButton+Category.m
//  Apartment
//
//  Created by apple on 16/2/2.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)

/**
 *  设置button的全状态image
 */
- (void)setImageNameNormal:(NSString *)normalName Highlighted:(NSString *)highlightedName Selected:(NSString *)selectedName Disabled:(NSString *)disabledName {
    [self setImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:highlightedName] forState:UIControlStateHighlighted];
    [self setImage:[UIImage imageNamed:selectedName] forState:UIControlStateSelected];
    [self setImage:[UIImage imageNamed:disabledName] forState:UIControlStateDisabled];
}

/**
 *  设置仅有一种显示图片的button
 */
- (void)setOnlyImageName:(NSString *)imageName {
    [self setImageNameNormal:imageName Highlighted:imageName Selected:imageName Disabled:imageName];
}



@end
