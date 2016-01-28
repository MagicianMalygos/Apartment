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

@property (nonatomic, strong) ZCPUserModel *currentUserModel;
@property (nonatomic, assign, getter=isLogin) BOOL login;

- (void)saveUserModel:(ZCPUserModel *)userModel;
- (void)logout;
- (void)clearUserModel;

@end
