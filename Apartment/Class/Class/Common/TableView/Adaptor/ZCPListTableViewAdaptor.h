//
//  ZCPListTableViewAdaptor.h
//  Apartment
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZCPTableViewCellItemBasicProtocol.h"
#import "PATableHeaderDragRefreshView.h"
#import "PALoadFooterView.h"

@protocol ZCPListTableViewAdaptorDelegate;

/**
 *  处理tableview的适配工作
 */
@interface ZCPListTableViewAdaptor : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

// cell显示所需数据数组，每一个数据模型都要实现PATableViewCellItemBasicProtocol协议
@property (nonatomic, strong) NSMutableArray *items;

// 下拉刷新控制
@property (nonatomic, assign) BOOL dragRefreshEnable;
// 上拉刷新控制
@property (nonatomic, assign) BOOL loadMoreEnable;
@property (nonatomic, strong) PATableHeaderDragRefreshView *headerRefreshView;
@property (nonatomic, strong) PALoadFooterView *loadMoreView;

// cell点击事件对应的action，使用celltype进行索引
@property (nonatomic, strong) NSMutableDictionary *cellActionDictionary;
// cell执行点击事件的对象存放的字典，使用celltype进行索引
@property (nonatomic, strong)NSMutableDictionary *cellTargetDictionary;

@property (nonatomic, weak) id<ZCPListTableViewAdaptorDelegate> delegate;

#pragma mark - method
- (nonnull ZCPTableViewCell *)generateCellForObject:(nonnull id<ZCPTableViewCellItemBasicProtocol>)object indexPath:(nonnull NSIndexPath *)indexPath identifier:(nonnull NSString *)identifier;
- (CGFloat)heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
- (void)finishLoadingDataWithResult:(BOOL)result;

@end

#pragma mark - 适配器协议
@protocol ZCPListTableViewAdaptorDelegate <NSObject>

@optional
/**
 *  处理tableview cell选中事件
 *  @param object    选中的cell对应的数据模型
 */
- (void)tableView:(nonnull UITableView *)tableView didSelectObject:(nonnull id<ZCPTableViewCellItemBasicProtocol>)object rowAtIndexPath:(nonnull NSIndexPath *)indexPath;
- (void)tableView:(nonnull UITableView *)tableView didSetObject:(nonnull id<ZCPTableViewCellItemBasicProtocol>)object cell:(nonnull UITableViewCell *)cell;

- (UITableViewCellEditingStyle)tableView:(nonnull UITableView *)tableView editingStyleForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
- (void)tableView:(nonnull UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
- (nullable NSString *)tableView:(nonnull UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

- (BOOL)tableViewDataIsLoading:(nonnull UITableView *)tableView;
- (void)tableViewTriggerRefresh:(nonnull UITableView *)tableView;
// 拉到底部判断是否需要加载
- (void)tableViewReachToEnd:(nonnull UITableView *)tableView;

- (BOOL)tableView:(nonnull UITableView *)tableView canEditRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

@end