//
//  ZCPSelectSortMethodController.m
//  Apartment
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPSelectSortMethodController.h"

#import "ZCPSectionCell.h"

@interface ZCPSelectSortMethodController ()

@property (nonatomic, strong) NSMutableArray *sortMethodNameArr;

@end

@implementation ZCPSelectSortMethodController

#pragma mark - life circle
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
}

#pragma mark - constructData
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    for (NSString *sortMethodName in self.sortMethodNameArr) {
        ZCPSectionCellItem *item = [[ZCPSectionCellItem alloc] initWithDefault];
        item.sectionTitle = sortMethodName;
        item.cellHeight = @30;
        
        [items addObject:item];
    }
    
    self.tableViewAdaptor.items = items;
}

#pragma mark - getter / setter
- (NSMutableArray *)sortMethodNameArr {
    if (_sortMethodNameArr == nil) {
        _sortMethodNameArr = [NSMutableArray arrayWithObjects:@"按时间", @"按点赞量", @"按评论量", nil];
    }
    return _sortMethodNameArr;
}

#pragma mark - ZCPListTableViewAdaptorDelegate
- (void)tableView:(UITableView *)tableView didSelectObject:(id<ZCPTableViewCellItemBasicProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideView];
    ZCPSectionCellItem *item = (ZCPSectionCellItem *)object;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedCellIndex:sortMethodName:)]) {
        [self.delegate selectedCellIndex:indexPath.row sortMethodName:item.sectionTitle];
    }
}

#pragma mark - Show & Hide
/**
 *  显示选择领域视图
 */
- (void)showView {
    [UIView animateWithDuration:0.5f animations:^{
        self.view.alpha = 1.0f;
    }];
}
/**
 *  隐藏选择领域视图
 */
- (void)hideView {
    [UIView animateWithDuration:0.5f animations:^{
        self.view.alpha = 0.0f;
    }];
}

@end
