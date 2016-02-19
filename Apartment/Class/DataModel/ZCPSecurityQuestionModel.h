//
//  ZCPSecurityQuestionModel.h
//  Apartment
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPDataModel.h"

#import "ZCPUserModel.h"

@interface ZCPSecurityQuestionModel : ZCPDataModel

@property (nonatomic, assign) NSInteger securityQuestionId;   // 密保问题表编号
@property (nonatomic, copy) NSString *securityQuestionOne;    // 密保问题一
@property (nonatomic, copy) NSString *securityQuestionTwo;    // 密保问题二
@property (nonatomic, copy) NSString *securityQuestionThree;  // 密保问题三
@property (nonatomic, copy) NSString *securityAnswerOne;      // 密保答案一
@property (nonatomic, copy) NSString *securityAnswerTwo;      // 密保答案二
@property (nonatomic, copy) NSString *securityAnswerThree;    // 密保答案三
@property (nonatomic, strong) NSDate *secutityTime;           // 记录添加时间
@property (nonatomic, strong) ZCPUserModel *user;             // 关联用户

@end
