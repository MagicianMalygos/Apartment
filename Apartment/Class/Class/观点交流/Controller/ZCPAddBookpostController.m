//
//  ZCPAddBookpostController.m
//  Apartment
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPAddBookpostController.h"
#import "ZCPSectionCell.h"
#import "ZCPTextViewCell.h"
#import "ZCPTextFieldCell.h"
#import "ZCPButtonCell.h"
#import "ZCPPickerView.h"
#import "ZCPRequestManager+Communion.h"

@interface ZCPAddBookpostController () <ZCPButtonCellDelegate>

@property (nonatomic, strong) NSArray *fieldArray;  // 领域数组

@end

@implementation ZCPAddBookpostController

- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        self.fieldArray = [params valueForKey:@"_fieldArray"];
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
    self.title = @"添加观点";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar - Height_TABBAR);
}
#pragma mark - Construct Data
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    // section 1
    ZCPSectionCellItem *sectionItem1 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem1.sectionTitle = @"标题";
    // 图书贴标题
    ZCPTextViewCellItem *titleItem = [[ZCPTextViewCellItem alloc] initWithDefault];
    titleItem.placeholder = @"请输入观点标题";
    titleItem.cellHeight = @(44);
    
    // section 2
    ZCPSectionCellItem *sectionItem2 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem2.sectionTitle = @"内容";
    // 图书贴内容
    ZCPTextViewCellItem *contentItem = [[ZCPTextViewCellItem alloc] initWithDefault];
    contentItem.placeholder = @"请输入观点内容";
    contentItem.cellHeight = @(200);
    
    ZCPSectionCellItem *sectionItem3 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem3.sectionTitle = @"其他信息";
    // 相关书名
    ZCPLabelTextFieldCellItem *bookNameItem = [[ZCPLabelTextFieldCellItem alloc] initWithDefault];
    bookNameItem.labelText = @"相关书名：";
    bookNameItem.textFieldConfigBlock = ^(UITextField *textField) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入相关图书名" attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:15.0f], NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    };
    // 领域
    ZCPPickerView *typePicker = getPicker(@[self.fieldArray]);
    ZCPLabelTextFieldCellItem *fieldItem = [[ZCPLabelTextFieldCellItem alloc] initWithDefault];
    fieldItem.labelText = @"类型";
    fieldItem.textFieldConfigBlock = ^(UITextField *textField) {
        textField.inputView = typePicker;
        typePicker.bindingTextField = textField;
        textField.keyboardType = UIKeyboardTypeAlphabet;
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请选择类型" attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:15.0f], NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    };
    
    ZCPLineCellItem *blankItem = [[ZCPLineCellItem alloc] initWithDefault];

    ZCPButtonCellItem *determineItem = [[ZCPButtonCellItem alloc] initWithDefault];
    determineItem.buttonTitle = @"提交";
    determineItem.delegate = self;
    
    [items addObject:sectionItem1];
    [items addObject:titleItem];
    [items addObject:sectionItem2];
    [items addObject:contentItem];
    [items addObject:sectionItem3];
    [items addObject:bookNameItem];
    [items addObject:fieldItem];
    [items addObject:blankItem];
    [items addObject:determineItem];
    
    self.tableViewAdaptor.items = items;
}

#pragma mark - ZCPButtonCellDelegate
- (void)cell:(UITableViewCell *)cell buttonClicked:(UIButton *)button {
    
    ZCPTextViewCellItem *titleItem = [self.tableViewAdaptor.items objectAtIndex:1];
    ZCPTextViewCellItem *contentItem = [self.tableViewAdaptor.items objectAtIndex:3];
    ZCPLabelTextFieldCellItem *bookNameItem = [self.tableViewAdaptor.items objectAtIndex:5];
    ZCPLabelTextFieldCellItem *typeItem = [self.tableViewAdaptor.items objectAtIndex:6];
    
    NSString *bookpostTitle = titleItem.textInputValue;
    NSString *bookpostContent = contentItem.textInputValue;
    NSString *bookpostBookName = bookNameItem.textInputValue;
    NSString *field = typeItem.textInputValue;
    
    // 空值检测
    if ([ZCPJudge judgeNullTextInput:bookpostTitle showErrorMsg:@"标题不能为空"]
        || [ZCPJudge judgeNullTextInput:bookpostContent showErrorMsg:@"简介不能为空"]
        || [ZCPJudge judgeNullTextInput:bookpostBookName showErrorMsg:@"书名不能为空"]
        || [ZCPJudge judgeNullTextInput:field showErrorMsg:@"类型不能为空"]) {
        return;
    }
    // 长度检测
    if ([ZCPJudge judgeOutOfRangeTextInput:bookpostTitle range:[ZCPLengthRange rangeWithMin:1 max:50] showErrorMsg:@"标题不能超过50字"]
        || [ZCPJudge judgeOutOfRangeTextInput:bookpostContent range:[ZCPLengthRange rangeWithMin:1 max:1000] showErrorMsg:@"内容不能超过1000字"]
        || [ZCPJudge judgeOutOfRangeTextInput:bookpostBookName range:[ZCPLengthRange rangeWithMin:1 max:50] showErrorMsg:@"书名不能超过50字"]) {
        return;
    }
    
    TTDPRINT(@"提交图书观点中...");
    [[ZCPRequestManager sharedInstance] addBookpostWithBookpostTitle:bookpostTitle bookpostContent:bookpostContent bookpostBookName:bookpostBookName currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId fieldID:[self.fieldArray indexOfObject:field] + 1 success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            TTDPRINT(@"提交图书观点成功！");
            [MBProgressHUD showSuccess:@"提交成功！" toView:[[UIApplication sharedApplication].delegate window]];
        }
        else {
            TTDPRINT(@"提交图书观点失败！");
            [MBProgressHUD showError:@"提交失败！" toView:[[UIApplication sharedApplication].delegate window]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"提交失败！%@", error);
        [MBProgressHUD showError:@"提交失败！网络异常！" toView:[[UIApplication sharedApplication].delegate window]];
    }];
    
    // pop
    [self.navigationController popViewControllerAnimated:YES];
}


@end
