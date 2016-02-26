//
//  UIButton+Category.h
//  Apartment
//
//  Created by apple on 16/2/2.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Category)

// 设置圆角
- (void)changeToRound;

/**
 *  设置button的全状态image
 */
- (void)setImageNameNormal:(NSString *)normalName Highlighted:(NSString *)highlightedName Selected:(NSString *)selectedName Disabled:(NSString *)disabledName;
/**
 *  设置仅有一种显示图片的button
 */
- (void)setOnlyImageName:(NSString *)imageName;


/**
 *  使用URL设置
 */
- (void)setImageURLNormal:(NSURL *)normalURL Highlighted:(NSURL *)highlightedURL Selected:(NSURL *)selectedURL Disabled:(NSURL *)disabledURL;
- (void)setOnlyImageURL:(NSURL *)imageURL;

/**
 *  使用UIImage设置
 */
- (void)setImageNormal:(UIImage *)normalImage Highlighted:(UIImage *)highlightedImage Selected:(UIImage *)selectedImage Disabled:(UIImage *)disabledImage;
- (void)setOnlyImage:(UIImage *)image;


@end
