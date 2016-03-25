//
//  ZCPMainCommunionController.m
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPMainCommunionController.h"

#import "ZCPOptionView.h"
#import "ZCPSelectMenuController.h"
#import "ZCPBookPostCell.h"
#import "ZCPBookPostModel.h"
#import "ZCPRequestManager+Communion.h"

#define BOOKPOST_LIST_PAGE_COUNT    PAGE_COUNT_DEFAULT
#define SearchBarHeight             44.0f   // 搜索栏视图高度
#define OptionHeight                35.0f   // 选项视图高度
#define SelectSortMethodWidth       80.0f   // 选择排序方式视图宽度
#define SelectSortMethodHeight      120.0f  // 选择排序方式视图高度
#define SelectFieldWitdth           50.0f   // 选择领域视图宽度
#define SelectFieldHeight           300.0f  // 选择领域视图高度

@interface ZCPMainCommunionController () <ZCPOptionViewDelegate, UISearchBarDelegate, ZCPSelectMenuDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;                               // 搜索视图
@property (nonatomic, strong) ZCPOptionView *optionView;                            // 选项视图
@property (nonatomic, strong) ZCPSelectMenuController *selectSortMethodControl;     // 选择排序方式控制器
@property (nonatomic, strong) ZCPSelectMenuController *selectFieldControl;          // 选择领域控制器

@property (nonatomic, strong) NSMutableArray *bookpostArr;                          // 图书贴数组
@property (nonatomic, assign) NSInteger fieldIndex;                                 // 领域索引值
@property (nonatomic, assign) ZCPBookpostSortMethod sortMethod;                     // 排序方式
@property (nonatomic, assign) NSUInteger pagination;                                // 页码

@end

@implementation ZCPMainCommunionController

#pragma mark - synthesize
@synthesize searchBar                   = _searchBar;
@synthesize optionView                  = _optionView;
@synthesize selectSortMethodControl     = _selectSortMethodControl;
@synthesize selectFieldControl          = _selectFieldControl;
@synthesize bookpostArr                 = _bookpostArr;
@synthesize fieldIndex                  = _fieldIndex;
@synthesize sortMethod                  = _sortMethod;
@synthesize pagination                  = _pagination;

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    self.fieldIndex = 0;
    self.pagination = 1;
    self.sortMethod = ZCPBookpostSortByTime;
    
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.optionView];
    [self.view addSubview:self.selectSortMethodControl.view];
    [self.view addSubview:self.selectFieldControl.view];
    
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
/**
 *  懒加载搜索栏
 */
- (UISearchBar *)searchBar {
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, APPLICATIONWIDTH, SearchBarHeight)];
        _searchBar.placeholder = @"请输入观点标题、观点内容、书籍名等关键词";
        _searchBar.delegate = self;
    }
    return _searchBar;
}
/**
 *  懒加载选项视图
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
 *  懒加载选择排序方式视图控制器
 */
- (ZCPSelectMenuController *)selectSortMethodControl {
    if (_selectSortMethodControl == nil) {
        _selectSortMethodControl = [ZCPSelectMenuController new];
        _selectSortMethodControl.view.frame = CGRectMake(APPLICATIONWIDTH / 6 - SelectSortMethodWidth / 2, self.optionView.bottom, SelectSortMethodWidth, SelectSortMethodHeight);
        _selectSortMethodControl.delegate = self;
        _selectSortMethodControl.itemArray = @[@"时间", @"点赞量", @"评论量"];
    }
    return _selectSortMethodControl;
}
/**
 *  懒加载选择领域视图控制器
 */
- (ZCPSelectMenuController *)selectFieldControl {
    if (_selectFieldControl == nil) {
        _selectFieldControl = [ZCPSelectMenuController new];
        _selectFieldControl.view.frame = CGRectMake(APPLICATIONWIDTH * 3 / 6 - SelectFieldWitdth / 2, self.optionView.bottom, SelectFieldWitdth, SelectFieldHeight);
        _selectFieldControl.delegate = self;
        
        [[ZCPRequestManager sharedInstance] getFieldListSuccess:^(AFHTTPRequestOperation *operation, ZCPListDataModel *fieldListModel) {
            if ([fieldListModel isKindOfClass:[ZCPListDataModel class]] && fieldListModel.items) {
                NSMutableArray *itemTempArray = [NSMutableArray arrayWithObjects:@"全部", nil];
                for (ZCPFieldModel *model in fieldListModel.items) {
                    [itemTempArray addObject:model.fieldName];
                }
                _selectFieldControl.itemArray = itemTempArray;
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            TTDPRINT(@"%@", error);
        }];
    }
    return _selectFieldControl;
}
- (NSMutableArray *)bookpostArr {
    if (_bookpostArr == nil) {
        _bookpostArr = [NSMutableArray array];
    }
    return _bookpostArr;
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
        bpItem.bookName = model.bookpostBookName;
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
        case 0: {
            // 显示或隐藏选择排序方式视图
            if (self.selectSortMethodControl.isViewHidden) {
                [self.selectSortMethodControl showView];
                [self.selectFieldControl hideView];
            } else {
                [self.selectSortMethodControl hideView];
            }
            break;
        }
        case 1: {
            // 显示或隐藏选择领域视图
            if (self.selectFieldControl.isViewHidden) {
                [self.selectFieldControl showView];
                [self.selectSortMethodControl hideView];
            } else {
                [self.selectFieldControl hideView];
            }
            break;
        }
        case 2: {
            [self.selectSortMethodControl hideView];
            [self.selectFieldControl hideView];
            
            NSMutableArray *fieldArray = [NSMutableArray arrayWithArray:self.selectFieldControl.itemArray];
            [fieldArray removeObject:@"全部"];
            // 跳转到发表评论视图控制器
            [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_COMMUNION_ADDBOOKPOST
                                                 paramDictForInit:@{@"_fieldArray": fieldArray}];
        }
        default:
            break;
    }
}

#pragma mark - ZCPSelectMenuDelegate
- (void)selectMenuController:(ZCPSelectMenuController *)selectMenuControl selectedCellIndex:(NSInteger)cellIndex item:(NSString *)item {
    if (selectMenuControl == self.selectSortMethodControl) {
        self.sortMethod = cellIndex;
    } else if (selectMenuControl == self.selectFieldControl) {
        self.fieldIndex = cellIndex;
    }
    self.pagination = 1;
    
    // 加载数据
    [self loadData];
}
- (void)selectMenuController:(ZCPSelectMenuController *)selectMenuControl refreshHeader:(MJRefreshHeader *)mj_header {
    if (selectMenuControl == self.selectSortMethodControl) {
        [selectMenuControl reloadData];
        [mj_header endRefreshing];
    } else if (selectMenuControl == self.selectFieldControl) {
        [[ZCPRequestManager sharedInstance] getFieldListSuccess:^(AFHTTPRequestOperation *operation, ZCPListDataModel *fieldListModel) {
            if ([fieldListModel isKindOfClass:[ZCPListDataModel class]] && fieldListModel.items) {
                NSMutableArray *itemTempArray = [NSMutableArray arrayWithObjects:@"全部", nil];
                for (ZCPFieldModel *model in fieldListModel.items) {
                    [itemTempArray addObject:model.fieldName];
                }
                selectMenuControl.itemArray = itemTempArray;
            }
            [mj_header endRefreshing];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            TTDPRINT(@"%@", error);
            [mj_header endRefreshing];
        }];
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
