//
//  ZCPBookpostDetailController.m
//  Apartment
//
//  Created by apple on 16/3/30.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookpostDetailController.h"
#import "ZCPBookPostModel.h"
#import "ZCPBookPostCommentModel.h"
#import "ZCPRequestManager+Communion.h"
#import "ZCPBookpostDetailCell.h"
#import "ZCPBookpostCommentCell.h"
#import "ZCPSectionCell.h"
#import "ZCPCommentView.h"

#define BOOKPOST_COMMENT_LIST_PAGE_COUNT    PAGE_COUNT_DEFAULT

@interface ZCPBookpostDetailController () <ZCPBookpostDetailCellDelegate, ZCPCommentViewDelegate>

@property (nonatomic, strong) ZCPCommentView *commentView;              // 评论视图
@property (nonatomic, strong) ZCPBookPostModel *currentBookpostModel;   // 当前图书贴模型
@property (nonatomic, strong) NSMutableArray *bookpostCommentArray;     // 图书贴评论数组
@property (nonatomic, assign) NSUInteger pagination;                    // 页码

@end

@implementation ZCPBookpostDetailController

#pragma mark - init
- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        self.currentBookpostModel = [params objectForKey:@"_currentBookpostModel"];
    }
    return self;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    self.pagination = 1;
    
    // 添加CommentView
    self.commentView = [[ZCPCommentView alloc] initWithTarget:self];
    self.commentView.delegate = self;
    [self.view addSubview:self.commentView];
    
    // 加载数据
    [self loadData];
    
    // 初始化上拉下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self clearNavigationBar];
    // 设置nav Title
    self.title = @"图书贴详情";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar);
}

#pragma mark - getter / setter
- (NSMutableArray *)bookpostCommentArray {
    if (_bookpostCommentArray == nil) {
        _bookpostCommentArray = [NSMutableArray array];
    }
    return _bookpostCommentArray;
}

#pragma mark - Construct Data
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    ZCPBookpostDetailCellItem *bookpostDetailItem = [[ZCPBookpostDetailCellItem alloc] initWithDefault];
    bookpostDetailItem.bookpostModel = self.currentBookpostModel;
    bookpostDetailItem.delegate = self;
    [items addObject:bookpostDetailItem];
    
    ZCPSectionCellItem * section = [[ZCPSectionCellItem alloc] initWithDefault];
    section.cellHeight = @20;
    section.sectionTitle = (self.bookpostCommentArray.count == 0)? @"暂无评论": @"评论";
    [items addObject:section];
    
    for (ZCPBookPostCommentModel *model in self.bookpostCommentArray) {
        model.cellClass = [ZCPBookpostCommentCell class];
        model.cellType = [ZCPBookpostCommentCell cellIdentifier];
        
        [items addObject:model];
    }
    
    // 底部留一块空位置
    ZCPLineCellItem *blankItem = [[ZCPLineCellItem alloc] initWithDefault];
    blankItem.cellHeight = @(40);
    [items addObject:blankItem];
    
    self.tableViewAdaptor.items = items;
}

#pragma mark - ZCPListTableViewAdaptor Delegate
/**
 *  Cell点击事件
 *
 *  @param tableView cell所属Tableview
 *  @param object    cellItem
 *  @param indexPath cell索引
 */
- (void)tableView:(UITableView *)tableView didSelectObject:(id<ZCPTableViewCellItemBasicProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([object isKindOfClass:[ZCPBookPostCommentModel class]]) {
        // 跳转到图书贴详情视图控制器（图书贴评论视图控制器）
        ZCPBookPostCommentModel *selectedCommentModel = (ZCPBookPostCommentModel *)object;
        [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_COMMUNION_BOOKPOSTCOMMENTDETAIL paramDictForInit:@{@"_currCommentModel": selectedCommentModel}];
    }
}

#pragma mark - ZCPCoupletDetailCellDelegate
/**
 *  评论按钮点击事件
 */
- (void)bookpostDetailCell:(ZCPBookpostDetailCell *)cell commentButtonClicked:(UIButton *)button {
    [self.commentView showCommentView];
}
/**
 *  收藏按钮点击事件
 */
- (void)bookpostDetailCell:(ZCPBookpostDetailCell *)cell collectButtonClicked:(UIButton *)button {
    
    [[ZCPRequestManager sharedInstance] changeBookpostCurrCollectionState:self.currentBookpostModel.collected currBookpostID:self.currentBookpostModel.bookpostId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            if (self.currentBookpostModel.collected == ZCPCurrUserHaveCollectBookpost) {
                // 取消收藏成功，取消按钮高亮显示
                button.selected = NO;
                // 设置“是否已收藏”属性为“0”——“未收藏”
                self.currentBookpostModel.collected = ZCPCurrUserNotCollectBookpost;
                self.currentBookpostModel.bookpostCollectNumber --;
                
                TTDPRINT(@"取消收藏成功！");
                [MBProgressHUD showSuccess:@"取消收藏成功！"];
            }
            else {
                // 收藏成功，设置按钮高亮显示
                button.selected = YES;
                // 设置“是否已收藏”属性为“1”——“已收藏”
                self.currentBookpostModel.collected = ZCPCurrUserHaveCollectBookpost;
                self.currentBookpostModel.bookpostCollectNumber ++;
                
                TTDPRINT(@"收藏成功！");
                [MBProgressHUD showSuccess:@"收藏成功！"];
            }
            cell.collectionNumberLabel.text = [NSString stringWithFormat:@"%@ 人收藏", [NSString getFormateFromNumberOfPeople:cell.item.bookpostModel.bookpostCollectNumber]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"操作失败！%@", error);
        [MBProgressHUD showSuccess:@"操作失败！网络异常" toView:self.view];
    }];
}
/**
 *  点赞按钮点击事件
 */
