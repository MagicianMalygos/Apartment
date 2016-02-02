//
//  UIButton+Category.h
//  Apartment
//
//  Created by apple on 16/2/2.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Category)

/**
 *  设置button的全状态image
 */
- (void)setImageNameNormal:(NSString *)normalName Highlighted:(NSString *)highlightedName Selected:(NSString *)selectedName Disabled:(NSString *)disabledName;
/**
 *  设置仅有一种显示图片的button
 */
- (void)setOnlyImageName:(NSString *)imageName;



@end
