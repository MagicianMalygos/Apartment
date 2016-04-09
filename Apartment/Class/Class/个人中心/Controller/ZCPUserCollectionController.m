//
//  ZCPUserCollectionController.m
//  Apartment
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPUserCollectionController.h"
#import "ZCPOptionView.h"
#import "ZCPRequestManager+Communion.h"
#import "ZCPRequestManager+Library.h"
#import "ZCPRequestManager+Couplet.h"
#import "ZCPRequestManager+Thesis.h"
#import "ZCPRequestManager+Question.h"
#import "ZCPBookPostCell.h"
#import "ZCPBookCell.h"
#import "ZCPCoupletMainCell.h"
#import "ZCPThesisCell.h"

#define OptionViewHight           35.0f     // 选项视图高度

// 列表类型枚举
typedef NS_ENUM(NSInteger, CollectionListType) {
    BookpostCollectionList = 0,
    BookCollectionList = 1,
    CoupletCollectionList = 2,
    ThesisCollectionList = 3,
    QuestionCollectionList = 4
};
// 加载块
typedef void (^LoadBlock)(AFHTTPRequestOperation *operation, ZCPListDataModel *listModel);
typedef void (^HeaderLoadBlock)(AFHTTPRequestOperation *operation, ZCPListDataModel *listModel);
typedef void (^FooterLoadBlock)(AFHTTPRequestOperation *operation, ZCPListDataModel *listModel);

@interface ZCPUserCollectionController () <ZCPOptionViewDelegate>

@property (nonatomic, assign) NSInteger currUserID;                     // 用户ID
@property (nonatomic, assign) NSUInteger pagination;                    // 页码
@property (nonatomic, strong) ZCPOptionView *optionView;                // 选项视图
@property (nonatomic, strong) NSMutableArray *collectionListArray;      // 列表数组
@property (nonatomic, assign) CollectionListType collectionListType;    // 列表类型

@property (nonatomic, copy) LoadBlock loadBlock;                        // 普通加载块
@property (nonatomic, copy) HeaderLoadBlock headerLoadBlock;            // 下拉刷新加载块
@property (nonatomic, copy) FooterLoadBlock footerLoadBlock;            // 上拉刷新加载块

@end

