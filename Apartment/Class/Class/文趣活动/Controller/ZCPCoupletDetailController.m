//
//  ZCPCoupletDetailController.m
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPCoupletDetailController.h"

#import "ZCPCoupletModel.h"
#import "ZCPCoupletDetailCell.h"
#import "ZCPCoupletReplyCell.h"
#import "ZCPCoupletReplyModel.h"

#import "ZCPSectionCell.h"


@interface ZCPCoupletDetailController ()

@property (nonatomic, strong) ZCPCoupletModel *selectedCoupletModel;        // 当前对联模型
@property (nonatomic, strong) NSMutableArray *coupletReplyModelArr;         // 对联回复模型数组

@end

@implementation ZCPCoupletDetailController

@synthesize selectedCoupletModel = _selectedCoupletModel;
@synthesize coupletReplyModelArr = _coupletReplyModelArr;

#pragma mark - init
- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        self.selectedCoupletModel = [params objectForKey:@"_selectedCoupletModel"];
    }
    return self;
}

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 从网络获取数据
    self.coupletReplyModelArr = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        ZCPCoupletReplyModel *model = [ZCPCoupletReplyModel modelFromDictionary:@{@"replyId":[NSNumber numberWithInt:i]
                                                                        ,@"replyContent":@"asdasdasdasdasdasddddddddddddddddddddddasdddddddddd"
                                                                        ,@"replySupport":[NSNumber numberWithInt:i]
                                                                        ,@"replyTime":@"2015-10-20"
                                                                        ,@"supported":@YES}];
        [self.coupletReplyModelArr addObject:model];
    }
    
    [self constructData];
    [self.tableView reloadData];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar);
}

#pragma mark - Construct Data
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    // Couplet Detail
    ZCPCoupletDetailCellItem *detailItem = [[ZCPCoupletDetailCellItem alloc] initWithDefault];
    detailItem.coupletContent = self.selectedCoupletModel.coupletContent;
    detailItem.userHeadImageURL = self.selectedCoupletModel.user.userFaceURL;
    detailItem.userName = self.selectedCoupletModel.user.userName;
    detailItem.time = self.selectedCoupletModel.coupletTime;
    [items addObject:detailItem];

//    ZCPSectionCellItem * section = [[ZCPSectionCellItem alloc] initWithDefault];
//    section.cellHeight = @20;
//    [items addObject:section];
    
    for (ZCPCoupletReplyModel *model in self.coupletReplyModelArr) {
        ZCPCoupletReplyCellItem * replyItem = [[ZCPCoupletReplyCellItem alloc] initWithDefault];
        replyItem.replyContent = model.replyContent;
        replyItem.userHeadImageURL = model.user.userFaceURL;
        replyItem.userName = model.user.userName;
        replyItem.replyTime = model.replyTime;
        [items addObject:replyItem];
    }
    
    self.tableViewAdaptor.items = items;
}

@end
