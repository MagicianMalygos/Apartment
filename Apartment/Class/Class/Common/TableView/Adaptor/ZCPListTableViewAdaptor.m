//
//  ZCPListTableViewAdaptor.m
//  Apartment
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPListTableViewAdaptor.h"

#define LOADMORE_HEIGHT 44.0

@interface ZCPListTableViewAdaptor () <PARefreshTableHeaderDelegate>

@end


@implementation ZCPListTableViewAdaptor

@synthesize items = _items;
@synthesize cellActionDictionary = _cellActionDictionary;
@synthesize cellTargetDictionary = _cellTargetDictionary;
@synthesize tableView = _tableView;
@synthesize delegate = _delegate;

#pragma mark - facilities
- (ZCPTableViewCell *)generateCellForObject:(id<ZCPTableViewCellItemBasicProtocol>)object indexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier{
    ZCPTableViewCell * cell                  = nil;
    
    if (object) {
        Class   cellClass                       = [self cellClassForObject:object];
        
        if (object.useNib == YES) {
            UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
            cell = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
        } else {
            cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
    }
    
    return cell;
}

//获取cell数据模型item对应的cell的类对象
- (Class)cellClassForObject:(id<ZCPTableViewCellItemBasicProtocol>)object{
    Class cellClass             = nil;
    
    if (object) {
        if ([object respondsToSelector:@selector(cellClass)]) {
            cellClass           = [object cellClass];
        }
    }
    
    return cellClass;
}

- (Class)cellClassForIndexPath:(NSIndexPath *)indexPath{
    Class cellClass                                 = nil;
    id<ZCPTableViewCellItemBasicProtocol> object     = [self objectForRowAtIndexPath:indexPath];
    
    cellClass                                       = [self cellClassForObject:object];
    
    return cellClass;
}

//获取indexpath位置上cell的数据模型
- (id<ZCPTableViewCellItemBasicProtocol>)objectForRowAtIndexPath:(NSIndexPath *)indexPath{
    id object           = nil;
    
    if (self.items.count > indexPath.row) {
        object          = [self.items objectAtIndex:indexPath.row];
    }
    
    return object;
}

- (NSInteger)numberOfRows{
    return self.items.count;
}

- (int)numberOfSections{
    return 1;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat rowHeight       = 0;
    
    UITableView * tableView = self.tableView;
    id object               = [self objectForRowAtIndexPath:indexPath];
    
    Class cellClass         = [self cellClassForIndexPath:indexPath];
    rowHeight               = [cellClass tableView:tableView rowHeightForObject:object];
    
    return rowHeight;
}

- (NSString *)cellTypeAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellType                         = nil;
    
    id<ZCPTableViewCellItemBasicProtocol> object = [self objectForRowAtIndexPath:indexPath];
    if (object) {
        cellType                                = [object cellType];
    }
    
    return cellType;
}

- (NSString *)identifierForCellAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identifier                       = nil;
    
    identifier                                  = [self cellTypeAtIndexPath:indexPath];
    
    return identifier;
}

- (SEL)actionForCellType:(NSString *)cellType{
    SEL action      = nil;
    
    if ([self.cellActionDictionary objectForKey:cellType]) {
        if ([[self.cellActionDictionary objectForKey:cellType] isKindOfClass:[NSValue class]]) {
            action  = [[self.cellActionDictionary objectForKey:cellType] pointerValue];
        }
    }
    
    return action;
}

- (SEL)actionForCellAtIndexPath:(NSIndexPath *)indexPath{
    SEL action          = nil;
    
    NSString * cellType = [self cellTypeAtIndexPath:indexPath];
    action              = [self actionForCellType:cellType];
    
    return action;
}

- (id)targetForCellType:(NSString *)cellType{
    id target           = nil;
    
    if ([self.cellTargetDictionary objectForKey:cellType]) {
        target          = [self.cellTargetDictionary objectForKey:cellType];
    }
    
    return target;
}

- (id)targetForCellAtIndexPath:(NSIndexPath *)indexPath{
    id  target             = nil;
    
    NSString * cellType    = [self cellTypeAtIndexPath:indexPath];
    target                 = [self targetForCellType:cellType];
    
    return target;
}

#pragma mark - setter/getter
- (NSMutableArray *)items{
    if (_items == nil) {
        self.items = [NSMutableArray array];
    }
    
    return _items;
}

- (PATableHeaderDragRefreshView *)headerRefreshView
{
    if (_headerRefreshView == nil) {
        // Add our refresh header
        _headerRefreshView = [[PATableHeaderDragRefreshView alloc]
                              initWithFrame:CGRectMake(0,
                                                       -CGRectGetHeight(self.tableView.bounds),
                                                       CGRectGetWidth(self.tableView.bounds),
                                                       CGRectGetHeight(self.tableView.bounds))];
        _headerRefreshView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _headerRefreshView.backgroundColor = [UIColor clearColor];
        _headerRefreshView.delegate = self;
    }
    return _headerRefreshView;
}

- (PALoadFooterView *)loadMoreView
{
    if (_loadMoreView == nil) {
        _loadMoreView = [[PALoadFooterView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.tableView.bounds), LOADMORE_HEIGHT)];
        _loadMoreView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _loadMoreView.backgroundColor = [UIColor whiteColor];
    }
    return _loadMoreView;
}

