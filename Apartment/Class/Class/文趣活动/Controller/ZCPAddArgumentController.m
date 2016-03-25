//
//  ZCPAddArgumentController.m
//  Apartment
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPAddArgumentController.h"

#import "ZCPSectionCell.h"
#import "ZCPTextViewCell.h"
#import "ZCPSwitchRadioCell.h"
#import "ZCPButtonCell.h"
#import "ZCPArgumentModel.h"
#import "ZCPRequestManager+Thesis.h"

@interface ZCPAddArgumentController () <ZCPButtonCellDelegate>

@property (nonatomic, assign) NSInteger currThesisID;       // 当前显示辩题ID

@end

@implementation ZCPAddArgumentController

#pragma mark - synthesize
@synthesize currThesisID    = _currThesisID;

#pragma mark - init
- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        _currThesisID = [(NSNumber *)[params objectForKey:@"_currThesisID"] boolValue];
    }
    return self;
}

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"发表观点";
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
    sectionItem.sectionTitle = @"输入论据内容";
    // 论据内容
    ZCPTextViewCellItem *argumentItem = [[ZCPTextViewCellItem alloc] initWithDefault];
    argumentItem.placeholder = @"请输入论据内容,不超过50字...";
    // 选项Item
    ZCPSwitchRadioCellItem *optionItem = [[ZCPSwitchRadioCellItem alloc] initWithDefault];
    optionItem.switchInitialValue = NO;
    optionItem.switchTipText = @"匿名";
    optionItem.radioTipTextOne = @"正方";
    optionItem.radioTipTextTwo = @"反方";
    optionItem.radioButtonOneConfigBlock = ^(UIButton *button) {
        [button setImageNameNormal:@"choice_normal" Highlighted:@"choice_selected" Selected:@"choice_selected" Disabled:@"choice_normal"];
    };
    optionItem.radioButtonTwoConfigBlock = ^(UIButton *button) {
        [button setImageNameNormal:@"choice_normal" Highlighted:@"choice_selected" Selected:@"choice_selected" Disabled:@"choice_normal"];
    };
    
    // blankItem
    ZCPLineCellItem *blankItem = [[ZCPLineCellItem alloc] initWithDefault];
    // 提交按钮
    ZCPButtonCellItem *determineItem = [[ZCPButtonCellItem alloc] initWithDefault];
    determineItem.buttonTitle = @"提交";
    determineItem.delegate = self;
    
    [items addObject:sectionItem];
    [items addObject:argumentItem];
    [items addObject:optionItem];
    
    [items addObject:blankItem];
    [items addObject:determineItem];
    self.tableViewAdaptor.items = items;
}

#pragma mark - ZCPButtonCellDelegate
/**
 *  提交按钮响应事件
 *
 *  @param cell   buttonCell
 *  @param button 提交按钮
 */
- (void)cell:(UITableViewCell *)cell buttonClicked:(UIButton *)button {
    
    ZCPTextViewCellItem *textViewItem = [self.tableViewAdaptor.items objectAtIndex:1];
    ZCPSwitchRadioCellItem *switchRadioItem = [self.tableViewAdaptor.items objectAtIndex:2];
    
    NSString *argumentContent = textViewItem.textInputValue;
    NSInteger argumentBelong = (switchRadioItem.selectedRadioTipIndex == 0)? ZCPProsArgument: ZCPConsArgument;
    BOOL isAnonymous = switchRadioItem.switchValue;
    
    // 如果未通过输入检测则不进行提交
    if ([ZCPJudge judgeNullTextInput:argumentContent showErrorMsg:@"观点不能为空！"]
        || [ZCPJudge judgeOutOfRangeTextInput:argumentContent range:[ZCPLengthRange rangeWithMin:1 max:500] showErrorMsg:@"字数不得超过500字！"]) {
        return;
    }
    
    TTDPRINT(@"发表观点中...");
    [[ZCPRequestManager sharedInstance] addArgumentContent:argumentContent argumentBelong:argumentBelong isAnonymous:isAnonymous currThesisID:self.currThesisID currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            TTDPRINT(@"提交成功！！");
            [MBProgressHUD showSuccess:@"观点发表成功！" toView:[[UIApplication sharedApplication].delegate window]];
        }
        else {
            TTDPRINT(@"提交失败！！");
            [MBProgressHUD showError:@"观点发表失败！" toView:[[UIApplication sharedApplication].delegate window]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"提交失败！网络异常！%@", error);
        [MBProgressHUD showError:@"观点发表失败！网络异常！" toView:[[UIApplication sharedApplication].delegate window]];
    }];
    
    // pop
    [self.navigationController popViewControllerAnimated:YES];
}

@end
