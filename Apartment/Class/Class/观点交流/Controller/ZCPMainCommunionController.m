//
//  ZCPMainCommunionController.m
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPMainCommunionController.h"

#import "ZCPOptionView.h"
#import "ZCPSelectFieldController.h"
#import "ZCPBookPostCell.h"
#import "ZCPBookPostModel.h"
#import "ZCPRequestManager+Communion.h"

#define BOOKPOST_LIST_PAGE_COUNT    10
#define SearchBarHeight             44.0f   // 搜索栏视图高度
#define OptionHeight                35.0f   // 选项视图高度
#define SelecteFieldWitdth          50.0f   // 选择领域视图宽度
#define SelecteFieldHeight          300.0f  // 选择领域视图高度

@interface ZCPMainCommunionController () <ZCPOptionViewDelegate, UISearchBarDelegate, ZCPSelectFieldDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;                           // 搜索视图
@property (nonatomic, strong) ZCPOptionView *optionView;                        // 选项视图
@property (nonatomic, strong) ZCPSelectFieldController *selectFieldControl;     // 选择领域控制器

@property (nonatomic, strong) NSMutableArray *bookpostArr;                      // 图书贴数组
@property (nonatomic, assign) NSInteger fieldIndex;                             // 领域索引值
@property (nonatomic, assign) ZCPBookpostSortMethod sortMethod;                 // 排序方式
@property (nonatomic, assign)  int pagination;                                  // 页码

@end

@implementation ZCPMainCommunionController

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    self.fieldIndex = 0;
    self.pagination = 1;
    self.sortMethod = ZCPBookpostSortByTime;
    
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.optionView];
    [self.view addSubview:self.selectFieldControl.view];
    
    self.bookpostArr = [NSMutableArray array];
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getBookpostListWithSortMethod:ZCPBookpostSortByTime fieldID:self.fieldIndex currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pageCount:BOOKPOST_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel) {
        STRONG_SELF;
        if ([bookpostListModel isKindOfClass:[ZCPListDataModel class]] && bookpostListModel.items) {
            weakSelf.bookpostArr = [NSMutableArray arrayWithArray:bookpostListModel.items];
            
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
    [self clearNavigationBar];
    self.tabBarController.title = @"观点交流";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, SearchBarHeight + OptionHeight, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar - Height_TABBAR - SearchBarHeight - OptionHeight);
}

#pragma mark - getter / setter
- (UISearchBar *)searchBar {
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, APPLICATIONWIDTH, SearchBarHeight)];
        _searchBar.placeholder = @"请输入作者名、书籍名、观点标题等关键词";
        _searchBar.delegate = self;
    }
    return _searchBar;
}
/**
 *  懒加载选项视图
 */
- (ZCPOptionView *)optionView {
    if (_optionView == nil) {
        NSArray *attrStringArr = @[[[NSAttributedString alloc] initWithString:@"按时间排序"
                                                                   attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]}]
                                   ,[[NSAttributedString alloc] initWithString:@"按点赞量排序"
                                                                    attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]}]
                                   ,[[NSAttributedString alloc] initWithString:@"分类"
                                                                    attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]}]];
        _optionView = [[ZCPOptionView alloc] initWithFrame:CGRectMake(0
                                                                      , SearchBarHeight
                                                                      , self.view.width
                                                                      , OptionHeight)
                                        attributeStringArr:attrStringArr];
        _optionView.delegate = self;
        [_optionView hideMarkView];
    }
    return _optionView;
}
/**
 *  懒加载选择领域视图控制器
 */
- (ZCPSelectFieldController *)selectFieldControl {
    if (_selectFieldControl == nil) {
        _selectFieldControl = [ZCPSelectFieldController new];
        _selectFieldControl.view.frame = CGRectMake(APPLICATIONWIDTH * 5 / 6 - SelecteFieldWitdth / 2, self.optionView.bottom, SelecteFieldWitdth, SelecteFieldHeight);
        _selectFieldControl.delegate = self;
        _selectFieldControl.view.backgroundColor = [UIColor PALightGrayColor];
        _selectFieldControl.view.alpha = 0.0f;
    }
    return _selectFieldControl;
}

