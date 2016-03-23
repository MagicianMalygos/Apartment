//
//  ZCPSelectMenuController.h
//  Apartment
//
//  Created by apple on 16/3/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZCPSelectMenuDataSource;
@protocol ZCPSelectMenuDelegate;

@interface ZCPSelectMenuController : ZCPTableViewController

@property (nonatomic, strong) NSArray *itemArray;                       // item数组
@property (nonatomic, assign, getter=isViewHidden) BOOL viewHidden;     // 视图隐藏状态
@property (nonatomic, weak) id<ZCPSelectMenuDelegate> delegate;         // delegate

/**
 *  重加载数据
 */
- (void)reloadData;

/**
 *  显示选择领域视图
 */
- (void)showView;
/**
 *  隐藏选择领域视图
 */
- (void)hideView;

@end


#pragma mark - Delegate
@protocol ZCPSelectMenuDelegate <NSObject>
// 点击cell事件
- (void)selectMenuController:(ZCPSelectMenuController *)selectMenuControl selectedCellIndex:(NSInteger) cellIndex item:(NSString *)item;
// 下拉刷新事件
- (void)selectMenuController:(ZCPSelectMenuController *)selectMenuControl refreshHeader:(MJRefreshHeader *)mj_header;

@end