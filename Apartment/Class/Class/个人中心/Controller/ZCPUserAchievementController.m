//
//  ZCPUserAchievementController.m
//  Apartment
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPUserAchievementController.h"
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
typedef NS_ENUM(NSInteger, ListType) {
    BookpostList = 0,
    BookList = 1,
    CoupletList = 2,
    ThesisList = 3,
    QuestionList = 4
};
// 加载块
typedef void (^LoadBlock)(AFHTTPRequestOperation *operation, ZCPListDataModel *listModel);
typedef void (^HeaderLoadBlock)(AFHTTPRequestOperation *operation, ZCPListDataModel *listModel);
typedef void (^FooterLoadBlock)(AFHTTPRequestOperation *operation, ZCPListDataModel *listModel);


@interface ZCPUserAchievementController () <ZCPOptionViewDelegate>

@property (nonatomic, assign) NSInteger currUserID;         // 用户ID
@property (nonatomic, assign) NSUInteger pagination;        // 页码
@property (nonatomic, strong) ZCPOptionView *optionView;    // 选项视图
@property (nonatomic, strong) NSMutableArray *listArray;    // 列表数组
@property (nonatomic, assign) ListType listType;            // 列表类型

@property (nonatomic, copy) LoadBlock loadBlock;                // 普通加载块
@property (nonatomic, copy) HeaderLoadBlock headerLoadBlock;    // 下拉刷新加载块
@property (nonatomic, copy) FooterLoadBlock footerLoadBlock;    // 上拉刷新加载块

@end

@implementation ZCPUserAchievementController

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
            weakSelf.listArray =  [NSMutableArray arrayWithArray:listModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
    };
    self.headerLoadBlock = ^(AFHTTPRequestOperation *operation, ZCPListDataModel *listModel) {
        STRONG_SELF;
        if ([listModel isKindOfClass:[ZCPListDataModel class]] && listModel.items) {
            weakSelf.listArray = [NSMutableArray arrayWithArray:listModel.items];
            
            // 重新构造并加载数据
            [self constructData];
            [weakSelf.tableView reloadData];
        }
        [weakSelf.tableView.mj_header endRefreshing];
    };
    self.footerLoadBlock = ^(AFHTTPRequestOperation *operation, ZCPListDataModel *listModel) {
        STRONG_SELF;
        if ([listModel isKindOfClass:[ZCPListDataModel class]] && listModel.items) {
            [weakSelf.listArray addObjectsFromArray:listModel.items];
            
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
    self.title = @"个人成就";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, self.optionView.bottom, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar - OptionViewHight);
}

#pragma mark - constructData
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    for (ZCPDataModel *model in self.listArray) {
        switch (self.listType) {
            case BookpostList: {
                model.cellClass = [ZCPBookPostCell class];
                model.cellType = [ZCPBookPostCell cellIdentifier];
                break;
            }
            case BookList: {
                model.cellClass = [ZCPBookCell class];
                model.cellType = [ZCPBookCell cellIdentifier];
                break;
            }
            case CoupletList: {
                model.cellClass = [ZCPCoupletMainCell class];
                model.cellType = [ZCPCoupletMainCell cellIdentifier];
                break;
            }
            case ThesisList: {
                model.cellClass = [ZCPThesisShowCell class];
                model.cellType = [ZCPThesisShowCell cellIdentifier];
                break;
            }
            case QuestionList: {
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
- (NSMutableArray *)listArray {
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
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
            self.listType = BookpostList;
            // 加载图书列表
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getBookpostListWithCurrUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel) {
                weakSelf.loadBlock(operation, bookpostListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
            }];
            break;
        }
        case 1: {
            self.listType = BookList;
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getBookListWithCurrUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookListModel) {
                weakSelf.loadBlock(operation, bookListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
            }];
            break;
        }
        case 2: {
            self.listType = CoupletList;
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getCoupltListWithCurrUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *coupltListModel) {
                weakSelf.loadBlock(operation, coupltListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
            }];
            break;
        }
        case 3: {
            self.listType = ThesisList;
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getThesisWithCurrUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *thesisListModel) {
                weakSelf.loadBlock(operation, thesisListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
            }];
            break;
        }
        case 4: {
            self.listType = QuestionList;
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
    switch (self.listType) {
        case BookpostList: {
            self.listType = BookpostList;
            // 加载图书列表
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getBookpostListWithCurrUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel) {
                weakSelf.headerLoadBlock(operation, bookpostListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
                [weakSelf.tableView.mj_header endRefreshing];
            }];
            break;
        }
        case BookList: {
            self.listType = BookList;
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getBookListWithCurrUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookListModel) {
                weakSelf.headerLoadBlock(operation, bookListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
                [weakSelf.tableView.mj_header endRefreshing];
            }];
            break;
        }
        case CoupletList: {
            self.listType = CoupletList;
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getCoupltListWithCurrUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *coupltListModel) {
                weakSelf.headerLoadBlock(operation, coupltListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
                [weakSelf.tableView.mj_header endRefreshing];
            }];
            break;
        }
        case ThesisList: {
            self.listType = ThesisList;
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getThesisWithCurrUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId pagination:self.pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *thesisListModel) {
                weakSelf.headerLoadBlock(operation, thesisListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
                [weakSelf.tableView.mj_header endRefreshing];
            }];
            break;
        }
        case QuestionList: {
            self.listType = QuestionList;
            break;
        }
        default:
            break;
    }
}
- (void)footerRefresh {
    
    NSInteger currUserID = [ZCPUserCenter sharedInstance].currentUserModel.userId;
    NSInteger pagination = self.pagination + 1;
    
    // 加载数据
    switch (self.listType) {
        case BookpostList: {
            self.listType = BookpostList;
            // 加载图书列表
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getBookpostListWithCurrUserID:currUserID pagination:pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookpostListModel) {
                weakSelf.footerLoadBlock(operation, bookpostListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
                [weakSelf.tableView.mj_footer endRefreshing];
            }];
            break;
        }
        case BookList: {
            self.listType = BookList;
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getBookListWithCurrUserID:currUserID pagination:pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *bookListModel) {
                weakSelf.footerLoadBlock(operation, bookListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
                [weakSelf.tableView.mj_footer endRefreshing];
            }];
            break;
        }
        case CoupletList: {
            self.listType = CoupletList;
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getCoupltListWithCurrUserID:currUserID pagination:pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *coupltListModel) {
                weakSelf.footerLoadBlock(operation, coupltListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
                [weakSelf.tableView.mj_footer endRefreshing];
            }];
            break;
        }
        case ThesisList: {
            self.listType = ThesisList;
            WEAK_SELF;
            [[ZCPRequestManager sharedInstance] getThesisWithCurrUserID:currUserID pagination:pagination pageCount:PAGE_COUNT_DEFAULT success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *thesisListModel) {
                weakSelf.footerLoadBlock(operation, thesisListModel);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                TTDPRINT(@"%@", error);
                [weakSelf.tableView.mj_footer endRefreshing];
            }];
            break;
        }
        case QuestionList: {
            self.listType = QuestionList;
            break;
        }
        default:
            break;
    }
}

@end
