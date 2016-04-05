//
//  UIBarButtonItem+Category.m
//  Apartment
//
//  Created by apple on 15/12/31.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "UIBarButtonItem+Category.h"

@implementation UIBarButtonItem (Category)

+ (id)setCustomBackBarItem:(NSString *)title target:(id)target action:(SEL)action {
    return nil;
}

+ (id)setCustomBackBarItemWithTarget:(id)target action:(SEL)action {
    return [UIBarButtonItem setCustomBackBarItem:@"" target:target action:action];
}

+ (id)setBackItemWithTarget:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.exclusiveTouch = YES;  // UIView会独占整个Touch事件
    button.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:@"<" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont defaultBoldFontWithSize:20.0f];
    button.showsTouchWhenHighlighted = YES;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    ((UIViewController *)target).navigationItem.leftBarButtonItem = backItem;
    return backItem;
}

+ (id)barItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    return [UIBarButtonItem barItemWithTitle:title
                                        font:[UIFont fontWithName:@"iconfont" size:16]
                                      target:target action:action];
}

+ (id)barItemWithTitle:(NSString *)title font:(UIFont *)font target:(id)target action:(SEL)action {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    btn.exclusiveTouch = YES;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    btn.showsTouchWhenHighlighted = YES;
    if (font) {
        btn.titleLabel.font = font;
    } else{
        btn.titleLabel.font = [UIFont defaultBoldFontWithSize:20.0f];
    }
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
