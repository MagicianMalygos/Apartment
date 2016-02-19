//
//  ZCPFieldModel.h
//  Apartment
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPDataModel.h"

@interface ZCPFieldModel : ZCPDataModel

@property (nonatomic, assign) NSInteger fieldId;  // 领域表编号
@property (nonatomic, copy) NSString *fieldName;  // 领域名称

@end
