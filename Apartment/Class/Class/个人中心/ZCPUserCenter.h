//
//  ZCPUserCenter.h
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZCPUserModel.h"

// 用户中心
@interface ZCPUserCenter : NSObject

DEF_SINGLETON(ZCPUserCenter)

@property (nonatomic, strong) ZCPUserModel *currentUserModel;       // 当前用户模型
@property (nonatomic, assign, getter=isLogin) BOOL login;           // 登陆状态

/**
 *  保存用户模型
 */
- (void)saveUserModel:(ZCPUserModel *)userModel;
/**
 *  登出
 */
- (void)logout;
/**
 *  清除当前用户
 */
- (void)clearUserModel;

@end
