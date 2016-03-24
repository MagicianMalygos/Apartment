//
//  ZCPThesisMainController.m
//  Apartment
//
//  Created by apple on 16/1/21.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPThesisMainController.h"

#import "ZCPThesisCell.h"
#import "ZCPThesisModel.h"
#import "ZCPArgumentModel.h"
#import "ZCPSectionCell.h"
#import "ZCPArgumentCell.h"
#import "ZCPRequestManager+Thesis.h"

#define OptionHeight 50.0f

@interface ZCPThesisMainController () <ZCPListTableViewAdaptorDelegate, ZCPThesisViewDelegate, ZCPArgumentCellDelegate>

@property (nonatomic, strong) ZCPThesisView *thesisView;        // 论题视图
@property (nonatomic, strong) ZCPThesisModel *thesisModel;      // 论题模型
@property (nonatomic, strong) NSMutableArray *prosArgumentArr;  // 正方论据数组
@property (nonatomic, strong) NSMutableArray *consArgumentArr;  // 反方论据数组

@end

@implementation ZCPThesisMainController

#pragma mark - synthesize
@synthesize thesisView = _thesisView;
@synthesize thesisModel = _thesisModel;
@synthesize prosArgumentArr = _prosArgumentArr;
@synthesize consArgumentArr = _consArgumentArr;

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载辩题和论据
    [self loadThesisAndArgument];
    // 初始化下拉刷新控件
    WEAK_SELF;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        STRONG_SELF;
        [self loadThesisAndArgument];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, self.thesisView.bottom, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar - Height_TABBAR - OptionHeight);
}

