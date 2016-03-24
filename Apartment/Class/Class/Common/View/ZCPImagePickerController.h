//
//  ZCPImagePickerController.h
//  Apartment
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCPImagePickerController : UIImagePickerController

@end

/**
 *  获取图片选择器
 */
ZCPImagePickerController *getImagePicker(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>delegate, UIImagePickerControllerSourceType sourceType);