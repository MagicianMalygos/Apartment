//
//  ZCPNavigator.h
//  Apartment
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPBaseNavigator.h"

@interface ZCPNavigator : ZCPBaseNavigator

DEF_SINGLETON(ZCPNavigator)

#pragma mark - jump
/**
 *  视图控制器跳转方法
 *
 *  @param identifier       试图控制器标识
 *  @param paramDictForInit 初始化参数
 */
- (void)gotoViewWithIdentifier:(NSString *)identifier paramDictForInit:(NSDictionary *)paramDictForInit;

@end
