//
//  ZCPUserControllerHelper.h
//  Apartment
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

// 个人中心二级视图控制器标识
typedef NS_ENUM(NSUInteger, ZCPUserCellTag) {
    ZCPUserFocusOnPeopleCellTag = 100,  // 关注人cell标识
    ZCPUserAchievementCellTag,          // 成就cell标识
    ZCPUserCollectionCellTag,           // 收藏cell标识
    ZCPUserSettingCellTag,              // 设置cell标识
    ZCPUserAboutCellTag                 // 关于cell标识
};

// 设置二级视图控制器标识
typedef NS_ENUM(NSUInteger, ZCPSettingCellTag) {
    ZCPSettingUserInfoCellTag = 200,    // 设置用户信息cell标识
    ZCPSettingChangePwdCellTag,         // 修改密码cell标识
};

@interface ZCPUserControllerHelper : NSObject

@end