@implementation ZCPUserCollectionController

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
    
    // 初始化
    self.pagination = 1;
    
    // 添加子视图
    [self.view addSubview:self.optionView];
    
    // 初始化上拉下拉控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    // 初始化加载块
    WEAK_SELF;
    self.loadBlock = ^(AFHTTPRequestOperation *operation, ZCPListDataModel *listModel) {
        STRONG_SELF;
        if ([listModel isKindOfClass:[ZCPListDataModel class]] && listModel.items) {
            weakSelf.collectionListArray =  [NSMutableArray arrayWithArray:listModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
    };
    self.headerLoadBlock = ^(AFHTTPRequestOperation *operation, ZCPListDataModel *listModel) {
        STRONG_SELF;
        if ([listModel isKindOfClass:[ZCPListDataModel class]] && listModel.items) {
            weakSelf.collectionListArray = [NSMutableArray arrayWithArray:listModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
        [weakSelf.tableView.mj_header endRefreshing];
    };
    self.footerLoadBlock = ^(AFHTTPRequestOperation *operation, ZCPListDataModel *listModel) {
        STRONG_SELF;
        if ([listModel isKindOfClass:[ZCPListDataModel class]] && listModel.items) {
            [weakSelf.collectionListArray addObjectsFromArray:listModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
            // 如果获取到数据了，那么页数+1
            if (listModel.items.count > 0) {
                self.pagination ++;
            }
        }
        [weakSelf.tableView.mj_footer endRefreshing];
    };
    
    // 初始化加载
    [self label:nil didSelectedAtIndex:0];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self clearNavigationBar];
    self.title = @"个人收藏";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, self.optionView.bottom, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar - OptionViewHight);
}

#pragma mark - constructData
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    for (ZCPDataModel *model in self.collectionListArray) {
        switch (self.collectionListType) {
            case BookpostCollectionList: {
                model.cellClass = [ZCPBookPostCell class];
                model.cellType = [ZCPBookPostCell cellIdentifier];
                break;
            }
            case BookCollectionList: {
                model.cellClass = [ZCPBookCell class];
                model.cellType = [ZCPBookCell cellIdentifier];
                break;
            }
            case CoupletCollectionList: {
                model.cellClass = [ZCPCoupletMainCell class];
                model.cellType = [ZCPCoupletMainCell cellIdentifier];
                break;
            }
            case ThesisCollectionList: {
                model.cellClass = [ZCPThesisShowCell class];
                model.cellType = [ZCPThesisShowCell cellIdentifier];
                break;
            }
            case QuestionCollectionList: {
                break;
            }
            default:
                break;
        }
        [items addObject:model];
    }
    self.tableViewAdaptor.items = items;
}

#pragma mark - getter / setter
- (NSMutableArray *)collectionListArray {
    if (_collectionListArray == nil) {
        _collectionListArray = [NSMutableArray array];
    }
    return _collectionListArray;
}
/**
 *  懒加载选项视图
 */
- (ZCPOptionView *)optionView {
    if (_optionView == nil) {
        NSArray *attrStringArr = @[[[NSAttributedString alloc] initWithString:@"图书贴"
                                                                   attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]}]
                                   ,[[NSAttributedString alloc] initWithString:@"图书"
                                                                    attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]}]
                                   ,[[NSAttributedString alloc] initWithString:@"对联"
                                                                    attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]}]
                                   ,[[NSAttributedString alloc] initWithString:@"辩题"
                                                                    attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]}]
                                   ,[[NSAttributedString alloc] initWithString:@"问题"
                                                                    attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]}]
                                   ];
        _optionView = [[ZCPOptionView alloc] initWithFrame:({
            CGRectMake(0, 0, self.view.width, OptionViewHight);
        }) attributeStringArr:attrStringArr];
        _optionView.delegate = self;
        [_optionView hideMarkView];
    }
    return _optionView;
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
    
    if ([object isKindOfClass:[ZCPBookPostModel class]]) {
        // 跳转到图书贴详情视图控制器（图书贴评论视图控制器）
        ZCPBookPostModel *selectedBookpostModel = (ZCPBookPostModel *)object;
        [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_COMMUNION_BOOKPOSTDETAIL paramDictForInit:@{@"_currentBookpostModel": selectedBookpostModel}];
    } else if ([object isKindOfClass:[ZCPBookModel class]]) {
        // 跳转到图书详情界面，判断如果图书模型为nil，则向字典中传入[NSNull null]
        ZCPBookModel *currentBookModel = (ZCPBookModel *)object;
        [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_LIBRARY_BOOKDETAIL
                                             paramDictForInit:@{@"_currentBookModel": (currentBookModel != nil)? currentBookModel: [NSNull null]}];
    } else if ([object isKindOfClass:[ZCPCoupletModel class]]) {
        // 跳转到对联详情界面，并进行nil值判断
        ZCPCoupletModel *selectedCoupletModel = (ZCPCoupletModel *)object;
        [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_COUPLET_DETAIL paramDictForInit:@{@"_selectedCoupletModel": (selectedCoupletModel != nil)? selectedCoupletModel: [NSNull null]}];
    }
}

#pragma mark - ZCPOptionViewDelegate
- (void)label:(UILabel *)label didSelectedAtIndex:(NSInteger)index {
    self.pagination = 1;
    
    switch (index) {
        case 0: {
            self.collectionListType = BookpostCollectionList;
            // 加载图书贴列表
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getBookpostCollectionListWithCurrUserID:self.currUserID pagination:self.pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel) {
                weakSelf.loadBlock(operation, bookpostListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
            }];
            break;
        }
        case 1: {
            self.collectionListType = BookCollectionList;
            // 加载图书列表
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getBookCollectionListWithCurrUserID:self.currUserID pagination:self.pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookListModel) {
                weakSelf.loadBlock(operation, bookListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
            }];
            break;
        }
        case 2: {
            self.collectionListType = CoupletCollectionList;
            // 加载对联列表
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getCoupltCollectionListWithCurrUserID:self.currUserID pagination:self.pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *coupltListModel) {
                weakSelf.loadBlock(operation, coupltListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
            }];
            break;
        }
        case 3: {
            self.collectionListType = ThesisCollectionList;
            // 加载辩题列表
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getThesisCollectionListWithCurrUserID:self.currUserID pagination:self.pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *thesisListModel) {
                weakSelf.loadBlock(operation, thesisListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
            }];
            break;
        }
        case 4: {
            self.collectionListType = QuestionCollectionList;
            break;
        }
        default:
            break;
    }
}

