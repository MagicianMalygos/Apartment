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
    ZCPUserFocusOnPeopleCellTag = 100,
    ZCPUserAchievementCellTag,
    ZCPUserCollectionCellTag,
    ZCPUserSettingCellTag,
    ZCPUserAboutCellTag
};

// 设置二级视图控制器标识
typedef NS_ENUM(NSUInteger, ZCPSettingCellTag) {
    ZCPSettingUserInfoCellTag = 200,
    ZCPSettingChangePwdCellTag,
    ZCPSettingChangeSecurityCellTag
};


@interface ZCPUserControllerHelper : NSObject

@end
