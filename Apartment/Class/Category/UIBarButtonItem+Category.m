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
    button.titleLabel.font = [UIFont systemFontOfSize:20.0f weight:30.0f];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    ((UIViewController *)target).navigationItem.leftBarButtonItem = backItem;
    return backItem;
}

@end