#pragma mark - Load Data
- (void)headerRefresh {
    
    // 初始化页码
    self.pagination = 1;
    // 加载数据
    switch (self.collectionListType) {
        case BookpostCollectionList: {
            self.collectionListType = BookpostCollectionList;
            // 加载图书列表
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getBookpostCollectionListWithCurrUserID:self.currUserID pagination:self.pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel) {
                weakSelf.headerLoadBlock(operation, bookpostListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
                [weakSelf.tableView.mj_header endRefreshing];
            }];
            break;
        }
        case BookCollectionList: {
            self.collectionListType = BookCollectionList;
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getBookCollectionListWithCurrUserID:self.currUserID pagination:self.pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookListModel) {
                weakSelf.headerLoadBlock(operation, bookListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
                [weakSelf.tableView.mj_header endRefreshing];
            }];
            break;
        }
        case CoupletCollectionList: {
            self.collectionListType = CoupletCollectionList;
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getCoupltCollectionListWithCurrUserID:self.currUserID pagination:self.pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *coupltListModel) {
                weakSelf.headerLoadBlock(operation, coupltListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
                [weakSelf.tableView.mj_header endRefreshing];
            }];
            break;
        }
        case ThesisCollectionList: {
            self.collectionListType = ThesisCollectionList;
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getThesisCollectionListWithCurrUserID:self.currUserID pagination:self.pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *thesisListModel) {
                weakSelf.headerLoadBlock(operation, thesisListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
                [weakSelf.tableView.mj_header endRefreshing];
            }];
            break;
        }
        case QuestionCollectionList: {
            self.collectionListType = QuestionCollectionList;
            break;
        }
        default:
            break;
    }
}
- (void)footerRefresh {
    
    NSInteger pagination = self.pagination + 1;
    
    // 加载数据
    switch (self.collectionListType) {
        case BookpostCollectionList: {
            self.collectionListType = BookpostCollectionList;
            // 加载图书列表
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getBookpostCollectionListWithCurrUserID:self.currUserID pagination:pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel) {
                weakSelf.footerLoadBlock(operation, bookpostListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
                [weakSelf.tableView.mj_footer endRefreshing];
            }];
            break;
        }
        case BookCollectionList: {
            self.collectionListType = BookCollectionList;
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getBookCollectionListWithCurrUserID:self.currUserID pagination:pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookListModel) {
                weakSelf.footerLoadBlock(operation, bookListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
                [weakSelf.tableView.mj_footer endRefreshing];
            }];
            break;
        }
        case CoupletCollectionList: {
            self.collectionListType = CoupletCollectionList;
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getCoupltCollectionListWithCurrUserID:self.currUserID pagination:pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *coupltListModel) {
                weakSelf.footerLoadBlock(operation, coupltListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
                [weakSelf.tableView.mj_footer endRefreshing];
            }];
            break;
        }
        case ThesisCollectionList: {
            self.collectionListType = ThesisCollectionList;
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getThesisCollectionListWithCurrUserID:self.currUserID pagination:pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *thesisListModel) {
                weakSelf.footerLoadBlock(operation, thesisListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
                [weakSelf.tableView.mj_footer endRefreshing];
            }];
            break;
        }
        case QuestionCollectionList: {
            self.collectionListType = QuestionCollectionList;
            break;
        }
        default:
            break;
    }
}

@end
