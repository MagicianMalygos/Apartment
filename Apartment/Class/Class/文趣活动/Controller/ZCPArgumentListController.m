//
//  ZCPArgumentListController.m
//  Apartment
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPArgumentListController.h"

#import "ZCPArgumentModel.h"
#import "ZCPArgumentCell.h"
#import "ZCPRequestManager+Thesis.h"

#define ARGUMENT_PAGE_COUNT        PAGE_COUNT_DEFAULT

@interface ZCPArgumentListController () <ZCPArgumentCellDelegate>

@property (nonatomic, assign) ZCPArgumentBelong argumentBelong;     // 正反方
@property (nonatomic, strong) NSMutableArray *argumentArr;          // 论据数组

@end

@implementation ZCPArgumentListController

@synthesize argumentBelong = _argumentBelong;
@synthesize argumentArr = _argumentArr;

#pragma mark - init
- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        _argumentBelong = [(NSNumber *)[params objectForKey:@"_argumentBelong"] boolValue];
    }
    return self;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 从网络获取数据
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getArgumentListWithBelong:self.argumentBelong currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pageCount:ARGUMENT_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *argumentListModel) {
        STRONG_SELF;
        if ([argumentListModel isKindOfClass:[ZCPListDataModel class]] && argumentListModel.items) {
            weakSelf.argumentArr = [NSMutableArray arrayWithArray:argumentListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
    }];
    
    // 初始化上拉下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = self.argumentBelong == ZCPProsArgument? @"正方论据": @"反方论据";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar);
}

#pragma mark - Construct Data
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    for (ZCPArgumentModel *model in self.argumentArr) {
        ZCPArgumentCellItem *argumentItem = [[ZCPArgumentCellItem alloc] initWithDefault];
        argumentItem.argumentID = model.argumentId;
        argumentItem.argumentBelong = model.argumentBelong;
        argumentItem.userHeadImgURL = model.user.userFaceURL;
        argumentItem.userName = model.user.userName;
        argumentItem.argumentContent = model.argumentContent;
        argumentItem.time = model.argumentTime;
        argumentItem.supportNumber = model.argumentSupport;
        argumentItem.argumentSupported = model.supported;
        argumentItem.delegate = self;
        [items addObject:argumentItem];
    }
    
    self.tableViewAdaptor.items = items;
}

#pragma mark - ZCPArgumentCellDelegate
/**
 *  点赞按钮响应事件
 */
- (void)argumentCell:(ZCPArgumentCell *)cell supportButtonClicked:(UIButton *)button {
    [[ZCPRequestManager sharedInstance] changeArgumentCurrSupportedState:cell.item.argumentSupported currArgumentID:cell.item.argumentID currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            if (cell.item.argumentSupported == ZCPCurrUserNotSupportArgument) {
                button.selected = YES;
                cell.item.argumentSupported = ZCPCurrUserHaveSupportArgument;
                cell.item.supportNumber = cell.item.supportNumber + 1;
                cell.supportNumberLabel.text = [NSString stringWithFormat:@"%li 人点赞", cell.item.supportNumber];
                
                TTDPRINT(@"点赞成功！");
                [MBProgressHUD showSuccess:@"点赞成功！" toView:self.view];
            }
            else if (cell.item.argumentSupported == ZCPCurrUserHaveSupportArgument) {
                button.selected = NO;
                cell.item.argumentSupported = ZCPCurrUserNotSupportArgument;
                cell.item.supportNumber = cell.item.supportNumber - 1;
                cell.supportNumberLabel.text = [NSString stringWithFormat:@"%li 人点赞", cell.item.supportNumber];
                
                TTDPRINT(@"取消点赞成功！");
                [MBProgressHUD showSuccess:@"取消点赞成功！" toView:self.view];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"操作失败！%@", error);
        [MBProgressHUD showSuccess:@"操作失败！网络异常！" toView:self.view];
    }];
}

#pragma mark - Refresh Method
/**
 *  下拉刷新
 */
- (void)headerRefresh {
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getArgumentListWithBelong:self.argumentBelong currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pageCount:ARGUMENT_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *argumentListModel) {
        STRONG_SELF;
        if ([argumentListModel isKindOfClass:[ZCPListDataModel class]] && argumentListModel.items) {
            weakSelf.argumentArr = [NSMutableArray arrayWithArray:argumentListModel.items];
            
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
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getOldArgumentListWithBelong:self.argumentBelong oldArgumentID:((ZCPArgumentModel *)[self.argumentArr lastObject]).argumentId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pageCount:ARGUMENT_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *argumentListModel) {
        STRONG_SELF;
        if ([argumentListModel isKindOfClass:[ZCPListDataModel class]] && argumentListModel.items) {
            [weakSelf.argumentArr addObjectsFromArray:argumentListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

@end
