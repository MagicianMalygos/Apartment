//
//  ZCPBookDetailController.m
//  Apartment
//
//  Created by apple on 16/1/28.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookDetailController.h"

#import "ZCPBookModel.h"
#import "ZCPBookReplyModel.h"
#import "ZCPBookCell.h"
#import "ZCPIntroductionCell.h"
#import "ZCPSectionCell.h"
#import "ZCPBookReplyCell.h"

@interface ZCPBookDetailController ()

@property (nonatomic, strong) ZCPBookModel *currentBookModel;       // 当前的图书模型
@property (nonatomic, strong) NSMutableArray *bookreplyArr;         // 图书回复模型列表

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
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bookreplyArr = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        ZCPBookReplyModel *model = [ZCPBookReplyModel modelFromDictionary:@{@"bookreplyContent":@"asdasd"
                                                                            ,@"bookreplySupport":@50
                                                                            ,@"bookreplyTime":@"2016-1-1 10:01:02"
                                                                            ,@"user":@{@"userName":@"zcp"
                                                                                       , @"userFaceURL":@"xx://xx"}}];
        [self.bookreplyArr addObject:model];
    }
    
    [self constructData];
    [self.tableView reloadData];
}
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
    
    // book info item
    ZCPBookDetailCellItem* bookDetailItem = [[ZCPBookDetailCellItem alloc] initWithDefault];
    bookDetailItem.bookCoverURL = self.currentBookModel.bookCoverURL;
    bookDetailItem.bookName = self.currentBookModel.bookName;
    bookDetailItem.bookAuthor = self.currentBookModel.bookAuthor;
    bookDetailItem.bookPublisher = self.currentBookModel.bookPublisher;
    bookDetailItem.field = @[self.currentBookModel.field.fieldName];
    bookDetailItem.bookPublishTime = self.currentBookModel.bookPublishTime;
    bookDetailItem.contributor = self.currentBookModel.contributor.userName;
    bookDetailItem.bookCommentCount = self.currentBookModel.bookCommentCount;
    bookDetailItem.bookCollectNumber = self.currentBookModel.bookCollectNumber;
    bookDetailItem.bookpostSearchButtonTitle = @"搜索图书贴相关内容";
    bookDetailItem.webSearchButtonTitle = @"搜索网络相关内容";
    
    // sectionItem1
    ZCPSectionCellItem *sectionItem1 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem1.sectionTitle = @"简介";
    
    // introductionItem
    ZCPIntroductionCellItem *introductionItem = [[ZCPIntroductionCellItem alloc] initWithDefault];
    introductionItem.introductionString = self.currentBookModel.bookSummary;
    
    // sectionItem2
    ZCPSectionCellItem *sectionItem2 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem2.sectionTitle = @"相关评论";
    
    [items addObject:bookDetailItem];
    [items addObject:sectionItem1];
    [items addObject:introductionItem];
    [items addObject:sectionItem2];
    
    // bookreply
    for (ZCPBookReplyModel *model in self.bookreplyArr) {
        ZCPBookReplyCellItem *bookreplyItem = [[ZCPBookReplyCellItem alloc] initWithDefault];
        bookreplyItem.userHeadImageURL = model.user.userFaceURL;
        bookreplyItem.userName = model.user.userName;
        bookreplyItem.bookreplyContent = model.bookreplyContent;
        bookreplyItem.bookreplyTime = model.bookreplyTime;
        bookreplyItem.bookreplySupportNumber = model.bookreplySupport;
        
        [items addObject:bookreplyItem];
    }
    
    self.tableViewAdaptor.items = items;
}

@end
