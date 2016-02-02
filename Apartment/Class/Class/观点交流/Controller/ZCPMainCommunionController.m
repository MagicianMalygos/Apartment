//
//  ZCPMainCommunionController.m
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPMainCommunionController.h"

#import "ZCPOptionView.h"
#import "ZCPBookPostCell.h"
#import "ZCPBookPostModel.h"

#define SearchBarHeight     44.0f  // 搜索栏视图高度
#define OptionHeight        35.0f  // 选项视图高度

@interface ZCPMainCommunionController () <ZCPOptionViewDelegate, UISearchBarDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;     // 搜索控制器
@property (nonatomic, strong) ZCPOptionView *optionView;                // 选项视图

@property (nonatomic, strong) NSMutableArray *bookpostArr;              // 图书贴数组

@end

@implementation ZCPMainCommunionController

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.searchController.searchBar];
    [self.view addSubview:self.optionView];
    
    self.bookpostArr = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        ZCPBookPostModel *model = [ZCPBookPostModel modelFromDictionary:@{@"bookpostTitle":@"你是谁？从哪里来？要到哪里去？"
                                                                          ,@"bookpostContent":@"阿百川打雷闪电卡上来看"
                                                                          ,@"bookpostTime":@"2015-1-2"
                                                                          ,@"user":@{@"userName":@"朱超鹏"}
                                                                          ,@"field":@{@"fieldName":@"军事"}
                                                                          ,@"book":@{@"bookName":@"骆驼祥子"}
                                                                          ,@"bookpostSupport":@2
                                                                          ,@"bookpostCollectNumber":@3
                                                                          ,@"bookpostReplyNumber":@10}];
        [self.bookpostArr addObject:model];
    }
    
    [self constructData];
    [self.tableView reloadData];
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
- (UISearchController *)searchController {
    if (_searchController == nil) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;        // 搜索期间视图变暗
        _searchController.hidesNavigationBarDuringPresentation = NO;    // 搜索期间隐藏NavigationBar
        _searchController.searchBar.placeholder = @"请输入作者名、书籍名、观点标题等关键词";
        _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, SearchBarHeight);
    }
    return _searchController;
}
/**
 *  懒加载选项视图
 *
 *  @return 选项视图
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

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"asd");
}

@end
