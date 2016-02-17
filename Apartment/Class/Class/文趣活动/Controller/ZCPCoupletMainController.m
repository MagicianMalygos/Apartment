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

@synthesize coupletModelArr = _coupletModelArr;

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    self.sortMethodFlag = ZCPCoupletSortByTime;
    self.pagination = 1;
    
    // 从网络获取数据
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getCoupletListByTimeWithPageCount:COUPLET_LIST_PAGE_COUNT currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *coupletListModel) {
        STRONG_SELF;
        if ([coupletListModel isKindOfClass:[ZCPListDataModel class]]) {
            weakSelf.coupletModelArr = [NSMutableArray arrayWithArray:coupletListModel.items];
            
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
        ZCPCoupletMainCellItem *coupletItem = [[ZCPCoupletMainCellItem alloc] initWithDefault];
        coupletItem.userHeadImageURL = model.user.userFaceURL;
        coupletItem.userName = model.user.userName;
        coupletItem.coupletContent = model.coupletContent;
        coupletItem.time = model.coupletTime;
        coupletItem.supportNumber = model.coupletSupport;
        coupletItem.replyNumber = model.coupletReplyNumber;
        [items addObject:coupletItem];
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
            self.sortMethodFlag = ZCPCoupletSortByTime;
            // 获取按时间排序的对联数组
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getCoupletListByTimeWithPageCount:COUPLET_LIST_PAGE_COUNT currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *coupletListModel) {
                STRONG_SELF;
                if ([coupletListModel isKindOfClass:[ZCPListDataModel class]]) {
                    weakSelf.coupletModelArr = [NSMutableArray arrayWithArray:coupletListModel.items];
                    
                    // 重新构造并加载数据
                    [self constructData];
                    [weakSelf.tableView reloadData];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
            }];
            break;
        }
        case 1: {
            self.sortMethodFlag = ZCPCoupletSortBySupport;
            // 获取按点赞量排序的对联数组
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getCoupletListBySupportWithPageCount:COUPLET_LIST_PAGE_COUNT currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *coupletListModel) {
                STRONG_SELF;
                if ([coupletListModel isKindOfClass:[ZCPListDataModel class]]) {
                    weakSelf.coupletModelArr = [NSMutableArray arrayWithArray:coupletListModel.items];
                    
                    // 重新构造并加载数据
                    [self constructData];
                    [weakSelf.tableView reloadData];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error  ) {
                TTDPRINT(@"%@", error);
            }];
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

#pragma mark - Private Method
- (void)headerRefresh {
    WEAK_SELF;
    if (self.sortMethodFlag == ZCPCoupletSortByTime) {
        [[ZCPRequestManager sharedInstance] getCoupletListByTimeWithPageCount:COUPLET_LIST_PAGE_COUNT
                                                                   currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId
                                                                      success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *coupletListModel) {
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
    else if (self.sortMethodFlag == ZCPCoupletSortBySupport){
        [[ZCPRequestManager sharedInstance] getCoupletListBySupportWithPageCount:COUPLET_LIST_PAGE_COUNT currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *coupletListModel) {
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
    self.pagination = 1;    // 下拉刷新初始化页码
}
- (void)footerRefresh {
    WEAK_SELF;
    if (self.sortMethodFlag == ZCPCoupletSortByTime) {
        [[ZCPRequestManager sharedInstance] getOldCoupletListByTimeWithPageCount:COUPLET_LIST_PAGE_COUNT oldCoupletID:((ZCPCoupletModel *)[self.coupletModelArr lastObject]).coupletId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *coupletListModel) {
            STRONG_SELF;
            if ([coupletListModel isKindOfClass:[ZCPListDataModel class]]) {
                [weakSelf.coupletModelArr addObjectsFromArray:coupletListModel.items];
                
                // 重新构造并加载数据
                [self constructData];
                [weakSelf.tableView reloadData];
            }
            [weakSelf.tableView.mj_footer endRefreshing];
            weakSelf.pagination ++;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            TTDPRINT(@"%@", error);
            [weakSelf.tableView.mj_footer endRefreshing];
        }];
    }
    else if (self.sortMethodFlag == ZCPCoupletSortBySupport){
        [[ZCPRequestManager sharedInstance] getCoupletListBySupportWithPageCount:((self.pagination + 1) * COUPLET_LIST_PAGE_COUNT) currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *coupletListModel) {
            STRONG_SELF;
            if ([coupletListModel isKindOfClass:[ZCPListDataModel class]]) {
                weakSelf.coupletModelArr = [NSMutableArray arrayWithArray:coupletListModel.items];
                
                // 重新构造并加载数据
                [self constructData];
                [weakSelf.tableView reloadData];
            }
            [weakSelf.tableView.mj_footer endRefreshing];
            weakSelf.pagination ++;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            TTDPRINT(@"%@", error);
            [weakSelf.tableView.mj_footer endRefreshing];
        }];
    }
}

@end
