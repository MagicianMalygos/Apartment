//
//  ZCPBookpostCommentReplyController.m
//  Apartment
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookpostCommentReplyController.h"
#import "ZCPCommentView.h"
#import "ZCPRequestManager+Communion.h"
#import "ZCPSectionCell.h"
#import "ZCPBookpostCommentReplyCell.h"

#define BOOKPOST_COMMENT_REPLY_LIST_PAGE_COUNT    PAGE_COUNT_DEFAULT

@interface ZCPBookpostCommentReplyController () <ZCPCommentViewDelegate, ZCPBookpostCommentReplyCellDelegate>

@property (nonatomic, strong) ZCPBookPostCommentModel *currCommentModel;    // 当前评论模型
@property (nonatomic, assign) NSUInteger pagination;                        // 页码
@property (nonatomic, strong) ZCPCommentView *commentView;                  // 评论视图
@property (nonatomic, strong) NSMutableArray *replyArray;                   // 回复数组
@property (nonatomic, assign) NSInteger receiverID;                         // 点击cell的回复模型对应的用户ID

@end

@implementation ZCPBookpostCommentReplyController

#pragma mark - init
- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        self.currCommentModel = [params objectForKey:@"_currCommentModel"];
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
    
    // 初始化上拉下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 加载数据
    [self loadData];
    
    [self clearNavigationBar];
    self.title = @"回复列表";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithTitle:@"+" font:[UIFont defaultBoldFontWithSize:20.0f] target:self action:@selector(addReply)];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar);
}

#pragma mark - getter / setter
- (NSMutableArray *)replyArray {
    if (_replyArray == nil) {
        _replyArray = [NSMutableArray array];
    }
    return _replyArray;
}

#pragma mark - Construct Data
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    for (ZCPBookPostCommentReplyModel *model in self.replyArray) {
        
        ZCPBookpostCommentReplyCellItem *replyItem = [[ZCPBookpostCommentReplyCellItem alloc] initWithDefault];
        replyItem.replyModel = model;
        replyItem.replyModel.comment = self.currCommentModel;
        replyItem.delegate = self;
        
        [items addObject:replyItem];
    }
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
    
    if ([object isKindOfClass:[ZCPBookpostCommentReplyCellItem class]]) {
        ZCPBookpostCommentReplyCellItem *item = (ZCPBookpostCommentReplyCellItem *)object;
        self.receiverID = item.replyModel.user.userId;    // 暂存回复对应的用户ID
        // 显示评论视图
        [self.commentView showCommentView];
    }
}

#pragma mark - ZCPBookpostCommentReplyCellDelegate
/**
 *  点赞按钮点击事件
 */
- (void)bookpostCommentReplyCell:(ZCPBookpostCommentReplyCell *)cell supportButtonClicked:(UIButton *)button {
    ZCPBookpostCommentReplyCellItem *replyItem = cell.item;
    
    [[ZCPRequestManager sharedInstance] changeBookpostCommentReplyCurrSupportState:replyItem.replyModel.supported currBookpostCommentReplyID:replyItem.replyModel.replyId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            if (replyItem.replyModel.supported == ZCPCurrUserNotSupportBookpostCommentReply) {
                button.selected = YES;
                replyItem.replyModel.supported = ZCPCurrUserHaveSupportBookpostCommentReply;
                cell.item.replyModel.replySupport ++;
                
                TTDPRINT(@"点赞成功！");
                [MBProgressHUD showSuccess:@"点赞成功！"];
            }
            else if (replyItem.replyModel.supported == ZCPCurrUserHaveSupportBookpostCommentReply) {
                button.selected = NO;
                replyItem.replyModel.supported = ZCPCurrUserNotSupportBookpostCommentReply;
                cell.item.replyModel.replySupport --;
                
                TTDPRINT(@"取消点赞成功！");
                [MBProgressHUD showSuccess:@"取消点赞成功！"];
            }

            cell.supportNumberLabel.text = [NSString getFormateFromNumberOfPeople:cell.item.replyModel.replySupport];
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
    NSString *replyContent = keyboardResponder.text;
    if ([ZCPJudge judgeNullTextInput:replyContent showErrorMsg:@"回复不能为空！"]
        || [ZCPJudge judgeOutOfRangeTextInput:replyContent range:[ZCPLengthRange rangeWithMin:1 max:500] showErrorMsg:@"字数不得超过500字！"]) {
        return NO;
    }
    
    TTDPRINT(@"准备提交图书贴评论内容...");
    [[ZCPRequestManager sharedInstance] addBookpostCommentReplyWithBookpostCommentReplyContent:replyContent isReplyAuthor:NO bookpostCommentID:self.currCommentModel.commentId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId receiverID:self.receiverID success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            TTDPRINT(@"提交成功...");
            [MBProgressHUD showSuccess:@"添加回复成功！"];
            
            // 重新加载数据
            [self loadData];
        }
        else {
            TTDPRINT(@"提交失败...");
            [MBProgressHUD showError:@"添加回复失败！"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"提交失败...%@", error);
        [MBProgressHUD showError:@"添加回复失败！网络异常！"];
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
    [[ZCPRequestManager sharedInstance] getBookpostCommentReplyListWithBookpostCommentID:self.currCommentModel.commentId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:BOOKPOST_COMMENT_REPLY_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *replyListModel) {
        STRONG_SELF;
        if ([replyListModel isKindOfClass:[ZCPListDataModel class]] && replyListModel.items) {
            weakSelf.replyArray  = [NSMutableArray arrayWithArray:replyListModel.items];
            
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
    [[ZCPRequestManager sharedInstance] getBookpostCommentReplyListWithBookpostCommentID:self.currCommentModel.commentId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination + 1 pageCount:BOOKPOST_COMMENT_REPLY_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *replyListModel) {
        STRONG_SELF;
        if ([replyListModel isKindOfClass:[ZCPListDataModel class]] && replyListModel.items) {
            [weakSelf.replyArray addObjectsFromArray:replyListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
            // 如果获取到数据了，那么页数+1
            if (replyListModel.items.count > 0) {
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
 *  加载观点评论回复数据
 */
- (void)loadData {
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getBookpostCommentReplyListWithBookpostCommentID:self.currCommentModel.commentId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:BOOKPOST_COMMENT_REPLY_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *replyListModel) {
        STRONG_SELF;
        if ([replyListModel isKindOfClass:[ZCPListDataModel class]] && replyListModel.items) {
            weakSelf.replyArray = [NSMutableArray arrayWithArray:replyListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
    }];
}

#pragma mark - Button Clicked
- (void)addReply {
    // 跳转到添加回复视图控制器
    [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_COMMUNION_ADDBOOKPOSTCOMMENTREPLY paramDictForInit:@{@"_currCommentModel": self.currCommentModel}];
}

@end
