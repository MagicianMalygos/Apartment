//
//  ZCPBookReplyModel.h
//  Apartment
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPDataModel.h"

#import "ZCPUserModel.h"
#import "ZCPBookModel.h"

@interface ZCPBookReplyModel : ZCPDataModel

@property (nonatomic, assign) NSInteger bookreplyId;        // 图书评论表编号
@property (nonatomic, copy) NSString *bookreplyContent;     // 评论内容
@property (nonatomic, assign) NSInteger bookreplySupport;   // 评论点赞量
@property (nonatomic, strong) NSDate *bookreplyTime;        // 评论时间
@property (nonatomic, strong) ZCPUserModel *user;           // 评论人
@property (nonatomic, strong) ZCPBookModel *book;           // 所评论的图书

@end
