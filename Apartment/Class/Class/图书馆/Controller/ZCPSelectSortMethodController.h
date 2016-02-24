//
//  ZCPSelectSortMethodController.h
//  Apartment
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewController.h"

@protocol ZCPSelectSortMethodDelegate;

@interface ZCPSelectSortMethodController : ZCPTableViewController

@property (nonatomic, weak) id<ZCPSelectSortMethodDelegate> delegate;

/**
 *  显示选择领域视图
 */
- (void)showView;
/**
 *  隐藏选择领域视图
 */
- (void)hideView;

@end

@protocol ZCPSelectSortMethodDelegate <NSObject>

- (void)selectedCellIndex:(NSInteger) cellIndex sortMethodName:(NSString *)sortMethodName;

@end