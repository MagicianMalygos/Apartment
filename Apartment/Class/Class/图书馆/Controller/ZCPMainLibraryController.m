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

#define OptionViewHight     35

@interface ZCPMainLibraryController () <ZCPListTableViewAdaptorDelegate, ZCPOptionViewDelegate>

@property (nonatomic, strong) ZCPOptionView *optionView;    // 选项视图
@property (nonatomic, strong) NSMutableArray *bookArr;      // 图书模型数组

@end

@implementation ZCPMainLibraryController
#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加选项视图
    [self.view addSubview:self.optionView];
    
    self.bookArr = [NSMutableArray array];
    ZCPBookModel *model = [ZCPBookModel modelFromDictionary:@{@"bookId":@1
                                                              ,@"bookName":@"《像恋爱一样去工作》- 爱上邓丽君阿里的卡上了肯德基"
                                                              ,@"bookAuthor":@"茅侃侃"
                                                              ,@"bookPublishTime":@"2013-12-14 23:21:12"
                                                              ,@"bookCoverURL":@"http://"
                                                              ,@"bookPublisher":@"xxx出版社"
                                                              ,@"bookSummary":@"像恋爱一样去工作 - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
                                                              ,@"bookCommentCount":@20
                                                              ,@"bookCollectNumber":@100
                                                              ,@"bookTime":@"2015-2-12 11:02:06"
                                                              ,@"field":@{@"fieldId":@4, @"fieldName":@"工作"}
                                                              ,@"contributor":@{@"userName":@"ZCP"}}];
    [self.bookArr addObject:model];
    [self constructData];
    [self.tableView reloadData];
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
/**
 *  懒加载选项视图
 *
 *  @return 选项视图
 */
- (ZCPOptionView *)optionView {
    if (_optionView == nil) {
        NSArray *attrStringArr = @[[[NSAttributedString alloc] initWithString:@"最新"
                                                                   attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]}]
                                   ,[[NSAttributedString alloc] initWithString:@"收藏"
                                                                    attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]}]
                                   ,[[NSAttributedString alloc] initWithString:@"评论"
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


#pragma mark - ZCPListTableViewAdaptor Delegate
/**
 *  Cell点击事件
 *
 *  @param tableView cell所属Tableview
 *  @param object    cellItem
 *  @param indexPath cell索引
 */
- (void)tableView:(UITableView *)tableView didSelectObject:(id<ZCPTableViewCellItemBasicProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    // 跳转到图书详情界面，判断如果图书模型为nil，则向字典中传入[NSNull null]
    ZCPBookModel *currentBookModel = [self.bookArr objectAtIndex:indexPath.row];
    [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_LIBRARY_BOOKDETAIL paramDictForInit:@{@"_currentBookModel": (currentBookModel != nil)? currentBookModel: [NSNull null]}];
    
//    [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_LIBRARY_ADDBOOK paramDictForInit:nil];
}

@end
