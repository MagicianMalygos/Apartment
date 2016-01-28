//
//  ZCPTableViewController.h
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCPViewController.h"
#import "ZCPListTableViewAdaptor.h"

// 表格视图控制器基类
@interface ZCPTableViewController : ZCPViewController <ZCPListTableViewAdaptorDelegate, UITableViewDelegate, UITableViewDataSource>

// table view
@property (nonatomic, strong) UITableView *tableView;
// 适配器
@property (nonatomic, strong) ZCPListTableViewAdaptor *tableViewAdaptor;

/**
 *  构造数据
 */
- (void)constructData;

@end
