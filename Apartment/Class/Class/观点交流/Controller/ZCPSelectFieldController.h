//
//  ZCPSelectFieldController.h
//  Apartment
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewController.h"

@protocol ZCPSelectFieldDelegate;

@interface ZCPSelectFieldController : ZCPTableViewController

@property (nonatomic, strong) NSMutableArray *fieldArr;
@property (nonatomic, weak) id<ZCPSelectFieldDelegate> delegate;

/**
 *  显示选择领域视图
 */
- (void)showView;
/**
 *  隐藏选择领域视图
 */
- (void)hideView;

@end

@protocol ZCPSelectFieldDelegate <NSObject>

- (void)selectedCellIndex:(NSInteger) cellIndex fieldName:(NSString *)fieldName;

@end