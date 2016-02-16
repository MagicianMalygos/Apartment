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


/**
 *  使用URL设置
 */
- (void)setImageURLNormal:(NSURL *)normalURL Highlighted:(NSURL *)highlightedURL Selected:(NSURL *)selectedURL Disabled:(NSURL *)disabledURL {
    
    NSArray *array = @[@{@"url":normalURL, @"state":[NSNumber numberWithUnsignedInteger:UIControlStateNormal]}
                       ,@{@"url":highlightedURL, @"state":[NSNumber numberWithUnsignedInteger:UIControlStateHighlighted]}
                       ,@{@"url":selectedURL, @"state":[NSNumber numberWithUnsignedInteger:UIControlStateSelected]}
                       ,@{@"url":disabledURL, @"state":[NSNumber numberWithUnsignedInteger:UIControlStateDisabled]}];
    
    for (int i = 0; i < array.count; i++) {
        WEAK_SELF;
        [[UIImageView new] sd_setImageWithURL:array[i][@"url"] placeholderImage:[UIImage imageNamed:HEAD_DEFAULT] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            STRONG_SELF;
            UIImage *loadImage = nil;
            if (image != nil) {
                loadImage = image;
            }
            else {
                loadImage = [UIImage imageNamed:HEAD_DEFAULT];
            }
            
            [self setImage:loadImage forState:[array[i][@"state"] unsignedIntegerValue]];
        }];
    }
}
- (void)setOnlyImageURL:(NSURL *)imageURL {
    WEAK_SELF;
    [[UIImageView new] sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:HEAD_DEFAULT] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        STRONG_SELF;
        UIImage *loadImage = nil;
        if (image != nil) {
            loadImage = image;
        }
        else {
            loadImage = [UIImage imageNamed:HEAD_DEFAULT];
        }
        
        [self setImage:loadImage forState:UIControlStateNormal];
        [self setImage:loadImage forState:UIControlStateHighlighted];
        [self setImage:loadImage forState:UIControlStateSelected];
        [self setImage:loadImage forState:UIControlStateDisabled];
    }];
}

/**
 *  使用UIImage设置
 */
- (void)setImageNormal:(UIImage *)normalImage Highlighted:(UIImage *)highlightedImage Selected:(UIImage *)selectedImage Disabled:(UIImage *)disabledImage {
    [self setImage:normalImage forState:UIControlStateNormal];
    [self setImage:highlightedImage forState:UIControlStateHighlighted];
    [self setImage:selectedImage forState:UIControlStateSelected];
    [self setImage:disabledImage forState:UIControlStateDisabled];
}
- (void)setOnlyImage:(UIImage *)image {
    [self setImageNormal:image Highlighted:image Selected:image Disabled:image];
}



@end