- (void)bookpostDetailCell:(ZCPBookpostDetailCell *)cell supportButtonClicked:(UIButton *)button {
    
    [[ZCPRequestManager sharedInstance] changeBookpostCurrSupportState:self.currentBookpostModel.supported currBookpostID:self.currentBookpostModel.bookpostId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            if (self.currentBookpostModel.supported == ZCPCurrUserNotSupportBookpost) {
                button.selected = YES;
                self.currentBookpostModel.supported = ZCPCurrUserHaveSupportBookpost;
                self.currentBookpostModel.bookpostSupport ++;
                
                TTDPRINT(@"点赞成功！");
                [MBProgressHUD showSuccess:@"点赞成功！"];
            }
            else if (self.currentBookpostModel.supported == ZCPCurrUserHaveSupportBookpost) {
                button.selected = NO;
                self.currentBookpostModel.supported = ZCPCurrUserNotSupportBookpost;
                self.currentBookpostModel.bookpostSupport --;
                
                TTDPRINT(@"取消点赞成功！");
                [MBProgressHUD showSuccess:@"取消点赞成功！"];
            }
            cell.supportNumberLabel.text = [NSString stringWithFormat:@"%@ 人点赞", [NSString getFormateFromNumberOfPeople:cell.item.bookpostModel.bookpostSupport]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"操作失败！%@", error);
        [MBProgressHUD showSuccess:@"操作失败！网络异常！"];
    }];
}

#pragma mark - ZCPCommentViewDelegate
/**
 *  return键响应方法，提交对联回复的方法
 *
 *  @param keyboardResponder 文本输入框
 *
 *  @return 是否隐藏键盘
 */
- (BOOL)textInputShouldReturn:(ZCPTextView *)keyboardResponder {
    
    // 获取文本输入框内容并进行非法性判断
    NSString *commentContent = keyboardResponder.text;
    if ([ZCPJudge judgeNullTextInput:commentContent showErrorMsg:@"评论不能为空！"]
        || [ZCPJudge judgeOutOfRangeTextInput:commentContent range:[ZCPLengthRange rangeWithMin:1 max:2000] showErrorMsg:@"字数不得超过2000字！"]) {
        return NO;
    }
    
    TTDPRINT(@"准备提交图书贴评论内容...");
    [[ZCPRequestManager sharedInstance] addBookpostCommentWithBookpostCommentContent:commentContent bookpostID:self.currentBookpostModel.bookpostId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            TTDPRINT(@"提交成功...");
            [MBProgressHUD showSuccess:@"添加评论成功！" toView:self.view];
            
            // 回复量加1
            self.currentBookpostModel.bookpostReplyNumber ++;
            // 重新加载数据
            [self loadData];
        }
        else {
            TTDPRINT(@"提交失败...");
            [MBProgressHUD showError:@"添加评论失败！" toView:self.view];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"提交失败...%@", error);
        [MBProgressHUD showError:@"添加评论失败！网络异常！" toView:self.view];
    }];

    // 提交后清除文本输入框内容
    [self.commentView clearText];
    
    return YES;
}

#pragma mark - Load Data
/**
 *  下拉刷新
 */
- (void)headerRefresh {
    self.pagination = 1;
    
    // 获取数据
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getBookpostCommentListWithBookpostID:self.currentBookpostModel.bookpostId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:BOOKPOST_COMMENT_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostCommentListModel) {
        STRONG_SELF;
        if ([bookpostCommentListModel isKindOfClass:[ZCPListDataModel class]] && bookpostCommentListModel.items) {
            weakSelf.bookpostCommentArray  = [NSMutableArray arrayWithArray:bookpostCommentListModel.items];
            
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
/**
 *  上拉刷新
 */
- (void)footerRefresh {
    // 获取数据
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getBookpostCommentListWithBookpostID:self.currentBookpostModel.bookpostId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination + 1 pageCount:BOOKPOST_COMMENT_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostCommentListModel) {
        STRONG_SELF;
        if ([bookpostCommentListModel isKindOfClass:[ZCPListDataModel class]] && bookpostCommentListModel.items) {
            [weakSelf.bookpostCommentArray addObjectsFromArray:bookpostCommentListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
            // 如果获取到数据了，那么页数+1
            if (bookpostCommentListModel.items.count > 0) {
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
 *  加载观点评论数据
 */
- (void)loadData {
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getBookpostCommentListWithBookpostID:self.currentBookpostModel.bookpostId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:BOOKPOST_COMMENT_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostCommentListModel) {
        STRONG_SELF;
        if ([bookpostCommentListModel isKindOfClass:[ZCPListDataModel class]] && bookpostCommentListModel.items) {
            weakSelf.bookpostCommentArray = [NSMutableArray arrayWithArray:bookpostCommentListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
    }];
}

@end