- (void)setDragRefreshEnable:(BOOL)dragRefreshEnable
{
    _dragRefreshEnable = dragRefreshEnable;
    if (_dragRefreshEnable) {
        [self.tableView addSubview:self.headerRefreshView];
    } else {
        [self.headerRefreshView removeFromSuperview];
    }
}

- (void)setLoadMoreEnable:(BOOL)loadMoreEnable
{
    _loadMoreEnable = loadMoreEnable;
    if (_loadMoreEnable) {
        self.tableView.tableFooterView = self.loadMoreView;
        [self.loadMoreView startAnimation];
    } else {
        self.tableView.tableFooterView = nil;
        [self.loadMoreView stopAnimation];
    }
}

- (NSMutableDictionary *)cellActionDictionary{
    if (_cellActionDictionary == nil) {
        _cellActionDictionary   = [NSMutableDictionary dictionary];
    }
    
    return _cellActionDictionary;
}


- (NSMutableDictionary *)cellTargetDictionary{
    if (_cellTargetDictionary == nil) {
        self.cellTargetDictionary   = [NSMutableDictionary dictionary];
    }
    
    return _cellTargetDictionary;
}

- (BOOL)dataIsLoading
{
    return [self.delegate respondsToSelector:@selector(tableViewDataIsLoading:)] &&
    [self.delegate tableViewDataIsLoading:self.tableView];
}

- (void)finishLoadingDataWithResult:(BOOL)result
{
    if (self.dragRefreshEnable) {
        [self.headerRefreshView paRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self numberOfRows];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self numberOfSections];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id<ZCPTableViewCellItemBasicProtocol> object = [self objectForRowAtIndexPath:indexPath];
    
    NSString * identifier  = [self identifierForCellAtIndexPath:indexPath];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    if (cell == nil) {
        //初始化cell
        cell               = [self generateCellForObject:object indexPath:indexPath identifier:identifier];
    }
    
    if (!cell) {
        NSLog(@"Catch up a bug!!! row: %tu", indexPath.row);
    }
    
    //更新数据
    if ([cell isKindOfClass:[ZCPTableViewCell class]]) {
        [(ZCPTableViewCell *)cell setObject:object];
    }
    
    if ([self.delegate respondsToSelector:@selector(tableView:didSetObject:cell:)]) {
        [self.delegate tableView:tableView didSetObject:object cell:cell];
    }
    
    return cell;
}

#pragma mark - PARefreshTableHeaderDelegate

- (BOOL)paRefreshTableHeaderDataSourceIsLoading:(PATableHeaderDragRefreshView *)view
{
    if ([self.delegate respondsToSelector:@selector(tableViewDataIsLoading:)]) {
        return [self.delegate tableViewDataIsLoading:self.tableView];
    } else {
        return YES;
    }
}

- (void)paRefreshTableHeaderDidTriggerRefresh:(PATableHeaderDragRefreshView *)view
{
    if ([self.delegate respondsToSelector:@selector(tableViewTriggerRefresh:)]) {
        return [self.delegate tableViewTriggerRefresh:self.tableView];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height      = 0;
    
    if (self.tableView == nil) {
        self.tableView  = tableView;
    }
    height              = [self heightForRowAtIndexPath:indexPath];
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id<ZCPTableViewCellItemBasicProtocol> object = [self objectForRowAtIndexPath:indexPath];
    SEL action          = [self actionForCellAtIndexPath:indexPath];
    id target           = [self targetForCellAtIndexPath:indexPath];
    if (action && target) {
        if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:action withObject:object withObject:indexPath];
#pragma clang diagnostic pop
        }
    }else{
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(tableView:didSelectObject:rowAtIndexPath:)]) {
                [self.delegate tableView:tableView didSelectObject:object rowAtIndexPath:indexPath];
            }
        }
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [self.delegate tableView:self.tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        return [self.delegate tableView:self.tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    return @"Delete";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        return [self.delegate tableView:self.tableView canEditRowAtIndexPath:indexPath];
    }
    return NO;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate performSelector:@selector(scrollViewDidScroll:) withObject:scrollView];
    }
    
    //NSLog(@"%f", self.tableView.contentOffset.y);
    
    if (self.dragRefreshEnable &&
        self.tableView.contentOffset.y < 0.0) {
        [self.headerRefreshView paRefreshScrollViewDidScroll:scrollView];
    }
    
    if ([scrollView reachToEnd]) {
        if ([self.delegate respondsToSelector:@selector(tableViewReachToEnd:)]) {
            [self.delegate tableViewReachToEnd:self.tableView];
        }
    }
    
    //    //2. add hasNoMore condition for _infiniteScroll
    //    if (_loadMoreEnable && ![self dataIsLoading]) {
    //
    //    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.delegate performSelector:@selector(scrollViewWillBeginDragging:) withObject:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.delegate performSelector:@selector(scrollViewDidEndDragging:willDecelerate:) withObject:scrollView withObject:[NSNumber numberWithBool:decelerate]];
    }
    if (self.dragRefreshEnable) {
        [self.headerRefreshView paRefreshScrollViewDidEndDragging:scrollView];
    }
}

@end
