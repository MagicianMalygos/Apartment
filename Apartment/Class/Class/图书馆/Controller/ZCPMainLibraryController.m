//
//  ZCPMainLibraryController.m
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPMainLibraryController.h"

#import "ZCPOptionView.h"
#import "ZCPBookCell.h"
#import "ZCPBookModel.h"
#import "ZCPSelectSortMethodController.h"
#import "ZCPSelectFieldController.h"
#import "ZCPRequestManager+Library.h"

#define OptionViewHight           35.0f     // 选项视图高度
#define SelectSortMethodWidth     80.0f     // 选择排序方式视图宽度
#define SelectSortMethodHeight    160.0f    // 选择排序方式视图高度
#define SelectFieldWidth          50.0f     // 选择领域视图宽度
#define SelectFieldHeight         300.0f    // 选择领域视图高度
#define BOOK_LIST_PAGE_COUNT      PAGE_COUNT_DEFAULT

@interface ZCPMainLibraryController () <ZCPListTableViewAdaptorDelegate, ZCPOptionViewDelegate, ZCPSelectSortMethodDelegate, ZCPSelectFieldDelegate, UISearchBarDelegate>


@property (nonatomic, strong) NSMutableArray *bookArr;              // 图书模型数组
@property (nonatomic, assign) NSInteger fieldIndex;                 // 领域索引
@property (nonatomic, assign) ZCPLibrarySortMethod sortMethod;      // 排序方法
@property (nonatomic, assign) NSInteger pagination;                 // 页码

@property (nonatomic, strong) ZCPOptionView *optionView;            // 选项视图
@property (nonatomic, strong) UISearchBar *searchBar;               // 搜索视图
@property (nonatomic, strong) ZCPSelectSortMethodController *selectSortMehtodControl;       // 选择排序方式视图控制器
@property (nonatomic, strong) ZCPSelectFieldController *selectFieldControl;                 // 选择领域视图控制器

@end

@implementation ZCPMainLibraryController
#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    self.sortMethod = ZCPLibrarySortByTime;
    self.fieldIndex = 0;
    self.pagination = 1;
    
    // 添加选项视图
    [self.view addSubview:self.optionView];
    [self.view addSubview:self.selectSortMehtodControl.view];
    [self.view addSubview:self.selectFieldControl.view];
    
    // 获取图书数据
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getBookListBySearchText:self.searchBar.text SortMethod:self.sortMethod fieldID:self.fieldIndex currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:BOOK_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookListModel) {
        STRONG_SELF;
        if ([bookListModel isKindOfClass:[ZCPListDataModel class]] && bookListModel.items) {
            weakSelf.bookArr = [NSMutableArray arrayWithArray:bookListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self clearNavigationBar];
    self.tabBarController.title = @"图书馆";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, self.optionView.bottom, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar - Height_TABBAR - OptionViewHight);
}

#pragma mark - getter / setter
- (UISearchBar *)searchBar {
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, APPLICATIONWIDTH, 44.0f)];
        _searchBar.placeholder = @"请输入书籍名、作者名、出版社等关键词";
        _searchBar.delegate = self;
    }
    return _searchBar;
}
/**
 *  懒加载选项视图
 *
 *  @return 选项视图
 */
- (ZCPOptionView *)optionView {
    if (_optionView == nil) {
        NSArray *attrStringArr = @[[[NSAttributedString alloc] initWithString:@"排序方式"
                                                                   attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]}]
                                   ,[[NSAttributedString alloc] initWithString:@"分类"
                                                                    attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]}]
                                   ,[[NSAttributedString alloc] initWithString:@"上传"
                                                                    attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]}]];
        _optionView = [[ZCPOptionView alloc] initWithFrame:CGRectMake(0
                                                                      , 0
                                                                      , self.view.width
                                                                      , OptionViewHight)
                                        attributeStringArr:attrStringArr];
        _optionView.delegate = self;
        [_optionView hideMarkView];
    }
    return _optionView;
}
- (ZCPSelectSortMethodController *)selectSortMehtodControl {
    if (_selectSortMehtodControl == nil) {
        _selectSortMehtodControl = [ZCPSelectSortMethodController new];
        _selectSortMehtodControl.view.frame = CGRectMake(APPLICATIONWIDTH / 6 - SelectSortMethodWidth / 2, self.optionView.bottom, SelectSortMethodWidth, SelectSortMethodHeight);
        _selectSortMehtodControl.delegate = self;
        _selectSortMehtodControl.view.backgroundColor = [UIColor PALightGrayColor];
        _selectSortMehtodControl.view.alpha = 0.0f;
    }
    return _selectSortMehtodControl;
}
- (ZCPSelectFieldController *)selectFieldControl {
    if (_selectFieldControl == nil) {
        _selectFieldControl = [ZCPSelectFieldController new];
        _selectFieldControl.view.frame = CGRectMake(APPLICATIONWIDTH / 2 - SelectFieldWidth / 2, self.optionView.bottom, SelectFieldWidth, SelectFieldHeight);
        _selectFieldControl.delegate = self;
        _selectFieldControl.view.backgroundColor = [UIColor PALightGrayColor];
        _selectFieldControl.view.alpha = 0.0f;
    }
    return _selectFieldControl;
}

