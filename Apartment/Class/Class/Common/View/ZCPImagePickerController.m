//
//  ZCPImagePickerController.m
//  Apartment
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPImagePickerController.h"

@implementation ZCPImagePickerController

@end

/**
 *  获取图片选择器
 */
ZCPImagePickerController *getImagePicker(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>delegate, UIImagePickerControllerSourceType sourceType) {
    ZCPImagePickerController *imagePicker = [[ZCPImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = delegate;
    imagePicker.sourceType = sourceType;
    imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    imagePicker.navigationBar.barTintColor = [UIColor lightGrayColor];
    imagePicker.navigationBar.tintColor = [UIColor whiteColor];
    
    return imagePicker;
}