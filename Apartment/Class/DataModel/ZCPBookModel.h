//
//  ZCPBookModel.h
//  Apartment
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPDataModel.h"

#import "ZCPFieldModel.h"
#import "ZCPUserModel.h"

// 收藏状态
typedef NS_ENUM(NSInteger, ZCPBookCollectState) {
    ZCPCurrUserNotCollectBook = 0,  // 未收藏
    ZCPCurrUserHaveCollectBook = 1  // 已收藏
};

// 图书模型
@interface ZCPBookModel : ZCPDataModel

@property (nonatomic, assign) NSInteger bookId;                 // 图书表编号
@property (nonatomic, copy) NSString *bookName;                 // 图书名称
@property (nonatomic, copy) NSString *bookAuthor;               // 图书作者
@property (nonatomic, strong) NSDate *bookPublishTime;          // 图书出版时间
@property (nonatomic, copy) NSString *bookCoverURL;             // 图书封面
@property (nonatomic, copy) NSString *bookPublisher;            // 图书出版社
@property (nonatomic, copy) NSString *bookSummary;              // 图书简介
@property (nonatomic, assign) NSInteger bookCommentCount;       // 图书评论数量
@property (nonatomic ,assign) NSInteger bookCollectNumber;      // 收藏数量
@property (nonatomic, strong) NSDate *bookTime;                 // 记录添加时间
@property (nonatomic, strong) ZCPFieldModel *field;             // 图书所在领域
@property (nonatomic, strong) ZCPUserModel *contributor;        // 图书贡献者
@property (nonatomic, assign) ZCPBookCollectState collected;    // 当前用户是否已经收藏该图书

@end
