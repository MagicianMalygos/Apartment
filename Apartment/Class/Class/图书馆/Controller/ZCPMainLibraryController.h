//
//  ZCPMainLibraryController.h
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, ZCPLibrarySortMethod) {
    ZCPLibrarySortByTime    = 0,
    ZCPLibrarySortBySupport = 1,
    ZCPLibrarySortByComment = 2
};

// 图书馆视图控制器
@interface ZCPMainLibraryController : ZCPTableViewController

@end
