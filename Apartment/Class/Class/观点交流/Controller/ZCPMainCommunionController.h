//
//  ZCPMainCommunionController.h
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

// 图书贴列表
@interface ZCPMainCommunionController : ZCPTableViewController

#pragma mark - Public Method
// 点击图书详情的“搜索交流贴”会切换到该控制器执行此方法
- (void)librarySearchBookName:(NSString *)bookName;

@end
