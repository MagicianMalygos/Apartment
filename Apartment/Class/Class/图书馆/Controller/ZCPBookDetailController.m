//
//  ZCPBookDetailController.m
//  Apartment
//
//  Created by apple on 16/1/28.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookDetailController.h"

#import "ZCPBookModel.h"
#import "ZCPBookCell.h"

@interface ZCPBookDetailController ()

@property (nonatomic, strong) ZCPBookModel *currentBookModel;       // 当前的图书模型

@end

@implementation ZCPBookDetailController

@synthesize currentBookModel = _currentBookModel;

#pragma mark - init
- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        self.currentBookModel = [params objectForKey:@"_currentBookModel"];
    }
    return self;
}

#pragma mark - life circle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self clearNavigationBar];
    self.tabBarController.title = @"图书详情";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar);
}

#pragma mark - Construct Data
- (void)constructData {
    
    NSMutableArray *items = [NSMutableArray array];
    
    ZCPBookDetailCellItem* bookItem = [[ZCPBookDetailCellItem alloc] initWithDefault];
    bookItem.bookCoverURL = self.currentBookModel.bookCoverURL;
    bookItem.bookName = self.currentBookModel.bookName;
    bookItem.bookAuthor = self.currentBookModel.bookAuthor;
    bookItem.bookPublisher = self.currentBookModel.bookPublisher;
    bookItem.field = @[self.currentBookModel.field.fieldName];
    bookItem.bookPublishTime = self.currentBookModel.bookPublishTime;
    bookItem.contributor = self.currentBookModel.contributor.userName;
    bookItem.bookCommentCount = self.currentBookModel.bookCommentCount;
    bookItem.bookCollectNumber = self.currentBookModel.bookCollectNumber;
    bookItem.bookSummary = self.currentBookModel.bookSummary;
    bookItem.bookpostSearchButtonTitle = @"搜索图书贴相关内容";
    bookItem.webSearchButtonTitle = @"搜索网络相关内容";
    
    [items addObject:bookItem];
    self.tableViewAdaptor.items = items;
}

@end
