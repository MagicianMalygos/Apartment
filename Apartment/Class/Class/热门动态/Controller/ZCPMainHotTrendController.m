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
#import "ZCPHotBookpostCommentCell.h"
#import "ZCPMainActivityController.h"
#import "ZCPMainLibraryController.h"

@interface ZCPMainHotTrendController () <ZCPImageCircleViewDelegate, ZCPHotBookpostCommentCellDelegate>

@property (nonatomic, strong) ZCPImageCircleView *imageCircleView;      // 图片轮播视图
@property (nonatomic, strong) NSMutableArray *hotBookpostAndCommentArr; // 热门图书贴评论+图书贴信息
@property (nonatomic, assign) NSInteger pagination;                     // 页码
@property (nonatomic, strong) dispatch_source_t timerSource;            // 定时器

@end

@implementation ZCPMainHotTrendController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    self.pagination = 1;
    
    // 设置图片轮播视图
    [self.view addSubview:self.imageCircleView];
    // 初始化图片轮播视图后开启定时器
//    [self openTimer];
    
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
    
    // 设置主题颜色
    self.tableView.backgroundColor = APP_THEME_BG_COLOR;
    // 更新cell颜色
    [self constructData];
    [self.tableView reloadData];
    
    // 刷新广告
    [self reloadAd];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 150, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar - Height_TABBAR - 150);
}

#pragma mark - construct data
- (void)constructData {
    
    // 刷新广告
    [self reloadAd];
    
    NSMutableArray *items = [NSMutableArray array];
    
    for (ZCPBookPostCommentModel *model in self.hotBookpostAndCommentArr) {
        ZCPHotBookpostCommentCellItem *item = [[ZCPHotBookpostCommentCellItem alloc] initWithDefault];
        item.bpcModel = model;
        item.delegate = self;
        item.headImageViewConfigBlock = ^(UIImageView *imageView) {
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                // 跳转到用户信息详情
                [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_USER_INFO_DETAIL paramDictForInit:@{@"_currUserModel": model.user}];
            }]];
        };
        
        [items addObject:item];
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
        _imageCircleView.imageNameArray = imageArray;
        _imageCircleView.delegate = self;
    }
    return _imageCircleView;
}
- (NSMutableArray *)hotBookpostAndCommentArr {
    if (_hotBookpostAndCommentArr == nil) {
        _hotBookpostAndCommentArr = [NSMutableArray array];
    }
    return _hotBookpostAndCommentArr;
}

#pragma mark - ZCPImageCircleViewDelegate
- (void)pageView:(ZCPImageCircleView *)imageCircleView didSelectedPageAtIndex:(NSUInteger)index {
    // 获取到tabbar，准备在下面进行tab的切换
    ZCPTabBarController *tabBarController = (ZCPTabBarController *)self.navigationController.topViewController;
    
    switch (index) {
        case 0: {
            ZCPMainActivityController *activityVC = [tabBarController.viewControllers objectAtIndex:2];
            [activityVC switchActivityWithIndex:0];
            // 切换tab到对对联
            tabBarController.selectedViewController = activityVC;
            break;
        }
        case 1: {
            ZCPMainActivityController *activityVC = [tabBarController.viewControllers objectAtIndex:2];
            [activityVC switchActivityWithIndex:1];
            // 切换tab到对对联
            tabBarController.selectedViewController = activityVC;
            break;
        }
        case 2: {
            ZCPMainActivityController *activityVC = [tabBarController.viewControllers objectAtIndex:2];
            [activityVC switchActivityWithIndex:2];
            // 切换tab到对对联
            tabBarController.selectedViewController = activityVC;
            break;
        }
        case 3: {
            // 切换tab到图书馆
            tabBarController.selectedViewController = [tabBarController.viewControllers objectAtIndex:3];
            break;
        }
        default:
            break;
    }
}

#pragma mark - ZCPHotBookpostCommentCellDelegate
- (void)hotBookpostCommentCell:(ZCPHotBookpostCommentCell *)cell bpViewClicked:(ZCPBookPostModel *)bpModel {
    [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_COMMUNION_BOOKPOSTDETAIL paramDictForInit:@{@"_currentBookpostModel": bpModel}];
}
- (void)hotBookpostCommentCell:(ZCPHotBookpostCommentCell *)cell bpcViewClicked:(ZCPBookPostCommentModel *)bpcModel {
    [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_COMMUNION_BOOKPOSTCOMMENTDETAIL paramDictForInit:@{@"_currCommentModel": bpcModel}];
}

#pragma mark - Load Data
/**
 *  下拉刷新
 */
- (void)headerRefresh {
    self.pagination = 1;
    
    // 获取数据
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getHotBookpostCommentListWithCurrUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostCommentListModel) {
        STRONG_SELF;
        if ([bookpostCommentListModel isKindOfClass:[ZCPListDataModel class]] && bookpostCommentListModel.items) {
            weakSelf.hotBookpostAndCommentArr = [NSMutableArray arrayWithArray:bookpostCommentListModel.items];
            
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
    [[ZCPRequestManager sharedInstance] getHotBookpostCommentListWithCurrUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination + 1 pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostCommentListModel) {
        STRONG_SELF;
        if ([bookpostCommentListModel isKindOfClass:[ZCPListDataModel class]] && bookpostCommentListModel.items) {
            [weakSelf.hotBookpostAndCommentArr addObjectsFromArray:bookpostCommentListModel.items];
            
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
 *  加载数据
 */
- (void)loadData {
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getHotBookpostCommentListWithCurrUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostCommentListModel) {
        STRONG_SELF;
        if ([bookpostCommentListModel isKindOfClass:[ZCPListDataModel class]] && bookpostCommentListModel.items) {
            weakSelf.hotBookpostAndCommentArr = [NSMutableArray arrayWithArray:bookpostCommentListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
    }];
}

- (void)reloadAd {
    // 刷新广告图
    NSArray *imageArray = @[advertisementGetURL(@"couplet_ad.png")
                            , advertisementGetURL(@"thesis_ad.png")
                            , advertisementGetURL(@"question_ad.png")
                            , advertisementGetURL(@"book_ad.png")];
    self.imageCircleView.imageNameArray = imageArray;
}

#pragma mark - other method
- (void)openTimer {
    /// 初始化一个gcd队列.
    dispatch_queue_t timerQueue = dispatch_queue_create("timerQueue", 0);
    
    /// 创建 gcd timer.
    _timerSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, timerQueue);
    double interval = 2 * NSEC_PER_SEC; /// 间隔2秒
    dispatch_source_set_timer(_timerSource, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
    
    WEAK_SELF;
    /// 定时器block设置
    dispatch_source_set_event_handler(_timerSource, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            // 切换banner图片
            [weakSelf.imageCircleView changeImageAtIndex:weakSelf.imageCircleView.currentPage + 1];
        });
    });
    
    /// 唤起定时器任务.
    dispatch_resume(_timerSource);
}

@end