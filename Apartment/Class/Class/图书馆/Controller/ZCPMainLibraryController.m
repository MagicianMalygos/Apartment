//
//  ZCPMainLibraryController.m
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPMainLibraryController.h"

#import "ZCPBookCell.h"
#import "ZCPBookModel.h"

@interface ZCPMainLibraryController () <ZCPListTableViewAdaptorDelegate>

@property (nonatomic, strong) NSMutableArray *bookArr;      // 图书模型数组

@end

@implementation ZCPMainLibraryController
#pragma mark - life circle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self clearNavigationBar];
    self.tabBarController.title = @"图书馆";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar - Height_TABBAR);
}

#pragma mark - Construct Data
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    ZCPBookModel *model = [ZCPBookModel modelFromDictionary:@{@"bookId":@1
                                                              ,@"bookName":@"像恋爱一样去工作"
                                                              ,@"bookAuthor":@"XXX"
                                                              ,@"bookPublishTime":@"2013-12-14"
                                                              ,@"bookCoverURL":@"http://"
                                                              ,@"bookPublisher":@"xxx出版社"
                                                              ,@"bookSummary":@"XXXXXXXXXXXXXXXXXXXXXX"
                                                              ,@"bookCommentCount":@20
                                                              ,@"bookCollectNumber":@100
                                                              ,@"bookTime":@"2015-2-12"
                                                              ,@"field":@{@"fieldId":@4,@"fieldName":@"工作"}
                                                              ,@"contributor":@{@"userName":@"ZCP"}}];
    
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
    bookItem.bookSummary = model.bookSummary;
    
    [items addObject:bookItem];
    self.tableViewAdaptor.items = items;
}


#pragma mark - ZCPListTableViewAdaptor Delegate
- (void)tableView:(UITableView *)tableView didSelectObject:(id<ZCPTableViewCellItemBasicProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_LIBRARY_BOOKDETAIL paramDictForInit:@{@"_currentBookModel": [self.bookArr objectAtIndex:indexPath.row]}];
}

@end
