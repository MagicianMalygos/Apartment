//
//  ZCPSelectMenuController.m
//  Apartment
//
//  Created by apple on 16/3/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPSelectMenuController.h"
#import "ZCPSectionCell.h"

@interface ZCPSelectMenuController ()

@end

@implementation ZCPSelectMenuController

#pragma mark - synthesize
@synthesize itemArray   = _itemArray;
@synthesize viewHidden  = _viewHidden;
@synthesize delegate    = _delegate;

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.view.alpha = 0.0f;
    self.viewHidden = YES;
    
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    
    [self refreshHeader];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
}
#pragma mark - getter / setter
- (NSArray *)itemArray {
    if (_itemArray == nil) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}
- (void)setItemArray:(NSArray *)itemArray {
    _itemArray = itemArray;
    [self reloadData];
}

#pragma mark - constructData
- (void)constructData {
    
    NSMutableArray *items = [NSMutableArray array];
    
    NSInteger itemCount = self.itemArray.count;
    for (int i = 0; i < itemCount; i++) {
        ZCPSectionCellItem *sectionItem = [[ZCPSectionCellItem alloc] initWithDefault];
        sectionItem.sectionTitle = [self.itemArray objectAtIndex:i];
        sectionItem.cellHeight = @30;
        
        [items addObject:sectionItem];
    }

    self.tableViewAdaptor.items = items;
}
- (void)reloadData {
    if (self.itemArray) {
        [self constructData];
        [self.tableView reloadData];
    }
}

#pragma mark - ZCPListTableViewAdaptorDelegate
- (void)tableView:(UITableView *)tableView didSelectObject:(id<ZCPTableViewCellItemBasicProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideView];
    ZCPSectionCellItem *sectionItem = (ZCPSectionCellItem *)object;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectMenuController:selectedCellIndex:item:)]) {
        [self.delegate selectMenuController:self selectedCellIndex:indexPath.row item:sectionItem.sectionTitle];
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
    self.viewHidden = NO;
}
/**
 *  隐藏选择领域视图
 */
- (void)hideView {
    [UIView animateWithDuration:0.5f animations:^{
        self.view.alpha = 0.0f;
    }];
    self.viewHidden = YES;
}

#pragma mark - private method
- (void)refreshHeader {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectMenuController:refreshHeader:)]) {
        [self.delegate selectMenuController:self refreshHeader:self.tableView.mj_header];
    }
}

@end
