//
//  ZCPMainHotTrendController.m
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPMainHotTrendController.h"
#import "ZCPImageCircleView.h"
#import "ZCPTextView.h"
#import "ZCPCommentView.h"
#import "ZCPBookPostModel.h"
#import "ZCPBookPostCell.h"
#import "ZCPRequestManager+HotTrend.h"

@interface ZCPMainHotTrendController () <ZCPImageCircleViewDelegate>

@property (nonatomic, strong) ZCPImageCircleView *imageCircleView;  // 图片轮播视图
@property (nonatomic, strong) NSMutableArray *hotBookpostArr;       // 热门图书贴信息
@property (nonatomic, assign) NSInteger pagination;                 // 页码

@end

@implementation ZCPMainHotTrendController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    self.pagination = 1;
    
    // 设置图片轮播视图
    [self.view addSubview:self.imageCircleView];
    
    // 加载数据
    [self loadData];
    
    // 初始化上拉下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self clearNavigationBar];
    self.tabBarController.title = @"热门动态";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 150, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar - Height_TABBAR - 150);
}

#pragma mark - construct data
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    for (ZCPBookPostModel *model in self.hotBookpostArr) {
        model.cellClass = [ZCPBookPostCell class];
        model.cellType = [ZCPBookPostCell cellIdentifier];
        
        [items addObject:model];
    }
    self.tableViewAdaptor.items = items;
}

#pragma mark - getter / setter
- (ZCPImageCircleView *)imageCircleView {
    if (_imageCircleView == nil) {
        _imageCircleView = [[ZCPImageCircleView alloc] initWithFrame:({
            CGRectMake(0, 0, APPLICATIONWIDTH, 150);
        })];
        
        NSArray *imageArray = @[advertisementGetURL(@"couplet_ad.png")
                                , advertisementGetURL(@"thesis_ad.png")
                                , advertisementGetURL(@"question_ad.png")
                                , advertisementGetURL(@"book_ad.png")];
        self.imageCircleView.imageNameArray = imageArray;
        self.imageCircleView.delegate = self;
    }
    return _imageCircleView;
}

#pragma mark - ZCPImageCircleViewDelegate
- (void)pageView:(ZCPImageCircleView *)imageCircleView didSelectedPageAtIndex:(NSUInteger)index {
    NSLog(@"%li", index);
    switch (index) {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        default:
            break;
    }
}


#pragma mark - Load Data
/**
 *  下拉刷新
 */
- (void)headerRefresh {
    self.pagination = 1;
    
    // 获取数据
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getHotBookpostListWithCurrUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel) {
        STRONG_SELF;
        if ([bookpostListModel isKindOfClass:[ZCPListDataModel class]] && bookpostListModel.items) {
            weakSelf.hotBookpostArr = [NSMutableArray arrayWithArray:bookpostListModel.items];
            
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
    [[ZCPRequestManager sharedInstance] getHotBookpostListWithCurrUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination + 1 pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel) {
        STRONG_SELF;
        if ([bookpostListModel isKindOfClass:[ZCPListDataModel class]] && bookpostListModel.items) {
            [weakSelf.hotBookpostArr addObjectsFromArray:bookpostListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
            // 如果获取到数据了，那么页数+1
            if (bookpostListModel.items.count > 0) {
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
    [[ZCPRequestManager sharedInstance] getHotBookpostListWithCurrUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel) {
        STRONG_SELF;
        if ([bookpostListModel isKindOfClass:[ZCPListDataModel class]] && bookpostListModel.items) {
            weakSelf.hotBookpostArr = [NSMutableArray arrayWithArray:bookpostListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
    }];
}

@end