//
//  ZCPBookpostCommentDetailController.m
//  Apartment
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookpostCommentDetailController.h"
#import "ZCPBookPostCommentModel.h"
#import "ZCPBookpostCommentDetailCell.h"
#import "ZCPRequestManager+Communion.h"

@interface ZCPBookpostCommentDetailController () <ZCPBookpostCommentDetailCellDelegate>

@property (nonatomic, strong) ZCPBookPostCommentModel *currCommentModel; // 当前评论模型

@end

@implementation ZCPBookpostCommentDetailController

#pragma mark - init
- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        self.currCommentModel = [params objectForKey:@"_currCommentModel"];
    }
    return self;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self clearNavigationBar];
    // 设置nav Title
    self.title = @"评论详情";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar);
}

#pragma mark - Construct Data
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    ZCPBookpostCommentDetailCellItem *commentItem = [[ZCPBookpostCommentDetailCellItem alloc] initWithDefault];
    commentItem.bookpostCommentModel = self.currCommentModel;
    commentItem.delegate = self;
    
    [items addObject:commentItem];
    self.tableViewAdaptor.items = items;
}

#pragma mark - ZCPBookpostCommentDetailCellDelegate
/**
 *  回复按钮点击事件
 */
- (void)bookpostCommentDetailCell:(ZCPBookpostCommentDetailCell *)cell replyButtonClicked:(UIButton *)button {
    [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_COMMUNION_BOOKPOSTCOMMENTREPLY paramDictForInit:@{@"_currCommentModel": self.currCommentModel}];
}
/**
 *  点赞按钮点击事件
 */
- (void)bookpostCommentDetailCell:(ZCPBookpostCommentDetailCell *)cell supportButtonClicked:(UIButton *)button {
    [[ZCPRequestManager sharedInstance] changeBookpostCommentCurrSupportState:self.currCommentModel.supported currBookpostCommentID:self.currCommentModel.commentId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            if (self.currCommentModel.supported == ZCPCurrUserNotSupportBookpostComment) {
                button.selected = YES;
                self.currCommentModel.supported = ZCPCurrUserHaveSupportBookpostComment;
                
                TTDPRINT(@"点赞成功！");
                [MBProgressHUD showSuccess:@"点赞成功！"];
            }
            else if (self.currCommentModel.supported == ZCPCurrUserHaveSupportBookpostComment) {
                button.selected = NO;
                self.currCommentModel.supported = ZCPCurrUserNotSupportBookpostComment;
                
                TTDPRINT(@"取消点赞成功！");
                [MBProgressHUD showSuccess:@"取消点赞成功！"];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"操作失败！%@", error);
        [MBProgressHUD showSuccess:@"操作失败！网络异常！"];
    }];
}

@end