#pragma mark - Construct Data
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    for (ZCPBookPostModel *model in self.bookpostArr) {
        ZCPBookPostCellItem *bpItem = [[ZCPBookPostCellItem alloc] initWithDefault];
        bpItem.bpTitle = model.bookpostTitle;
        bpItem.bpContent = model.bookpostContent;
        bpItem.bpTime = model.bookpostTime;
        bpItem.uploader = model.user.userName;
        bpItem.field = model.field.fieldName;
        bpItem.bookName = model.book.bookName;
        bpItem.supportNumber = model.bookpostSupport;
        bpItem.collectionNumber = model.bookpostCollectNumber;
        bpItem.replyNumber = model.bookpostReplyNumber;
        
        [items addObject:bpItem];
    }
    
    self.tableViewAdaptor.items = items;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // 按搜索条件获取图书贴列表
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getBookpostWithSearchText:searchBar.text sortMethod:self.sortMethod fieldID:self.fieldIndex currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pageCount:BOOKPOST_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel) {
        STRONG_SELF;
        if ([bookpostListModel isKindOfClass:[ZCPListDataModel class]] && bookpostListModel.items) {
            weakSelf.bookpostArr = [NSMutableArray arrayWithArray:bookpostListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
    }];
    self.pagination = 1;
}

#pragma mark - ZCPOptionViewDelegate
- (void)label:(UILabel *)label didSelectedAtIndex:(NSInteger)index {
    switch (index) {
        case 0: {
            self.sortMethod = ZCPBookpostSortByTime;
            // 获取按时间排序的图书帖列表
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getBookpostListWithSortMethod:ZCPBookpostSortByTime fieldID:self.fieldIndex currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pageCount:BOOKPOST_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel) {
                STRONG_SELF;
                if ([bookpostListModel isKindOfClass:[ZCPListDataModel class]] && bookpostListModel.items) {
                    weakSelf.bookpostArr = [NSMutableArray arrayWithArray:bookpostListModel.items];
                    
                    // 重新构造并加载数据
                    [self constructData];
                    [weakSelf.tableView reloadData];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
            }];
            self.pagination = 1;
            break;
        }
        case 1: {
            self.sortMethod = ZCPBookpostSortBySupport;
            // 获取按点赞量排序的图书帖列表
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getBookpostListWithSortMethod:ZCPBookpostSortBySupport fieldID:self.fieldIndex currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pageCount:BOOKPOST_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel) {
                STRONG_SELF;
                if ([bookpostListModel isKindOfClass:[ZCPListDataModel class]] && bookpostListModel.items) {
                    weakSelf.bookpostArr = [NSMutableArray arrayWithArray:bookpostListModel.items];
                    
                    // 重新构造并加载数据
                    [self constructData];
                    [weakSelf.tableView reloadData];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
            }];
            self.pagination = 1;
            break;
        }
        case 2: {
            // 显示或隐藏选择领域视图
            if (self.selectFieldControl.view.alpha == 1.0f) {
                [self.selectFieldControl hideView];
            }
            else if (self.selectFieldControl.view.alpha == 0.0f) {
                [self.selectFieldControl showView];
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark - ZCPSelectFieldDelegate
- (void)selectedCellIndex:(NSInteger)cellIndex fieldName:(NSString *)fieldName {
    self.fieldIndex = cellIndex;
}

#pragma mark - Refresh Method
- (void)headerRefresh {
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getBookpostListWithSortMethod:self.sortMethod fieldID:self.fieldIndex currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pageCount:BOOKPOST_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel) {
        STRONG_SELF;
        if ([bookpostListModel isKindOfClass:[ZCPListDataModel class]] && bookpostListModel.items) {
            weakSelf.bookpostArr = [NSMutableArray arrayWithArray:bookpostListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    self.pagination = 1;
}
- (void)footerRefresh {
    
    NSInteger pageCount = (self.sortMethod == ZCPBookpostSortByTime)? BOOKPOST_LIST_PAGE_COUNT: ((self.pagination + 1) * BOOKPOST_LIST_PAGE_COUNT);
    
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getOldBookpostListWithSortMethod:self.sortMethod oldBookpostID:((ZCPBookPostModel *)[self.bookpostArr lastObject]).bookpostId fieldID:self.fieldIndex currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pageCount:pageCount success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel) {
        STRONG_SELF;
        if ([bookpostListModel isKindOfClass:[ZCPListDataModel class]] && bookpostListModel.items) {
            if (self.sortMethod == ZCPBookpostSortByTime) {
                [weakSelf.bookpostArr addObjectsFromArray:bookpostListModel.items];
            }
            else {
                weakSelf.bookpostArr = [NSMutableArray arrayWithArray:bookpostListModel.items];
            }
            
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

@end
