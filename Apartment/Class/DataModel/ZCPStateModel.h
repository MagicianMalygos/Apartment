//
//  ZCPStateModel.h
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPDataModel.h"

@interface ZCPStateModel : ZCPDataModel

@property (nonatomic, assign) int stateId;        // 状态表编号
@property (nonatomic, copy) NSString *stateName;  // 状态名称
@property (nonatomic, assign) int stateValue;     // 状态值
@property (nonatomic, copy) NSString *stateType;  // 状态类型（标识是属于哪个模型的状态）
@property (nonatomic, strong) NSDate *stateTime;  // 记录添加时间

@end
