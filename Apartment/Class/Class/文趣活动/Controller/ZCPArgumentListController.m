//
//  ZCPArgumentListController.m
//  Apartment
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPArgumentListController.h"

#import "ZCPArgumentModel.h"
#import "ZCPArgumentCell.h"

@interface ZCPArgumentListController ()

@property (nonatomic, assign) ZCPArgumentBelong argumentBelong;     // 正反方
@property (nonatomic, strong) NSMutableArray *argumentArr;          // 论据数组

@end

@implementation ZCPArgumentListController

@synthesize argumentBelong = _argumentBelong;
@synthesize argumentArr = _argumentArr;

#pragma mark - init
- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        _argumentBelong = [(NSNumber *)[params objectForKey:@"_argumentBelong"] boolValue];
    }
    return self;
}

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.argumentArr = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        ZCPArgumentModel *argumentModel = [ZCPArgumentModel modelFromDictionary:@{
                                                                                  @"argumentId":[NSNumber numberWithInteger:i]
                                                                                  ,@"argumentContent":@"alnvoawenvoanvlaksdv"
                                                                                  ,@"argumentSupport":[NSNumber numberWithInteger:i]
                                                                                  ,@"argumentBelong":@1
                                                                                  ,@"argumentTime":@"2016-2-3"
                                                                                  ,@"state":@{
                                                                                          @"stateId":@1
                                                                                          ,@"stateName":@"Argument"
                                                                                          ,@"stateValue":@1
                                                                                          ,@"stateType":@"Argument"
                                                                                          ,@"stateTime":@"2014-4-4"}
                                                                                  ,@"user":@{@"userName":@"zcp"}}];
        [self.argumentArr addObject:argumentModel];
    }
    [self constructData];
    [self.tableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = self.argumentBelong == ZCPProsArgument? @"正方论据": @"反方论据";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar);
}

#pragma mark - Construct Data
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    for (ZCPArgumentModel *model in self.argumentArr) {
        ZCPArgumentCellItem *argumentItem = [[ZCPArgumentCellItem alloc] initWithDefault];
        argumentItem.userHeadImgURL = model.user.userFaceURL;
        argumentItem.userName = model.user.userName;
        argumentItem.argumentContent = model.argumentContent;
        argumentItem.time = model.argumentTime;
        [items addObject:argumentItem];
    }
    
    self.tableViewAdaptor.items = items;
}


@end
