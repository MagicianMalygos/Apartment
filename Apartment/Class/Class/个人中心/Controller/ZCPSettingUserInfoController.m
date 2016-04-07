//
//  ZCPSettingUserInfoController.m
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPSettingUserInfoController.h"
#import "ZCPSectionCell.h"
#import "ZCPTextFieldCell.h"
#import "ZCPButtonCell.h"
#import "ZCPPickerView.h"
#import "ZCPRequestManager+User.h"
#import "ZCPFieldModel.h"

@interface ZCPSettingUserInfoController () <ZCPButtonCellDelegate>

@property (nonatomic, strong) NSMutableArray *fieldArray;  // 领域数组

@end

@implementation ZCPSettingUserInfoController

#pragma mark - init
- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super initWithParams:params]) {
        WEAK_SELF;
        [[ZCPRequestManager sharedInstance] getFieldListSuccess:^(AFHTTPRequestOperation *operation, ZCPListDataModel *fieldListModel) {
            STRONG_SELF;
            for (ZCPFieldModel *model in fieldListModel.items) {
                [weakSelf.fieldArray addObject:model.fieldName];
            }
            [self constructData];
            [self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            TTDPRINT(@"%@", error);
        }];
    }
    return self;
}

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"修改个人信息";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar);
}

#pragma mark - Construct Data
- (void)constructData {
    
    // 文字主题颜色
    UIColor *textColor = (self.appTheme == LightTheme)?[UIColor blackColor]:[UIColor whiteColor];
    
    ZCPSectionCellItem *sectionItem1 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem1.backgroundColor = [UIColor lightGrayColor];
    sectionItem1.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem1.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"修改信息" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    // 昵称
    ZCPTextFieldCellItem *nameItem = [[ZCPTextFieldCellItem alloc] initWithDefault];
    nameItem.textFieldConfigBlock = ^(UITextField *textField) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入昵称" attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:15.0f], NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
        textField.text = [ZCPUserCenter sharedInstance].currentUserModel.userName;
    };
    // 年龄
    ZCPTextFieldCellItem *ageItem = [[ZCPTextFieldCellItem alloc] initWithDefault];
    ageItem.textFieldConfigBlock = ^(UITextField *textField) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入年龄" attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:15.0f], NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
        textField.text = [NSString stringWithFormat:@"%li", [ZCPUserCenter sharedInstance].currentUserModel.userAge];
    };
    
    ZCPSectionCellItem *sectionItem2 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem2.backgroundColor = [UIColor lightGrayColor];
    sectionItem2.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem2.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"修改领域" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    // 领域
    ZCPPickerView *fieldPicker = getPicker(@[self.fieldArray, self.fieldArray, self.fieldArray]);
    ZCPTextFieldCellItem *fieldItem = [[ZCPTextFieldCellItem alloc] initWithDefault];
    fieldItem.textFieldConfigBlock = ^(UITextField *textField) {
        textField.inputView = fieldPicker;
        fieldPicker.bindingTextField = textField;
        textField.keyboardType = UIKeyboardTypeAlphabet;
        
        NSString *fieldString = @"";
        WEAK_SELF;
        for (int i = 0; i < [ZCPUserCenter sharedInstance].currentUserModel.focusFieldArr.count; i++) {
            ZCPFieldModel *fieldModel = [ZCPUserCenter sharedInstance].currentUserModel.focusFieldArr[i];
            fieldString = [fieldString stringByAppendingString:fieldModel.fieldName];
            if (i != [ZCPUserCenter sharedInstance].currentUserModel.focusFieldArr.count - 1) {
                fieldString = [fieldString stringByAppendingString:@" "];
            }
            
            NSInteger selectedRow = [weakSelf.fieldArray indexOfObject:fieldModel.fieldName];
            ZCPLengthRange *range = [ZCPLengthRange rangeWithMin:0 max:[(NSArray *)fieldPicker.optionsArr[i] count]];
            if ([range numberInRange:selectedRow]) {
                [fieldPicker.pickerView selectRow:selectedRow inComponent:i animated:NO];
            }
        }
        textField.text = fieldString;
    };
    
    ZCPLineCellItem *blankItem = [[ZCPLineCellItem alloc] initWithDefault];
    // 退出登录
    ZCPButtonCellItem *determineItem = [[ZCPButtonCellItem alloc] initWithDefault];
    determineItem.cellHeight = @45;
    determineItem.buttonTitle = @"确认";
    determineItem.delegate = self;
    
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:sectionItem1];
    [items addObject:nameItem];
    [items addObject:ageItem];
    
    [items addObject:sectionItem2];
    [items addObject:fieldItem];
    
    [items addObject:blankItem];
    [items addObject:determineItem];
    self.tableViewAdaptor.items = items;
}

#pragma mark - getter / setter
- (NSMutableArray *)fieldArray {
    if (_fieldArray == nil) {
        _fieldArray = [NSMutableArray array];
    }
    return _fieldArray;
}

#pragma mark - ZCPButtonCell Delegate
- (void)cell:(UITableViewCell *)cell buttonClicked:(UIButton *)button {
    [[ZCPRequestManager sharedInstance] modifyUserInfoWithNewUserName:@"zcp" newUserAge:10 oldFieldIDArr:@[@(1), @(2), @(3)] newFieldIDArr:@[@(4), @(5), @(6)] currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
    }];
}

@end
