//
//  ZCPSelectFieldController.m
//  Apartment
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPSelectFieldController.h"

#import "ZCPRequestManager.h"
#import "ZCPSectionCell.h"
#import "ZCPFieldModel.h"

@interface ZCPSelectFieldController () <ZCPListTableViewAdaptorDelegate>

@end

@implementation ZCPSelectFieldController

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadFieldData];
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFieldData)];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
}

#pragma mark - constructData
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    ZCPSectionCellItem *item = [[ZCPSectionCellItem alloc] initWithDefault];
    item.sectionTitle = @"全部";
    item.cellHeight = @30;
    [items addObject:item];
    
    for (ZCPFieldModel *fieldModel in self.fieldArr) {
        ZCPSectionCellItem *item = [[ZCPSectionCellItem alloc] initWithDefault];
        item.sectionTitle = fieldModel.fieldName;
        item.cellHeight = @30;
        
        [items addObject:item];
    }
    
    self.tableViewAdaptor.items = items;
}

#pragma mark - ZCPListTableViewAdaptorDelegate
- (void)tableView:(UITableView *)tableView didSelectObject:(id<ZCPTableViewCellItemBasicProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideView];
    ZCPSectionCellItem *item = (ZCPSectionCellItem *)object;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedCellIndex:fieldName:)]) {
        [self.delegate selectedCellIndex:indexPath.row fieldName:item.sectionTitle];
    }
}

#pragma mark - load Data
- (void)loadFieldData {
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getFieldListSuccess:^(AFHTTPRequestOperation *operation, ZCPListDataModel *fieldListModel) {
        STRONG_SELF;
        if ([fieldListModel isKindOfClass:[ZCPListDataModel class]] && fieldListModel.items) {
            weakSelf.fieldArr = [NSMutableArray arrayWithArray:fieldListModel.items];
            
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
