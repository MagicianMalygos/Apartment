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
#import "ZCPTabBarController.h"
#import "ZCPMainCommunionController.h"
#import "ZCPCommentView.h"
#import "ZCPRequestManager+Library.h"

@interface ZCPBookDetailController () <ZCPBookDetailCellDelegate, ZCPCommentViewDelegate>

@property (nonatomic, strong) ZCPCommentView *commentView;          // 评论视图
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
    
    // 初始化
    self.commentView = [[ZCPCommentView alloc] initWithTarget:self];
    self.commentView.delegate = self;
    [self.view addSubview:self.commentView];
    
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
    bookDetailItem.bookpostSearchButtonTitle = @"搜索图书贴";
    bookDetailItem.webSearchButtonTitle = @"搜索网络";
    bookDetailItem.delegate = self;
    
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
//        bookreplyItem.delegate = self;
        
        [items addObject:bookreplyItem];
    }
    
    self.tableViewAdaptor.items = items;
}

#pragma mark - ZCPBookDetailCellDelegate
- (void)bookDetailCell:(ZCPBookDetailCell *)cell bookpostSearchButtonClick:(UIButton *)button {
    // 图书贴搜索
    NSString *bookName = self.currentBookModel.bookName;
    // pop控制器
    [self.navigationController popViewControllerAnimated:YES];
    
    // 在观点交流模块搜索
    ZCPTabBarController *tabBarController = (ZCPTabBarController *)self.navigationController.topViewController;
    ZCPMainCommunionController *communionController = [tabBarController.viewControllers objectAtIndex:1];
    [communionController librarySearchBookName:bookName];
    // 切换tab
    tabBarController.selectedViewController = communionController;
}
- (void)bookDetailCell:(ZCPBookDetailCell *)cell webSearchButtonClick:(UIButton *)button {
    // 从网络中搜索
    NSString *url = [NSString stringWithFormat:@"http://www.baidu.com/s?wd=%@&cl=3", self.currentBookModel.bookName];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
}
- (void)bookDetailCell:(ZCPBookDetailCell *)cell collectionButtonClick:(UIButton *)button {
    // 收藏图书
    [[ZCPRequestManager sharedInstance] ];
}
- (void)bookDetailCell:(ZCPBookDetailCell *)cell commentButtonClick:(UIButton *)button {
    // 弹出评论视图
    [self.commentView showCommentView];
}

#pragma mark - ZCPCommentViewDelegate
- (BOOL)textInputShouldReturn:(ZCPTextView *)keyboardResponder {
    if (![self judgeTextInput:keyboardResponder.text]) {
        return NO;
    }
    // 上传评论
    return YES;
}

#pragma mark - Private Method
/**
 *  输入检测
 */
- (BOOL)judgeTextInput:(NSString *)text {
    if (text.length == 0) {
        [MBProgressHUD showError:@"评论不能为空！" toView:self.view];
        return NO;
    }
    else if (text.length > 50) {
        [MBProgressHUD showError:@"字数不得超过50字！" toView:self.view];
        return NO;
    }
    return YES;
}


@end
