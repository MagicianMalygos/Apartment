//
//  UIImageView+Category.m
//  Apartment
//
//  Created by apple on 16/2/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "UIImageView+Category.h"

@implementation UIImageView (Category)

// 变圆
- (void)changeToRound {
    self.layer.masksToBounds = YES;  // 不加这句代码，随着移动，圆形的头像的边缘外会各种变形。该方法告诉layer将位于它之下的layer都遮盖住
    self.layer.cornerRadius = self.layer.bounds.size.height * 0.5;
}

@end
