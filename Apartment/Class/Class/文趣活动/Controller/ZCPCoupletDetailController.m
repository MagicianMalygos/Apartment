//
//  ZCPCoupletDetailController.m
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPCoupletDetailController.h"

#import "ZCPCoupletModel.h"
#import "ZCPCoupletDetailCell.h"
#import "ZCPCoupletReplyCell.h"
#import "ZCPCoupletReplyModel.h"
#import "ZCPSectionCell.h"
#import "ZCPRequestManager+Couplet.h"
#import "ZCPCommentView.h"

#define COUPLET_REPLY_PAGE_COUNT        PAGE_COUNT_DEFAULT

@interface ZCPCoupletDetailController () <ZCPCoupletDetailCellDelegate, ZCPCoupletReplyCellDelegate, ZCPCommentViewDelegate>

@property (nonatomic, strong) ZCPCommentView *commentView;                  // 评论视图
@property (nonatomic, strong) ZCPCoupletModel *selectedCoupletModel;        // 当前对联模型
@property (nonatomic, strong) NSMutableArray *coupletReplyModelArr;         // 对联回复模型数组
@property (assign, nonatomic) int pagination;                               // 页码

@end

@implementation ZCPCoupletDetailController

#pragma mark - synthesize
@synthesize commentView             = _commentView;
@synthesize selectedCoupletModel    = _selectedCoupletModel;
@synthesize coupletReplyModelArr    = _coupletReplyModelArr;
@synthesize pagination              = _pagination;

#pragma mark - init
- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        self.selectedCoupletModel = [params objectForKey:@"_selectedCoupletModel"];
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
    
    // 添加上拉下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"对联详情";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar);
}

#pragma mark - Construct Data
// 构造cellitem
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    // Couplet Detail
    ZCPCoupletDetailCellItem *detailItem = [[ZCPCoupletDetailCellItem alloc] initWithDefault];
    detailItem.coupletContent = self.selectedCoupletModel.coupletContent;
    detailItem.userHeadImageURL = self.selectedCoupletModel.user.userFaceURL;
    detailItem.userName = self.selectedCoupletModel.user.userName;
    detailItem.time = self.selectedCoupletModel.coupletTime;
    detailItem.coupletSupported = self.selectedCoupletModel.supported;
    detailItem.coupletCollected = self.selectedCoupletModel.collected;
    detailItem.delegate = self;
    [items addObject:detailItem];

    ZCPSectionCellItem * section = [[ZCPSectionCellItem alloc] initWithDefault];
    section.cellHeight = @20;
    section.sectionTitle = @"评论";
    [items addObject:section];
    
    for (ZCPCoupletReplyModel *model in self.coupletReplyModelArr) {
        ZCPCoupletReplyCellItem * replyItem = [[ZCPCoupletReplyCellItem alloc] initWithDefault];
        replyItem.replyId = model.replyId;
        replyItem.replyContent = model.replyContent;
        replyItem.userHeadImageURL = model.user.userFaceURL;
        replyItem.userName = model.user.userName;
        replyItem.replyTime = model.replyTime;
        replyItem.replySupportNumber = model.replySupport;
        replyItem.replySupported = model.supported;
        replyItem.delegate = self;
        [items addObject:replyItem];
    }
    
    self.tableViewAdaptor.items = items;
}

#pragma mark - ZCPCoupletDetailCellDelegate
/**
 *  评论按钮点击事件
 */
- (void)coupletDetailCell:(ZCPCoupletDetailCell *)cell commentButtonClicked:(UIButton *)button {
    [self.commentView showCommentView];
}
/**
 *  收藏按钮点击事件
 */
- (void)coupletDetailCell:(ZCPCoupletDetailCell *)cell collectButtonClicked:(UIButton *)button {
    
    [[ZCPRequestManager sharedInstance] changeCoupletCurrCollectionState:self.selectedCoupletModel.collected currCoupletID:self.selectedCoupletModel.coupletId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            if (self.selectedCoupletModel.collected == ZCPCurrUserHaveCollectCouplet) {
                // 取消收藏成功，取消按钮高亮显示
                button.selected = NO;
                // 设置“是否已收藏”属性为“0”——“未收藏”
                self.selectedCoupletModel.collected = ZCPCurrUserNotCollectCouplet;
                
                TTDPRINT(@"取消收藏成功！");
                [MBProgressHUD showSuccess:@"取消收藏成功！" toView:self.view];
            }
            else {
                // 收藏成功，设置按钮高亮显示
                button.selected = YES;
                // 设置“是否已收藏”属性为“1”——“已收藏”
                self.selectedCoupletModel.collected = ZCPCurrUserHaveCollectCouplet;
                
                TTDPRINT(@"收藏成功！");
                [MBProgressHUD showSuccess:@"收藏成功！" toView:self.view];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"操作失败！%@", error);
        [MBProgressHUD showSuccess:@"操作失败！网络异常" toView:self.view];
    }];
}
/**
 *  点赞按钮点击事件
 */
