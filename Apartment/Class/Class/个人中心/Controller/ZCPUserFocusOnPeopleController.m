//
//  ZCPUserFocusOnPeopleController.m
//  Apartment
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPUserFocusOnPeopleController.h"
#import "ZCPImageTextCell.h"
#import "ZCPRequestManager+User.h"

#define USER_LIST_PAGE_COUNT     PAGE_COUNT_DEFAULT

@interface ZCPUserFocusOnPeopleController() <ZCPImageTextButtonCellItemDelegate>

@property (nonatomic, assign) NSInteger currUserID;                 // 用户ID
@property (nonatomic, strong) NSMutableArray *collectedUserArray;   // 被关注人数组
@property (nonatomic, assign) NSUInteger pagination;                // 页码

@end

@implementation ZCPUserFocusOnPeopleController

#pragma mark - synthesize
@synthesize currUserID          = _currUserID;
@synthesize collectedUserArray  = _collectedUserArray;
@synthesize pagination          = _pagination;

#pragma mark - init
- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super initWithParams:params]) {
        _currUserID = [[params valueForKey:@"_currUserID"] integerValue];
    }
    return self;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pagination = 1;
    
    // 加载数据
    [self loadData];
    
    // 初始化上拉下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 设置nav
    [self clearNavigationBar];
    self.title = @"全部关注";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar);
    
    // 设置主题颜色
    if ([ZCPControlingCenter sharedInstance].appTheme == LightTheme) {
        [self.tableView setBackgroundColor:LIGHT_BG_COLOR];
    }
    else if([ZCPControlingCenter sharedInstance].appTheme == DarkTheme) {
        [self.tableView setBackgroundColor:NIGHT_BG_COLOR];
    }
}

#pragma mark - constructData
- (void)constructData {
    
    // 文字主题颜色
    UIColor *textColor = ([ZCPControlingCenter sharedInstance].appTheme == LightTheme)?[UIColor blackColor]:[UIColor whiteColor];
    
    NSMutableArray *items = [NSMutableArray array];
    
    for (ZCPUserModel *model in self.collectedUserArray) {
        ZCPImageTextButtonCellItem *item = [[ZCPImageTextButtonCellItem alloc] initWithDefault];
        item.delegate = self;
        item.imageName = model.userFaceURL;
        item.tagInfo = @(model.userId);
        item.text = [[NSMutableAttributedString alloc] initWithString:model.userName attributes:@{NSForegroundColorAttributeName: textColor}];
        item.buttonConfigBlock = ^(UIButton *button) {
            
            // 如果该记录用户为当前登陆用户
            if ([ZCPUserCenter sharedInstance].currentUserModel.userId == [(NSNumber *)item.tagInfo integerValue]) {
                button.hidden = YES;
                return;
            }
            // 设置为不可用
            button.backgroundColor = [UIColor buttonDefaultColor];
            [button setTitle:@"关注" forState:UIControlStateNormal];
            button.enabled = NO;
            
            [[ZCPRequestManager sharedInstance] judgeUserCollectOtherUserID:model.userId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
                
                button.enabled = YES;
                
                if (isSuccess) {
                    // 已收藏时
                    [button setTitle:@"取消关注" forState:UIControlStateNormal];
                } else {
                    // 未收藏时
                    [button setTitle:@"关注" forState:UIControlStateNormal];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
            }];
        };
        [items addObject:item];
    }
    
    self.tableViewAdaptor.items = items;
}

#pragma mark - getter / setter
- (NSMutableArray *)collectedUserArray {
    if (_collectedUserArray == nil) {
        _collectedUserArray = [NSMutableArray array];
    }
    return _collectedUserArray;
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
    // 跳转到用户信息详情
    [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_USER_INFO_DETAIL paramDictForInit:@{@"_currUserModel": [self.collectedUserArray objectAtIndex:indexPath.row]}];
}
#pragma mark - ZCPImageTextButtonCellItemDelegate
- (void)cell:(ZCPImageTextButtonCell *)cell buttonClicked:(UIButton *)button {
    
    ZCPImageTextButtonCellItem *item = (ZCPImageTextButtonCellItem *)cell.item;
    
    // 关注 / 取消关注
    if ([button.titleLabel.text isEqualToString:@"关注"] || [button.titleLabel.text isEqualToString:@"取消关注"]) {
        BOOL currCollected = [button.titleLabel.text isEqualToString:@"关注"]? NO: YES;
        
        WEAK_SELF;
        [[ZCPRequestManager sharedInstance] changeCollectedUserCurrCollectionState:currCollected collectedUserID:[(NSNumber *)item.tagInfo integerValue] currUserID:weakSelf.currUserID success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
            if (isSuccess) {
                if (currCollected) {
                    TTDPRINT(@"已成功取消关注！");
                    [MBProgressHUD showError:@"已成功取消关注！"];
                    [button setTitle:@"关注" forState:UIControlStateNormal];
                } else {
                    TTDPRINT(@"已成功添加关注！");
                    [MBProgressHUD showError:@"已成功添加关注！"];
                    [button setTitle:@"取消关注" forState:UIControlStateNormal];
                }
            } else {
                TTDPRINT(@"添加关注失败！");
                [MBProgressHUD showError:@"添加关注失败！"];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            TTDPRINT(@"%@", error);
        }];
    }
}

#pragma mark - Load Data
- (void)headerRefresh {
    // 下拉刷新时初始化页码
    self.pagination = 1;
    
    // 开始加载数据
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getCollectedUserListWithCurrUserID:self.currUserID pagination:self.pagination pageCount:USER_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *userListModel) {
        STRONG_SELF;
        if ([userListModel isKindOfClass:[ZCPListDataModel class]] && userListModel.items) {
            weakSelf.collectedUserArray = [NSMutableArray arrayWithArray:userListModel.items];
            
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
    [[ZCPRequestManager sharedInstance] getCollectedUserListWithCurrUserID:self.currUserID pagination:self.pagination + 1 pageCount:USER_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *userListModel) {
        STRONG_SELF;
        if ([userListModel isKindOfClass:[ZCPListDataModel class]] && userListModel.items) {
            [weakSelf.collectedUserArray addObjectsFromArray:userListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
            // 如果获取到数据了，那么页数+1
            if (userListModel.items.count > 0) {
                self.pagination ++;
            }
        }
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
    }];
}

// 加载数据
- (void)loadData {
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getCollectedUserListWithCurrUserID:self.currUserID pagination:self.pagination pageCount:USER_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *userListModel) {
        STRONG_SELF;
        if ([userListModel isKindOfClass:[ZCPListDataModel class]] && userListModel.items) {
            weakSelf.collectedUserArray = [NSMutableArray arrayWithArray:userListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
    }];
}
@end
