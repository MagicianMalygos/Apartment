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

#define BOOK_REPLY_LIST_PAGE_COUNT      PAGE_COUNT_DEFAULT

@interface ZCPBookDetailController () <ZCPCommentViewDelegate, ZCPBookDetailCellDelegate, ZCPBookReplyCellDelegate>

@property (nonatomic, strong) ZCPCommentView *commentView;          // 评论视图
@property (nonatomic, strong) ZCPBookModel *currentBookModel;       // 当前的图书模型
@property (nonatomic, strong) NSMutableArray *bookreplyArr;         // 图书回复模型列表
@property (nonatomic, assign) NSUInteger pagination;                // 页码

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

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    self.pagination = 1;    // 初始化页码
    // 初始化评论视图
    self.commentView = [[ZCPCommentView alloc] initWithTarget:self];
    self.commentView.delegate = self;
    [self.view addSubview:self.commentView];
    
    
    self.bookreplyArr = [NSMutableArray array];
    // 加载数据
    [self loadData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
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
    bookDetailItem.bookCollected = self.currentBookModel.collected;
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
        bookreplyItem.bookreplyId = model.bookreplyId;
        bookreplyItem.bookreplyContent = model.bookreplyContent;
        bookreplyItem.bookreplyTime = model.bookreplyTime;
        bookreplyItem.bookreplySupportNumber = model.bookreplySupport;
        bookreplyItem.bookreplySupported = model.supported;
        bookreplyItem.delegate = self;
        
        [items addObject:bookreplyItem];
    }
    
    self.tableViewAdaptor.items = items;
}

#pragma mark - ZCPBookDetailCellDelegate
/**
 *  观点交流搜索按钮点击响应事件
 */
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
/**
 *  网络搜索按钮点击响应事件
 */
- (void)bookDetailCell:(ZCPBookDetailCell *)cell webSearchButtonClick:(UIButton *)button {
    // 从网络中搜索
    NSString *url = [NSString stringWithFormat:@"http://www.baidu.com/s?wd=%@&cl=3", self.currentBookModel.bookName];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
}
/**
 *  收藏按钮点击响应事件
 */
- (void)bookDetailCell:(ZCPBookDetailCell *)cell collectionButtonClick:(UIButton *)button {
    
    ZCPBookDetailCellItem *bookdetailItem = (ZCPBookDetailCellItem *)cell.item;
    
    // 收藏图书
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] changeBookCurrCollectionState:self.currentBookModel.collected currBookID:self.currentBookModel.bookId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            if (bookdetailItem.bookCollected == ZCPCurrUserNotCollectBook) {
                button.selected = YES;
                bookdetailItem.bookCollected = ZCPCurrUserHaveCollectBook;
                weakSelf.currentBookModel.collected = ZCPCurrUserHaveCollectBook;
                
                TTDPRINT(@"点赞成功！");
                [MBProgressHUD showSuccess:@"点赞成功！" toView:self.view];
            }
            else if (bookdetailItem.bookCollected == ZCPCurrUserHaveCollectBook) {
                button.selected = NO;
                bookdetailItem.bookCollected = ZCPCurrUserNotCollectBook;
                weakSelf.currentBookModel.collected = ZCPCurrUserNotCollectBook;
                
                TTDPRINT(@"取消点赞成功！");
                [MBProgressHUD showSuccess:@"取消点赞成功！" toView:self.view];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"操作失败！%@", error);
        [MBProgressHUD showSuccess:@"操作失败！网络异常！" toView:self.view];
    }];
}
/**
 *  评论按钮点击响应事件
 */
- (void)bookDetailCell:(ZCPBookDetailCell *)cell commentButtonClick:(UIButton *)button {
    // 弹出评论视图
    [self.commentView showCommentView];
}
#pragma mark - ZCPBookReplyCellDelegate
/**
 *  图书回复点赞按钮
 */