#pragma mark - Construct Data
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    for (ZCPBookModel *model in self.bookArr) {
        
        ZCPBookCellItem *bookItem = [[ZCPBookCellItem alloc] initWithDefault];
        bookItem.bookCoverURL = model.bookCoverURL;
        bookItem.bookName = model.bookName;
        bookItem.bookAuthor = model.bookAuthor;
        bookItem.bookPublisher = model.bookPublisher;
        bookItem.field = @[model.field.fieldName];
        bookItem.bookPublishTime = model.bookPublishTime;
        bookItem.contributor = model.contributor.userName;
        bookItem.bookCommentCount = model.bookCommentCount;
        bookItem.bookCollectNumber = model.bookCollectNumber;
        
        [items addObject:bookItem];
    }

    self.tableViewAdaptor.items = items;
}

#pragma mark - ZCPOptionViewDelegate
- (void)label:(UILabel *)label didSelectedAtIndex:(NSInteger)index {
    switch (index) {
        case 0: {
            // 显示或隐藏选择排序方式视图
            if (self.selectSortMehtodControl.view.alpha == 1.0f) {
                [self.selectSortMehtodControl hideView];
            }
            else if (self.selectSortMehtodControl.view.alpha == 0.0f) {
                [self.selectSortMehtodControl showView];
                [self.selectFieldControl hideView];
            }
            break;
        }
        case 1: {
            // 显示或隐藏选择领域视图
            if (self.selectFieldControl.view.alpha == 1.0f) {
                [self.selectFieldControl hideView];
            }
            else if (self.selectFieldControl.view.alpha == 0.0f) {
                [self.selectFieldControl showView];
                [self.selectSortMehtodControl hideView];
            }
            break;
        }
        case 2: {
            // 跳转到上传图书界面
            [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_LIBRARY_ADDBOOK paramDictForInit:nil];
            break;
        }
        default:
            break;
    }
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
    [self.selectSortMehtodControl hideView];
    [self.selectFieldControl hideView];
    
    // 跳转到图书详情界面，判断如果图书模型为nil，则向字典中传入[NSNull null]
    ZCPBookModel *currentBookModel = [self.bookArr objectAtIndex:indexPath.row];
    [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_LIBRARY_BOOKDETAIL paramDictForInit:@{@"_currentBookModel": (currentBookModel != nil)? currentBookModel: [NSNull null]}];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.pagination = 1;
    
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getBookListBySearchText:self.searchBar.text SortMethod:self.sortMethod fieldID:self.fieldIndex currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:BOOK_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookListModel) {
        STRONG_SELF;
        if ([bookListModel isKindOfClass:[ZCPListDataModel class]] && bookListModel.items) {
            weakSelf.bookArr = [NSMutableArray arrayWithArray:bookListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
    }];
}

#pragma mark - ZCPSelectSortMethodDelegate
- (void)selectedCellIndex:(NSInteger)cellIndex sortMethodName:(NSString *)sortMethodName {
    self.sortMethod = cellIndex;
    self.pagination = 1;
}
#pragma mark - ZCPSelectFieldDelegate
- (void)selectedCellIndex:(NSInteger)cellIndex fieldName:(NSString *)fieldName {
    self.fieldIndex = cellIndex;
    self.pagination = 1;
}

#pragma mark - Refresh
- (void)headerRefresh {
    self.pagination = 1;
    
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getBookListBySearchText:self.searchBar.text SortMethod:self.sortMethod fieldID:self.fieldIndex currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:BOOK_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookListModel) {
        STRONG_SELF;
        if ([bookListModel isKindOfClass:[ZCPListDataModel class]] && bookListModel.items) {
            weakSelf.bookArr = [NSMutableArray arrayWithArray:bookListModel.items];
            
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
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getBookListBySearchText:self.searchBar.text SortMethod:self.sortMethod fieldID:self.fieldIndex currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination + 1 pageCount:BOOK_LIST_PAGE_COUNT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookListModel) {
        STRONG_SELF;
        if ([bookListModel isKindOfClass:[ZCPListDataModel class]] && bookListModel.items) {
            [weakSelf.bookArr addObjectsFromArray:bookListModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
        self.pagination ++;
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

@end
