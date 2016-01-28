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

@interface ZCPBookModel : ZCPDataModel

@property (nonatomic, assign) int bookId;                       // 图书表编号
@property (nonatomic, copy) NSString *bookName;                 // 图书名称
@property (nonatomic, copy) NSString *bookAuthor;               // 图书作者
@property (nonatomic, strong) NSDate *bookPublishTime;          // 图书出版时间
@property (nonatomic, copy) NSString *bookCoverURL;             // 图书封面
@property (nonatomic, copy) NSString *bookPublisher;            // 图书出版社
@property (nonatomic, copy) NSString *bookSummary;              // 图书简介
@property (nonatomic, assign) int bookCommentCount;             // 图书评论数量
@property (nonatomic ,assign) int bookCollectNumber;            // 收藏数量
@property (nonatomic, strong) NSDate *bookTime;                 // 记录添加时间
@property (nonatomic, strong) ZCPFieldModel *field;             // 图书所在领域
@property (nonatomic, strong) ZCPUserModel *contributor;        // 图书贡献者

@end
