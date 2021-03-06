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
@property (assign, nonatomic) int pagination;                       // 页码

@end

@implementation ZCPArgumentListController

#pragma mark - synthesize
@synthesize argumentBelong  = _argumentBelong;
@synthesize argumentArr     = _argumentArr;
@synthesize pagination      = _pagination;

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
    
    // 初始化
    self.pagination = 1;
    
    // 加载数据
    [self loadData];
    
    // 初始化上拉下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = self.argumentBelong == ZCPProsArgument? @"正方论据": @"反方论据";
    
    // 设置主题颜色
    self.tableView.backgroundColor = APP_THEME_BG_COLOR;
    // 更新cell颜色
    [self constructData];
    [self.tableView reloadData];
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
        argumentItem.argumentModel = model;
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
    [[ZCPRequestManager sharedInstance] changeArgumentCurrSupportedState:cell.item.argumentModel.supported currArgumentID:cell.item.argumentModel.argumentId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            if (cell.item.argumentModel.supported == ZCPCurrUserNotSupportArgument) {
                button.selected = YES;
                cell.item.argumentModel.supported = ZCPCurrUserHaveSupportArgument;
                cell.item.argumentModel.argumentSupport ++;
                
                TTDPRINT(@"点赞成功！");
                [MBProgressHUD showSuccess:@"点赞成功！" toView:self.view];
            }
            else if (cell.item.argumentModel.supported == ZCPCurrUserHaveSupportArgument) {
                button.selected = NO;
                cell.item.argumentModel.supported = ZCPCurrUserNotSupportArgument;
                cell.item.argumentModel.argumentSupport --;
                
                TTDPRINT(@"取消点赞成功！");
                [MBProgressHUD showSuccess:@"取消点赞成功！" toView:self.view];
            }
            cell.supportNumberLabel.text = [NSString getFormateFromNumberOfPeople:cell.item.argumentModel.argumentSupport];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"操作失败！%@", error);
        [MBProgressHUD showSuccess:@"操作失败！网络异常！" toView:self.view];
    }];
}

#pragma mark - Load Data
/**
 *  下拉刷新
 */
- (void)headerRefresh {
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getArgumentListWithBelong:self.argumentBelong currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:1 pageCount:ARGUMENT_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *argumentListModel) {
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
    [[ZCPRequestManager sharedInstance] getArgumentListWithBelong:self.argumentBelong currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination + 1 pageCount:ARGUMENT_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *argumentListModel) {
        STRONG_SELF;
        if ([argumentListModel isKindOfClass:[ZCPListDataModel class]] && argumentListModel.items) {
            [weakSelf.argumentArr addObjectsFromArray:argumentListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
            // 如果获取到数据了，那么页数+1
            if (argumentListModel.items.count > 0) {
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
    [[ZCPRequestManager sharedInstance] getArgumentListWithBelong:self.argumentBelong currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:1 pageCount:ARGUMENT_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *argumentListModel) {
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
}

@end
