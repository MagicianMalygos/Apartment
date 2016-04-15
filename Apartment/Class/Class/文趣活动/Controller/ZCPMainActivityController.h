//
//  ZCPMainActivityController.h
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

// 文趣活动主视图控制器
@interface ZCPMainActivityController : ZCPViewController

@property (nonatomic, assign) NSInteger activityIndex;
// 通过对应的索引切换当前显示的活动
- (void)switchActivityWithIndex:(NSInteger)index;

@end
