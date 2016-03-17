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

#define BOOKPOST_LIST_PAGE_COUNT    PAGE_COUNT_DEFAULT
#define SearchBarHeight             44.0f   // 搜索栏视图高度
#define OptionHeight                35.0f   // 选项视图高度
#define SelectFieldWitdth           50.0f   // 选择领域视图宽度
#define SelectFieldHeight           300.0f  // 选择领域视图高度

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

#pragma mark - life cycle
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
    // 加载数据
    [self loadData];
    
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
        _selectFieldControl.view.frame = CGRectMake(APPLICATIONWIDTH * 5 / 6 - SelectFieldWitdth / 2, self.optionView.bottom, SelectFieldWitdth, SelectFieldHeight);
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

#pragma mark - ZCPListTableViewAdaptor Delegate
/**
 *  Cell点击事件
 *
 *  @param tableView cell所属Tableview
 *  @param object    cellItem
 *  @param indexPath cell索引
 */
- (void)tableView:(UITableView *)tableView didSelectObject:(id<ZCPTableViewCellItemBasicProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    // 隐藏选择视图
    [self.selectFieldControl hideView];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.pagination = 1;
    [self loadData];
}

#pragma mark - ZCPOptionViewDelegate
- (void)label:(UILabel *)label didSelectedAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
        case 1: {
            if (index == 0) {
                self.pagination = 1;
                self.sortMethod = ZCPBookpostSortByTime;
            } else if (index == 1){
                self.pagination = 1;
                self.sortMethod = ZCPBookpostSortBySupport;
            }
            
            // 加载数据
            [self loadData];
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
    self.pagination = 1;
    
    // 加载数据
    [self loadData];
}

#pragma mark - Load Data
/**
 *  下拉刷新
 */
- (void)headerRefresh {
    self.pagination = 1;
    
    // 获取数据
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getBookpostListWithSearchText:self.searchBar.text sortMethod:self.sortMethod fieldID:self.fieldIndex currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:BOOKPOST_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel) {
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
}
/**
 *  上拉刷新
 */
- (void)footerRefresh {
    // 获取数据
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getBookpostListWithSearchText:self.searchBar.text sortMethod:self.sortMethod fieldID:self.fieldIndex currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination + 1 pageCount:BOOKPOST_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel) {
        STRONG_SELF;
        if ([bookpostListModel isKindOfClass:[ZCPListDataModel class]] && bookpostListModel.items) {
            [weakSelf.bookpostArr addObjectsFromArray:bookpostListModel.items];
            
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
    [[ZCPRequestManager sharedInstance] getBookpostListWithSearchText:self.searchBar.text sortMethod:self.sortMethod fieldID:self.fieldIndex currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:BOOKPOST_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel) {
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
}

#pragma mark - Public Method
- (void)librarySearchBookName:(NSString *)bookName {
    self.pagination = 1;
    self.sortMethod = ZCPBookpostSortByTime;
    self.searchBar.text = bookName;
    
    // 加载数据
    [self loadData];
}



@end