- (void)bookReplyCell:(ZCPBookReplyCell *)cell supportButtonClick:(UIButton *)button {
    ZCPBookReplyCellItem *bookreplyItem = (ZCPBookReplyCellItem *)cell.item;
    
    // 点赞图书回复
    [[ZCPRequestManager sharedInstance] changeBookReplyCurrSupportState:bookreplyItem.bookreplySupported currBookReplyID:bookreplyItem.bookreplyId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            if (bookreplyItem.bookreplySupported == ZCPCurrUserNotSupportBookReply) {
                button.selected = YES;
                bookreplyItem.bookreplySupported = ZCPCurrUserHaveCollectBook;
                cell.item.bookreplySupportNumber = cell.item.bookreplySupportNumber + 1;
                cell.bookreplySupportLabel.text = [NSString stringWithFormat:@"%li", cell.item.bookreplySupportNumber];
                
                TTDPRINT(@"点赞成功！");
                [MBProgressHUD showSuccess:@"点赞成功！" toView:self.view];
            }
            else if (bookreplyItem.bookreplySupported == ZCPCurrUserHaveSupportBookReply) {
                button.selected = NO;
                bookreplyItem.bookreplySupported = ZCPCurrUserNotSupportBookReply;
                cell.item.bookreplySupportNumber = cell.item.bookreplySupportNumber - 1;
                cell.bookreplySupportLabel.text = [NSString stringWithFormat:@"%li", cell.item.bookreplySupportNumber];
                
                TTDPRINT(@"取消点赞成功！");
                [MBProgressHUD showSuccess:@"取消点赞成功！" toView:self.view];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"操作失败！%@", error);
        [MBProgressHUD showSuccess:@"操作失败！网络异常！" toView:self.view];
    }];
}

#pragma mark - ZCPCommentViewDelegate
/**
 *  return键响应事件
 */
- (BOOL)textInputShouldReturn:(ZCPTextView *)keyboardResponder {
    
    // 获取文本输入框内容并进行非法性判断
    NSString *coupletReplyContent = keyboardResponder.text;
    if (![self judgeTextInput:coupletReplyContent]) {
        return NO;
    }
    // 上传评论
    TTDPRINT(@"准备提交图书回复内容...");
    [[ZCPRequestManager sharedInstance] addBookReplyContent:coupletReplyContent currBookID:self.currentBookModel.bookId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            TTDPRINT(@"提交成功...");
            [MBProgressHUD showSuccess:@"添加回复成功！" toView:self.view];
            
            // 重新加载数据
            [self loadData];
        }
        else {
            TTDPRINT(@"提交失败...");
            [MBProgressHUD showError:@"添加回复失败！" toView:self.view];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"提交失败...%@", error);
        [MBProgressHUD showError:@"添加回复失败！网络异常！" toView:self.view];
    }];
    // 提交后清除文本输入框内容
    [self.commentView clearText];
    
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


#pragma mark - Load Data
- (void)headerRefresh {
    self.pagination = 1;
    
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getBookReplyListWithCurrBookID:self.currentBookModel.bookId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:BOOK_REPLY_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookReplyListModel) {
        STRONG_SELF;
        if ([bookReplyListModel isKindOfClass:[ZCPListDataModel class]] && bookReplyListModel.items) {
            weakSelf.bookreplyArr = [NSMutableArray arrayWithArray:bookReplyListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}
- (void)footerRefresh {
    
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getBookReplyListWithCurrBookID:self.currentBookModel.bookId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination + 1 pageCount:BOOK_REPLY_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookReplyListModel) {
        STRONG_SELF;
        if ([bookReplyListModel isKindOfClass:[ZCPListDataModel class]] && bookReplyListModel.items) {
            [weakSelf.bookreplyArr addObjectsFromArray:bookReplyListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
            if (bookReplyListModel.items.count > 0) {
                self.pagination ++;
            }
        }
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

/**
 *  加载数据
 */
- (void)loadData {
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getBookReplyListWithCurrBookID:self.currentBookModel.bookId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:BOOK_REPLY_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookReplyListModel) {
        STRONG_SELF;
        if ([bookReplyListModel isKindOfClass:[ZCPListDataModel class]] && bookReplyListModel.items) {
            weakSelf.bookreplyArr = [NSMutableArray arrayWithArray:bookReplyListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
    }];
}


@end
