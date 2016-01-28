//
//  ZCPThesisMainController.m
//  Apartment
//
//  Created by apple on 16/1/21.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPThesisMainController.h"

#import "ZCPThesisView.h"
#import "ZCPThesisModel.h"
#import "ZCPArgumentModel.h"
#import "ZCPSectionCell.h"
#import "ZCPArgumentCell.h"

#define OptionHeight 50.0f

@interface ZCPThesisMainController () <ZCPListTableViewAdaptorDelegate, ZCPThesisViewDelegate>

@property (nonatomic, strong) ZCPThesisView *thesisView;        // 论题视图
@property (nonatomic, strong) ZCPThesisModel *thesisModel;      // 论题模型
@property (nonatomic, strong) NSMutableArray *prosArgumentArr;  // 正方论据数组
@property (nonatomic, strong) NSMutableArray *consArgumentArr;  // 反方论据数组

@end

@implementation ZCPThesisMainController

@synthesize thesisView = _thesisView;
@synthesize thesisModel = _thesisModel;
@synthesize prosArgumentArr = _prosArgumentArr;
@synthesize consArgumentArr = _consArgumentArr;

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // thesisView
    ZCPThesisModel *thesisModel = [[ZCPThesisModel alloc] initWithDictionary:@{
                                                                               @"thesisId":@10
                                                                               ,@"thesisContent":@"asdfsadf"
                                                                               ,@"thesisPros":@"Prosa;lsdfjalskdjflaksjdflkasjdlfksjdfksdjfk"
                                                                               ,@"thesisProsCount":@5
                                                                               ,@"thesisProsReplyNumber":@5
                                                                               ,@"thesisCons":@"Consadasdasdaaaaaaaaaaaaaaaaaaaaaaaaaa"
                                                                               ,@"thesisConsCount":@10
                                                                               ,@"thesisConsReplyNumber":@10
                                                                               ,@"thesisCollectNumber":@15
                                                                               ,@"thesisStartTime":@"2015-1-1"
                                                                               ,@"thesisEndTime":@"2016-2-1"
                                                                               ,@"collected":@YES}];
    self.thesisModel = thesisModel;
    self.thesisView = [[ZCPThesisView alloc] initWithFrame:CGRectMake(0, 0, APPLICATIONWIDTH, 200) thesis:thesisModel];
    self.thesisView.delegate = self;
    [self.view addSubview:self.thesisView];
    
    // 初始化正反方论据数组
    self.prosArgumentArr = [NSMutableArray array];
    self.consArgumentArr = [NSMutableArray array];
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
                                                                                          ,@"stateTime":@"2014-4-4"}}];
        [self.prosArgumentArr addObject:argumentModel];
    }
    for (int i = 10; i < 20; i++) {
        ZCPArgumentModel *argumentModel = [ZCPArgumentModel modelFromDictionary:@{
                                                                                  @"argumentId":[NSNumber numberWithInteger:i]
                                                                                  ,@"argumentContent":@"alnvoawenvoanvlaksdv"
                                                                                  ,@"argumentSupport":[NSNumber numberWithInteger:i]
                                                                                  ,@"argumentBelong":@0
                                                                                  ,@"argumentTime":@"2016-2-3"
                                                                                  ,@"state":@{
                                                                                          @"stateId":@1
                                                                                          ,@"stateName":@"Argument"
                                                                                          ,@"stateValue":@1
                                                                                          ,@"stateType":@"Argument"
                                                                                          ,@"stateTime":@"2014-4-4"}}];
        [self.consArgumentArr addObject:argumentModel];
    }
    [self constructData];
    [self.tableView reloadData];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, self.thesisView.bottom, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar - Height_TABBAR - OptionHeight - self.thesisView.height);
}

#pragma mark - Construct Data
- (void)constructData {
    
    // 文字主题颜色
    UIColor *textColor = (self.appTheme == LightTheme)?[UIColor blackColor]:[UIColor whiteColor];
    NSMutableArray *items = [NSMutableArray array];
    
    // 正方 section
    ZCPSectionCellItem *sectionItem1 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem1.cellHeight = @20;
    sectionItem1.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem1.backgroundColor = [UIColor lightGrayColor];
    sectionItem1.sectionAttrTitle = [[NSAttributedString alloc] initWithString:@"正方观点" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont systemFontOfSize:14.0f]}];
    [items addObject:sectionItem1];
    
    for (ZCPArgumentModel *model in self.prosArgumentArr) {
        ZCPArgumentCellItem *argumentItem = [[ZCPArgumentCellItem alloc] initWithDefault];
        argumentItem.userHeadImgURL = model.user.userFaceURL;
        argumentItem.userName = model.user.userName;
        argumentItem.argumentContent = model.argumentContent;
        argumentItem.time = model.argumentTime;
        [items addObject:argumentItem];
    }
    
    // 反方 section
    ZCPSectionCellItem *sectionItem2 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem2.cellHeight = @20;
    sectionItem2.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem2.backgroundColor = [UIColor lightGrayColor];
    sectionItem2.sectionAttrTitle = [[NSAttributedString alloc] initWithString:@"反方观点" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont systemFontOfSize:14.0f]}];
    [items addObject:sectionItem2];
    
    for (ZCPArgumentModel *model in self.consArgumentArr) {
        ZCPArgumentCellItem *argumentItem = [[ZCPArgumentCellItem alloc] initWithDefault];
        argumentItem.userHeadImgURL = model.user.userFaceURL;
        argumentItem.userName = model.user.userName;
        argumentItem.argumentContent = model.argumentContent;
        argumentItem.time = model.argumentTime;
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
        BOOL argumentBelong = ZCPProsArgument;
        // 如果点击的是正方的cell
        if (indexPath.row > 0 && indexPath.row <= self.prosArgumentArr.count) {
            argumentBelong = ZCPProsArgument;
        }
        // 如果点击的是反方的cell
        else if (indexPath.row > self.prosArgumentArr.count + 1 && indexPath.row <= self.prosArgumentArr.count + self.consArgumentArr.count + 1) {
            argumentBelong = ZCPConsArgument;
        }
        [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_THESIS_ARGUMENTLIST paramDictForInit:@{@"_argumentBelong": [NSNumber numberWithBool:argumentBelong]}];
    }
}

#pragma mark - ZCPThesisView Delegate
- (void)thesisView:(ZCPThesisView *)thesisView didClickedCommentButton:(UIButton *)button {
    [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_THESIS_ADDARGUMENT paramDictForInit:nil];
}
- (void)thesisView:(ZCPThesisView *)thesisView didClickedCollectionButton:(UIButton *)button {
    NSLog(@"收藏");
}
- (void)thesisView:(ZCPThesisView *)thesisView didClickedSharedThesisButton:(UIButton *)button {
    [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_THESIS_ADDTHESIS paramDictForInit:nil];
}

@end