- (void)coupletDetailCell:(ZCPCoupletDetailCell *)cell supportButtonClicked:(UIButton *)button {
    [[ZCPRequestManager sharedInstance] changeCoupletCurrSupportState:self.selectedCoupletModel.supported currCoupletID:self.selectedCoupletModel.coupletId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            if (self.selectedCoupletModel.supported == ZCPCurrUserNotSupportCouplet) {
                button.selected = YES;
                self.selectedCoupletModel.supported = ZCPCurrUserHaveSupportCouplet;
                
                TTDPRINT(@"点赞成功！");
                [MBProgressHUD showSuccess:@"点赞成功！" toView:self.view];
            }
            else if (self.selectedCoupletModel.supported == ZCPCurrUserHaveSupportCouplet) {
                button.selected = NO;
                self.selectedCoupletModel.supported = ZCPCurrUserNotSupportCouplet;
                
                TTDPRINT(@"取消点赞成功！");
                [MBProgressHUD showSuccess:@"取消点赞成功！" toView:self.view];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"操作失败！%@", error);
        [MBProgressHUD showSuccess:@"操作失败！网络异常！" toView:self.view];
    }];
}

#pragma mark - ZCPCoupletReplyCellDelegate
/**
 *  coupletReply点赞按钮
 */
- (void)coupletReplyCell:(ZCPCoupletReplyCell *)cell supportButtonClicked:(UIButton *)button {
    
    ZCPCoupletReplyCellItem *replyItem = cell.item;
    
    [[ZCPRequestManager sharedInstance] changeCoupletReplyCurrSupportState:replyItem.replySupported currCoupletReplyID:replyItem.replyId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            if (replyItem.replySupported == ZCPCurrUserNotSupportCoupletReply) {
                button.selected = YES;
                replyItem.replySupported = ZCPCurrUserHaveSupportCoupletReply;
                cell.item.replySupportNumber = cell.item.replySupportNumber + 1;
                cell.replySupportLabel.text = [NSString stringWithFormat:@"%li", cell.item.replySupportNumber];
                
                TTDPRINT(@"点赞成功！");
                [MBProgressHUD showSuccess:@"点赞成功！" toView:self.view];
            }
            else if (replyItem.replySupported == ZCPCurrUserHaveSupportCoupletReply) {
                button.selected = NO;
                replyItem.replySupported = ZCPCurrUserNotSupportCoupletReply;
                cell.item.replySupportNumber = cell.item.replySupportNumber - 1;
                cell.replySupportLabel.text = [NSString stringWithFormat:@"%li", cell.item.replySupportNumber];
                
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
 *  return键响应方法，提交对联回复的方法
 *
 *  @param keyboardResponder 文本输入框
 *
 *  @return 是否隐藏键盘
 */
- (BOOL)textInputShouldReturn:(ZCPTextView *)keyboardResponder {
    
    // 获取文本输入框内容并进行非法性判断
    NSString *coupletReplyContent = keyboardResponder.text;
    if ([ZCPJudge judgeNullTextInput:coupletReplyContent showErrorMsg:@"评论不能为空！"]
        || [ZCPJudge judgeOutOfRangeTextInput:coupletReplyContent range:[ZCPLengthRange rangeWithMin:1 max:50] showErrorMsg:@"字数不得超过50字！"]) {
        return NO;
    }
    
    TTDPRINT(@"准备提交对联回复内容...");
    [[ZCPRequestManager sharedInstance] addCoupletReplyContent:coupletReplyContent currCoupletID:self.selectedCoupletModel.coupletId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
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

#pragma mark - Load Data
/**
 *  上拉刷新
 */
- (void)headerRefresh {
    self.pagination = 1;
    
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getCoupletReplyListWithCurrCoupletID:self.selectedCoupletModel.coupletId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:1 pageCount:COUPLET_REPLY_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *coupletReplyListModel) {
        STRONG_SELF;
        if ([coupletReplyListModel isKindOfClass:[ZCPListDataModel class]] && coupletReplyListModel.items) {
            weakSelf.coupletReplyModelArr = [NSMutableArray arrayWithArray:coupletReplyListModel.items];
            
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
 *  下拉刷新
 */
- (void)footerRefresh {
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getCoupletReplyListWithCurrCoupletID:self.selectedCoupletModel.coupletId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination + 1 pageCount:COUPLET_REPLY_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *coupletReplyListModel) {
        STRONG_SELF;
        if ([coupletReplyListModel isKindOfClass:[ZCPListDataModel class]] && coupletReplyListModel.items) {
            [weakSelf.coupletReplyModelArr addObjectsFromArray:coupletReplyListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
            // 如果获取到数据了，那么页数+1
            if (coupletReplyListModel.items.count > 0) {
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
    [[ZCPRequestManager sharedInstance] getCoupletReplyListWithCurrCoupletID:self.selectedCoupletModel.coupletId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:1 pageCount:COUPLET_REPLY_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *coupletReplyListModel) {
        STRONG_SELF;
        if ([coupletReplyListModel isKindOfClass:[ZCPListDataModel class]] && coupletReplyListModel.items) {
            weakSelf.coupletReplyModelArr = [NSMutableArray arrayWithArray:coupletReplyListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
    }];
}

@end
