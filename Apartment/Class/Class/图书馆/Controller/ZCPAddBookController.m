//
//  ZCPAddBookController.m
//  Apartment
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPAddBookController.h"

#import "ZCPSectionCell.h"
#import "ZCPAddPictureCell.h"
#import "ZCPTextFieldCell.h"
#import "ZCPTextViewCell.h"
#import "ZCPDatePicker.h"
#import "ZCPPickerView.h"

#define YearSecond (12.0 * 30.0 * 24.0 * 60.0 * 60.0)

@interface ZCPAddBookController ()

@end

@implementation ZCPAddBookController

#pragma mark - instancetype
- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
    }
    return self;
}

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self clearNavigationBar];
    self.tabBarController.title = @"上传图书";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar);
}

#pragma mark - Construct Data
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    ZCPAddPictureCellItem *addpictureItem = [[ZCPAddPictureCellItem alloc] initWithDefault];
    addpictureItem.tipText = @"添加图书封面";
    
    // sectionItem 1
    ZCPSectionCellItem *sectionItem1 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem1.sectionTitle = @"基本信息";
    // 书名
    ZCPLabelTextFieldCellItem *nameItem = [[ZCPLabelTextFieldCellItem alloc] initWithDefault];
    nameItem.labelText = @"书名：";
    // 作者
    ZCPLabelTextFieldCellItem *authorItem = [[ZCPLabelTextFieldCellItem alloc] initWithDefault];
    authorItem.labelText = @"作者：";
    // 出版社
    ZCPLabelTextFieldCellItem *publisherItem = [[ZCPLabelTextFieldCellItem alloc] initWithDefault];
    publisherItem.labelText = @"出版社：";
    // 出版时间
    UIDatePicker *datePicker = getDatePicker();
    ZCPLabelTextFieldCellItem *publishTimeItem = [[ZCPLabelTextFieldCellItem alloc] initWithDefault];
    publishTimeItem.labelText = @"出版时间：";
    publishTimeItem.textFieldConfigBlock = ^(UITextField *textField) {
        textField.inputView = datePicker;
        textField.keyboardType = UIKeyboardTypeAlphabet;
    };
    // 所属类型
    ZCPPickerView *typePicker = getPicker();
    ZCPLabelTextFieldCellItem *fieldItem = [[ZCPLabelTextFieldCellItem alloc] initWithDefault];
    fieldItem.labelText = @"类型：";
    fieldItem.textFieldConfigBlock = ^(UITextField *textField) {
        textField.inputView = typePicker;
        textField.keyboardType = UIKeyboardTypeAlphabet;
    };
    
    ZCPSectionCellItem *sectionItem2 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem2.sectionTitle = @"简介";
    // 简介
    ZCPTextViewCellItem *summaryItem = [[ZCPTextViewCellItem alloc] initWithDefault];
    
    [items addObject:addpictureItem];
    [items addObject:sectionItem1];
    [items addObject:nameItem];
    [items addObject:authorItem];
    [items addObject:publisherItem];
    [items addObject:publishTimeItem];
    [items addObject:fieldItem];
    
    [items addObject:sectionItem2];
    [items addObject:summaryItem];
    
    self.tableViewAdaptor.items = items;
}

#pragma mark - Create Picker
/**
 *  创建DatePicker
 */
UIDatePicker *getDatePicker() {
    ZCPDatePicker *datePicker = [[ZCPDatePicker alloc] initWithFrame: CGRectMake(0, 0, APPLICATIONWIDTH, 240)];
    
    datePicker.minimumDate = datePicker.date;
    datePicker.maximumDate = [NSDate dateWithTimeInterval:YearSecond sinceDate:datePicker.date];
    datePicker.datePickerMode = UIDatePickerModeDate;
    return datePicker;
}
ZCPPickerView *getPicker() {
    ZCPPickerView *pickerView = [[ZCPPickerView alloc] initWithFrame:CGRectMake(0, 0, APPLICATIONWIDTH, 200)];
    pickerView.optionsArr = @[@[@"娱乐", @"军事", @"动画"]];
    return pickerView;
}

@end