#pragma mark - Construct Data
- (void)constructData {
    
    // 文字主题颜色
    UIColor *textColor = (self.appTheme == LightTheme)?[UIColor blackColor]:[UIColor whiteColor];
    NSMutableArray *items = [NSMutableArray array];
    
    // thesisItem
    ZCPThesisCellItem *thesisItem = [[ZCPThesisCellItem alloc] initWithDefault];
    thesisItem.thesisModel = self.thesisModel;
    thesisItem.delegate = self;
    [items addObject:thesisItem];
    
    // 正方 section
    ZCPSectionCellItem *sectionItem1 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem1.cellHeight = @20;
    sectionItem1.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem1.backgroundColor = [UIColor lightGrayColor];
    sectionItem1.sectionAttrTitle = [[NSAttributedString alloc] initWithString:@"正方观点" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    [items addObject:sectionItem1];
    
    for (ZCPArgumentModel *model in self.prosArgumentArr) {
        ZCPArgumentCellItem *argumentItem = [[ZCPArgumentCellItem alloc] initWithDefault];
        argumentItem.argumentID = model.argumentId;
        argumentItem.argumentBelong = model.argumentBelong;
        argumentItem.userHeadImgURL = model.user.userFaceURL;
        argumentItem.userName = model.user.userName;
        argumentItem.argumentContent = model.argumentContent;
        argumentItem.time = model.argumentTime;
        argumentItem.supportNumber = model.argumentSupport;
        argumentItem.argumentSupported = model.supported;
        argumentItem.delegate = self;
        [items addObject:argumentItem];
    }
    
    // 反方 section
    ZCPSectionCellItem *sectionItem2 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem2.cellHeight = @20;
    sectionItem2.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem2.backgroundColor = [UIColor lightGrayColor];
    sectionItem2.sectionAttrTitle = [[NSAttributedString alloc] initWithString:@"反方观点" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    [items addObject:sectionItem2];
    
    for (ZCPArgumentModel *model in self.consArgumentArr) {
        ZCPArgumentCellItem *argumentItem = [[ZCPArgumentCellItem alloc] initWithDefault];
        argumentItem.argumentID = model.argumentId;
        argumentItem.argumentBelong = model.argumentBelong;
        argumentItem.userHeadImgURL = model.user.userFaceURL;
        argumentItem.userName = model.user.userName;
        argumentItem.argumentContent = model.argumentContent;
        argumentItem.time = model.argumentTime;
        argumentItem.supportNumber = model.argumentSupport;
        argumentItem.argumentSupported = model.supported;
        argumentItem.delegate = self;
        [items addObject:argumentItem];
    }
    
    self.tableViewAdaptor.items = items;
}

#pragma mark - ZCPListTableViewAdaptor Delegate
/**
 *  cell点击事件
 *
 *  @param tableView cell所属的tableview
 *  @param object    cellItem
 *  @param indexPath cell索引
 */
- (void)tableView:(UITableView *)tableView didSelectObject:(id<ZCPTableViewCellItemBasicProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    // 过滤掉点击Section的事件
    if ([object isKindOfClass:[ZCPArgumentCellItem class]]) {
        ZCPArgumentCellItem *argumentItem = (ZCPArgumentCellItem *)object;
        [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_THESIS_ARGUMENTLIST paramDictForInit:@{@"_argumentBelong": @(argumentItem.argumentBelong)}];
    }
}

#pragma mark - ZCPThesisView Delegate
/**
 *  辩题评论按钮点击事件
 *
 *  @param thesisView 辩题视图
 *  @param button     评论按钮
 */
- (void)thesisView:(ZCPThesisView *)thesisView didClickedCommentButton:(UIButton *)button {
    [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_THESIS_ADDARGUMENT paramDictForInit:@{@"_currThesisID": @(self.thesisModel.thesisId)}];
}
/**
 *  辩题收藏按钮点击事件
 *
 *  @param thesisView 辩题视图
 *  @param button     收藏按钮
 */
- (void)thesisView:(ZCPThesisView *)thesisView didClickedCollectionButton:(UIButton *)button {
    [[ZCPRequestManager sharedInstance] changeThesisCurrCollectionState:self.thesisModel.collected currThesisID:self.thesisModel.thesisId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            if (thesisView.thesisCollected == ZCPCurrUserNotCollectThesis) {
                button.selected = YES;
                thesisView.thesisCollected = ZCPCurrUserHaveCollectThesis;
                thesisView.thesisModel.thesisCollectNumber = thesisView.thesisModel.thesisCollectNumber + 1;
                thesisView.collectionNumberLabel.text = [NSString stringWithFormat:@"%lu 人收藏", self.thesisModel.thesisCollectNumber];
                
                TTDPRINT(@"收藏成功！");
                [MBProgressHUD showSuccess:@"收藏成功！" toView:self.view];
            }
            else if (thesisView.thesisCollected == ZCPCurrUserHaveCollectThesis) {
                button.selected = NO;
                thesisView.thesisCollected = ZCPCurrUserNotCollectThesis;
                thesisView.thesisModel.thesisCollectNumber = thesisView.thesisModel.thesisCollectNumber - 1;
                thesisView.collectionNumberLabel.text = [NSString stringWithFormat:@"%lu 人收藏", self.thesisModel.thesisCollectNumber];
                
                TTDPRINT(@"取消收藏成功！");
                [MBProgressHUD showSuccess:@"取消收藏成功！" toView:self.view];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"操作失败！%@", error);
        [MBProgressHUD showSuccess:@"操作失败！网络异常！" toView:self.view];
    }];
}
/**
 *  辩题分享按钮点击事件
 *
 *  @param thesisView 辩题视图
 *  @param button     分享按钮
 */
- (void)thesisView:(ZCPThesisView *)thesisView didClickedSharedThesisButton:(UIButton *)button {
    [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_THESIS_ADDTHESIS paramDictForInit:nil];
}

#pragma mark - Private Method
/**
 *  加载辩题和论据
 */
- (void)loadThesisAndArgument {
    // 从网络获取Thesis数据
    TTDPRINT(@"开始获取辩题信息！");
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getCurrThesisWithCurrUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, NSDictionary *modelDict) {
        STRONG_SELF;
        if (modelDict && [modelDict isKindOfClass:[NSDictionary class]]) {
            self.thesisModel = [modelDict valueForKey:@"currThesisModel"];
            
            self.prosArgumentArr = [NSMutableArray arrayWithCapacity:1];
            self.consArgumentArr = [NSMutableArray arrayWithCapacity:1];
            
            ZCPArgumentModel *prosArgumentModel = [modelDict valueForKey:@"prosArgumentModel"];
            ZCPArgumentModel *consArgumentModel = [modelDict valueForKey:@"consArgumentModel"];
            if (prosArgumentModel) {
                [self.prosArgumentArr addObject:prosArgumentModel];
            }
            if (consArgumentModel) {
                [self.consArgumentArr addObject:consArgumentModel];
            }
            
            [self constructData];
            [self.tableView reloadData];
        }
        TTDPRINT(@"获取辩题成功！");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"获取失败！网络异常！%@error", error);
    }];
}


#pragma mark - ZCPArgumentCellDelegate
- (void)argumentCell:(ZCPArgumentCell *)cell supportButtonClicked:(UIButton *)button {
    
    [[ZCPRequestManager sharedInstance] changeArgumentCurrSupportedState:cell.item.argumentSupported currArgumentID:cell.item.argumentID currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            if (cell.item.argumentSupported == ZCPCurrUserNotSupportArgument) {
                button.selected = YES;
                cell.item.argumentSupported = ZCPCurrUserHaveSupportArgument;
                cell.item.supportNumber = cell.item.supportNumber + 1;
                cell.supportNumberLabel.text = [NSString stringWithFormat:@"%li", cell.item.supportNumber];
                
                TTDPRINT(@"点赞成功！");
                [MBProgressHUD showSuccess:@"点赞成功！" toView:self.view];
            }
            else if (cell.item.argumentSupported == ZCPCurrUserHaveSupportArgument) {
                button.selected = NO;
                cell.item.argumentSupported = ZCPCurrUserNotSupportArgument;
                cell.item.supportNumber = cell.item.supportNumber - 1;
                cell.supportNumberLabel.text = [NSString stringWithFormat:@"%li", cell.item.supportNumber];
                
                TTDPRINT(@"取消点赞成功！");
                [MBProgressHUD showSuccess:@"取消点赞成功！" toView:self.view];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"操作失败！%@", error);
        [MBProgressHUD showSuccess:@"操作失败！网络异常！" toView:self.view];
    }];
}

@end
