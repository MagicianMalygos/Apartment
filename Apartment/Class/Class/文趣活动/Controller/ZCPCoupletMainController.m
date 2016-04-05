//
//  ZCPCoupletMainController.m
//  Apartment
//
//  Created by apple on 16/1/21.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPCoupletMainController.h"

#import "ZCPOptionCell.h"
#import "ZCPCoupletMainCell.h"
#import "ZCPCoupletModel.h"
#import "ZCPRequestManager+Couplet.h"
#import "ZCPCoupletDetailController.h"

#define OptionHeight                35.0f
#define COUPLET_LIST_PAGE_COUNT     PAGE_COUNT_DEFAULT


@interface ZCPCoupletMainController () <ZCPOptionViewDelegate, ZCPListTableViewAdaptorDelegate>

@property (nonatomic, strong) NSMutableArray *coupletModelArr;      // 对联模型数组
@property (nonatomic, assign) ZCPCoupletSortMethod sortMethodFlag;  // 标记当前是以何种方式排序
@property (assign, nonatomic) int pagination;                       // 页码

@end

@implementation ZCPCoupletMainController

#pragma mark - synthesize
@synthesize coupletModelArr     = _coupletModelArr;
@synthesize sortMethodFlag      = _sortMethodFlag;
@synthesize pagination          = _pagination;

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    self.sortMethodFlag = ZCPCoupletSortByTime;
    self.pagination = 1;
    
    // 加载数据
    [self loadData];
    
    // 初始化上拉下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar - Height_TABBAR - OptionHeight);
}

#pragma mark - Construct Data
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    // 选项视图cell
    ZCPOptionCellItem *optionItem = [[ZCPOptionCellItem alloc] initWithDefault];
    optionItem.cellHeight = @OptionHeight;
    optionItem.delegate = self;
    optionItem.attributedStringArr = @[[[NSAttributedString alloc] initWithString:@"按时间排序"
                                                                       attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]}]
                                       ,[[NSAttributedString alloc] initWithString:@"按点赞量排序"
                                                                        attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]}]
                                       ,[[NSAttributedString alloc] initWithString:@"写对联"
                                                                        attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]}]];
    [items addObject:optionItem];
    
    // 对联列表cell
    for (ZCPCoupletModel *model in self.coupletModelArr) {
        model.cellClass = [ZCPCoupletMainCell class];
        model.cellType = [ZCPCoupletMainCell cellIdentifier];
        [items addObject:model];
    }

    self.tableViewAdaptor.items = items;
}

#pragma mark - ZCPListTableViewAdaptor Delegate
/**
 *  cell点击事件
 *
 *  @param tableView cell所属的tableview
 *  @param object    cellItem
 *  @param indexPath cell索引
 */
- (void)tableView:(UITableView *)tableView didSelectObject:(id<ZCPTableViewCellItemBasicProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    // 跳转到对联详情界面，并进行nil值判断
    ZCPCoupletModel *selectedCoupletModel = [self.coupletModelArr objectAtIndex:indexPath.row - 1/*减去optionCell*/];
    [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_COUPLET_DETAIL paramDictForInit:@{@"_selectedCoupletModel": (selectedCoupletModel != nil)? selectedCoupletModel: [NSNull null]}];
}

#pragma mark - ZCPOptionView Delegate
/**
 *  label点击事件
 *
 *  @param label 被点击的label
 *  @param index 被点击的label下标
 */
- (void)label:(UILabel *)label didSelectedAtIndex:(NSInteger)index {
    
    switch (index) {
        case 0: {
            // 初始化
            self.sortMethodFlag = ZCPCoupletSortByTime;
            self.pagination = 1;
            
            // 加载数据
            [self loadData];
            break;
        }
        case 1: {
            // 初始化
            self.sortMethodFlag = ZCPCoupletSortBySupport;
            self.pagination = 1;
            
            // 加载数据
            [self loadData];
            break;
        }
        case 2:
            // 跳转到添加对联页面
            [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_COUPLET_ADD paramDictForInit:nil];
            break;
        default:
            break;
    }
}

#pragma mark - Load Data
- (void)headerRefresh {
    // 下拉刷新时初始化页码
    self.pagination = 1;
    
    // 开始加载数据
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getCoupletListWithSortMethod:self.sortMethodFlag currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:COUPLET_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *coupletListModel) {
        STRONG_SELF;
        if ([coupletListModel isKindOfClass:[ZCPListDataModel class]]) {
            weakSelf.coupletModelArr = [NSMutableArray arrayWithArray:coupletListModel.items];
            
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
    // 开始加载数据
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getCoupletListWithSortMethod:self.sortMethodFlag currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination + 1 pageCount:COUPLET_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *coupletListModel) {
        STRONG_SELF;
        if ([coupletListModel isKindOfClass:[ZCPListDataModel class]]) {
            [weakSelf.coupletModelArr addObjectsFromArray:coupletListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
            // 如果获取到数据了，那么页数+1
            if (coupletListModel.items.count > 0) {
                self.pagination ++;
            }
        }
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

// 加载数据
- (void)loadData {
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getCoupletListWithSortMethod:self.sortMethodFlag currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:COUPLET_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *coupletListModel) {
        STRONG_SELF;
        if ([coupletListModel isKindOfClass:[ZCPListDataModel class]] && coupletListModel.items) {
            weakSelf.coupletModelArr = [NSMutableArray arrayWithArray:coupletListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
    }];
}

@end
