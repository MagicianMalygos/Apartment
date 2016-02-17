//
//  ZCPCoupletMainController.h
//  Apartment
//
//  Created by apple on 16/1/21.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewController.h"

/**
 *  排序方法类型
 */
typedef NS_ENUM(NSInteger, ZCPCoupletSortMethod){
    ZCPCoupletSortByTime,    // 通过时间排序
    ZCPCoupletSortBySupport  // 通过点赞量排序
};

// 对对联主视图控制器
@interface ZCPCoupletMainController : ZCPTableViewController

@end
