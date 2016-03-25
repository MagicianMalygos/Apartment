//
//  ZCPUserModel.h
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPDataModel.h"

@interface ZCPUserModel : ZCPDataModel

@property (nonatomic, assign) NSInteger userId;                 // 用户表编号
@property (nonatomic, copy) NSString *userAccount;              // 用户账号
@property (nonatomic, copy) NSString *userPassword;             // 用户密码(无用)
@property (nonatomic, copy) NSString *userName;                 // 用户昵称
@property (nonatomic, assign) NSInteger userAge;                // 用户年龄
@property (nonatomic, copy) NSString *userFaceURL;              // 用户头像URL
@property (nonatomic, assign) NSInteger userScore;              // 用户答题得分值
@property (nonatomic, assign) NSInteger userEXP;                // 用户经验值
@property (nonatomic, strong) NSDate *userRegisterTime;         // 用户注册时间
@property (nonatomic, copy) NSString *userLevel;                // 用户称谓
@property (nonatomic, strong) NSMutableArray *focusFieldArr;    // 用户关注领域数组

@end
