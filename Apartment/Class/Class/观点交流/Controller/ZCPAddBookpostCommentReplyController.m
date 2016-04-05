//
//  ZCPAddBookpostCommentReplyController.m
//  Apartment
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPAddBookpostCommentReplyController.h"
#import "ZCPBookPostCommentModel.h"
#import "ZCPSectionCell.h"
#import "ZCPTextViewCell.h"
#import "ZCPButtonCell.h"
#import "ZCPRequestManager+Communion.h"

@interface ZCPAddBookpostCommentReplyController () <ZCPButtonCellDelegate>

@property (nonatomic, strong) ZCPBookPostCommentModel *currCommentModel;  // 要回复的评论ID

@end

@implementation ZCPAddBookpostCommentReplyController

#pragma mark - init
- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        self.currCommentModel = [params objectForKey:@"_currCommentModel"];
    }
    return self;
}

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"写回复";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar);
}

#pragma mark - Construct Data
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    // section
    ZCPSectionCellItem *sectionItem = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem.cellHeight = @20;
    sectionItem.backgroundColor = [UIColor lightGrayColor];
    sectionItem.sectionTitle = @"写回复";
    sectionItem.titleEdgeInset = UIEdgeInsetsZero;
    // 对联内容
    ZCPTextViewCellItem *textItem = [[ZCPTextViewCellItem alloc] initWithDefault];
    textItem.placeholder = @"请输入内容，不超过500个字";
    
    // blank
    ZCPLineCellItem *blankItem = [[ZCPLineCellItem alloc] initWithDefault];
    // 提交按钮
    ZCPButtonCellItem *determineItem = [[ZCPButtonCellItem alloc] initWithDefault];
    determineItem.buttonTitle = @"提交";
    determineItem.delegate = self;
    
    
    [items addObject:sectionItem];
    [items addObject:textItem];
    
    [items addObject:blankItem];
    [items addObject:determineItem];
    
    self.tableViewAdaptor.items = items;
}

#pragma mark - ZCPButtonCellDelegate
- (void)cell:(UITableViewCell *)cell buttonClicked:(UIButton *)button {
    
    ZCPTextViewCellItem *textItem = [self.tableViewAdaptor.items objectAtIndex:1];
    NSString *replyContent = textItem.textInputValue;
    
    // 空值检测
    if ([ZCPJudge judgeNullTextInput:replyContent showErrorMsg:@"内容不能为空！"]
        || [ZCPJudge judgeOutOfRangeTextInput:replyContent range:[ZCPLengthRange rangeWithMin:1 max:500] showErrorMsg:@"字数不得超过500字！"]) {
        return;
    }
    
    TTDPRINT(@"提交回复中...");
    [[ZCPRequestManager sharedInstance] addBookpostCommentReplyWithBookpostCommentReplyContent:replyContent bookpostCommentID:self.currCommentModel.commentId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId receiverID:self.currCommentModel.user.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            TTDPRINT(@"提交回复成功！！");
            [MBProgressHUD showSuccess:@"回复添加成功！"];
        } else {
            TTDPRINT(@"提交回复失败！！");
            [MBProgressHUD showError:@"回复添加失败！"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"提交失败！%@", error);
        [MBProgressHUD showError:@"回复添加失败！网络异常！"];
    }];
    
    // pop
    [self.navigationController popViewControllerAnimated:YES];
}

@end
