//
//  ZCPBookPostModel.h
//  Apartment
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPDataModel.h"

#import "ZCPUserModel.h"
#import "ZCPFieldModel.h"
#import "ZCPBookModel.h"

// 用户点赞状态
typedef NS_ENUM(NSInteger, ZCPBookpostSupportState){
    ZCPCurrUserNotSupportBookpost = 0,         //未点赞
    ZCPCurrUserHaveSupportBookpost =  1        //已点赞
};
// 用户收藏状态
typedef NS_ENUM(NSInteger, ZCPBookpostCollectState){
    ZCPCurrUserNotCollectBookpost = 0,         //未收藏
    ZCPCurrUserHaveCollectBookpost = 1         //已收藏
};

@interface ZCPBookPostModel : ZCPDataModel

@property (nonatomic, assign) NSInteger bookpostId;                 // 图书贴表编号
@property (nonatomic, copy) NSString *bookpostTitle;                // 帖子标题
@property (nonatomic, copy) NSString *bookpostContent;              // 帖子内容
@property (nonatomic, copy) NSString *bookpostPosition;             // 发帖人定位位置(发帖人发帖时所在的GPS定位位置)
@property (nonatomic, assign) NSInteger bookpostSupport;            // 帖子点赞量
@property (nonatomic, strong) NSDate *bookpostTime;                 // 发帖时间
@property (nonatomic, strong) ZCPUserModel *user;                   // 发帖人
@property (nonatomic, strong) ZCPFieldModel *field;                 // 帖子所属领域
@property (nonatomic, strong) ZCPBookModel *book;                   // 帖子所关联书籍
@property (nonatomic, assign) NSInteger bookpostReplyNumber;        // 帖子回复数量
@property (nonatomic, assign) NSInteger bookpostCollectNumber;      // 收藏人数
@property (nonatomic, assign) ZCPBookpostSupportState supported;    // 当前用户是否已点过赞
@property (nonatomic, assign) ZCPBookpostCollectState collected;    // 当前用户是否已收藏

@end
