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
#import "ZCPButtonCell.h"
#import "ZCPDatePicker.h"
#import "ZCPPickerView.h"
#import "ZCPRequestManager+Library.h"

#define YearSecond (12.0 * 30.0 * 24.0 * 60.0 * 60.0)

@interface ZCPAddBookController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, ZCPButtonCellDelegate>

@property (nonatomic, strong) NSArray *fieldArray;  // 领域数组

@end

@implementation ZCPAddBookController

#pragma mark - synthesize
@synthesize fieldArray  = _fieldArray;

#pragma mark - instancetype
- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        self.fieldArray = [params valueForKey:@"_fieldArray"];
    }
    return self;
}

#pragma mark - life cycle
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
    addpictureItem.tipText = @"点击添加图书封面";
    
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
    ZCPDatePicker *datePicker = getDatePicker();
    ZCPLabelTextFieldCellItem *publishTimeItem = [[ZCPLabelTextFieldCellItem alloc] initWithDefault];
    publishTimeItem.labelText = @"出版时间：";
    publishTimeItem.textFieldConfigBlock = ^(UITextField *textField) {
        textField.inputView = datePicker;
        datePicker.bindingTextField = textField;    // 进行单向绑定
        textField.keyboardType = UIKeyboardTypeAlphabet;
    };
    // 所属类型
    ZCPPickerView *typePicker = getPicker(self.fieldArray);
    ZCPLabelTextFieldCellItem *fieldItem = [[ZCPLabelTextFieldCellItem alloc] initWithDefault];
    fieldItem.labelText = @"类型：";
    fieldItem.textFieldConfigBlock = ^(UITextField *textField) {
        textField.inputView = typePicker;
        typePicker.bindingTextField = textField;    // 进行单向绑定
        textField.keyboardType = UIKeyboardTypeAlphabet;
    };
    
    ZCPSectionCellItem *sectionItem2 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem2.sectionTitle = @"简介";
    // 简介
    ZCPTextViewCellItem *summaryItem = [[ZCPTextViewCellItem alloc] initWithDefault];
    
    ZCPLineCellItem *blankItem = [[ZCPLineCellItem alloc] initWithDefault];
    ZCPButtonCellItem *determineItem = [[ZCPButtonCellItem alloc] initWithDefault];
    determineItem.buttonTitle = @"提交";
    determineItem.delegate = self;
    
    [items addObject:addpictureItem];
    [items addObject:sectionItem1];
    [items addObject:nameItem];
    [items addObject:authorItem];
    [items addObject:publisherItem];
    [items addObject:publishTimeItem];
    [items addObject:fieldItem];
    
    [items addObject:sectionItem2];
    [items addObject:summaryItem];
    
    [items addObject:blankItem];
    [items addObject:determineItem];

    self.tableViewAdaptor.items = items;
}

#pragma mark - ZCPListTableViewAdaptorDelegate
/**
 *  cell点击事件
 */
- (void)tableView:(UITableView *)tableView didSelectObject:(id<ZCPTableViewCellItemBasicProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    if ([object isKindOfClass:[ZCPAddPictureCellItem class]]) {
        [self showSelectPhotoMenu];
    }
}
#pragma mark - UIImagePickerControllerDelegate 
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originalImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    WEAK_SELF;
    [picker dismissViewControllerAnimated:YES completion:^{
        ZCPAddPictureCellItem *addpictureItem = [weakSelf.tableViewAdaptor.items objectAtIndex:0];
        addpictureItem.uploadImage = originalImage;
        addpictureItem.tipText = @"已选择图书封面";
        [weakSelf.tableView reloadData];
    }];
}
#pragma mark - ZCPButtonCellDelegate
- (void)cell:(UITableViewCell *)cell buttonClicked:(UIButton *)button {
    
    ZCPAddPictureCellItem *addpictureItem = [self.tableViewAdaptor.items objectAtIndex:0];
    ZCPLabelTextFieldCellItem *nameItem = [self.tableViewAdaptor.items objectAtIndex:2];
    ZCPLabelTextFieldCellItem *authorItem = [self.tableViewAdaptor.items objectAtIndex:3];
    ZCPLabelTextFieldCellItem *publisherItem = [self.tableViewAdaptor.items objectAtIndex:4];
    ZCPLabelTextFieldCellItem *publishTimeItem = [self.tableViewAdaptor.items objectAtIndex:5];
    ZCPLabelTextFieldCellItem *fieldItem = [self.tableViewAdaptor.items objectAtIndex:6];
    ZCPTextFieldCellItem *summaryItem = [self.tableViewAdaptor.items objectAtIndex:8];
    
    UIImage *uploadImage = addpictureItem.uploadImage;
    NSString *name = nameItem.textInputValue;
    NSString *author = authorItem.textInputValue;
    NSString *publisher = publisherItem.textInputValue;
    NSString *publishTime = publishTimeItem.textInputValue;
    NSString *field = fieldItem.textInputValue;
    NSString *summary = summaryItem.textInputValue;
    
    // 空值检测
    if ([ZCPJudge judgeNullObject:uploadImage showErrorMsg:@"请选择一张封面！" toView:self.view]
        || [ZCPJudge judgeNullTextInput:name showErrorMsg:@"书名不能为空！" toView:self.view]
        || [ZCPJudge judgeNullTextInput:author showErrorMsg:@"作者不能为空！" toView:self.view]
        || [ZCPJudge judgeNullTextInput:publisher showErrorMsg:@"出版社不能为空" toView:self.view]
        || [ZCPJudge judgeNullTextInput:field showErrorMsg:@"类型不能为空！" toView:self.view]
        || [ZCPJudge judgeNullTextInput:summary showErrorMsg:@"简介不能为空！" toView:self.view]) {
        return;
    }
    if ([ZCPJudge judgeWrongDateString:publishTime]) {
        return;
    }
    if ([ZCPJudge judgeOutOfRangeTextInput:name range:[ZCPLengthRange rangeWithMin:1 max:30] showErrorMsg:@"书名不能超过30字" toView:self.view]
        || [ZCPJudge judgeOutOfRangeTextInput:author range:[ZCPLengthRange rangeWithMin:1 max:30] showErrorMsg:@"作者不能超过30字" toView:self.view]
        || [ZCPJudge judgeOutOfRangeTextInput:publisher range:[ZCPLengthRange rangeWithMin:1 max:30] showErrorMsg:@"出版社不能超过30字" toView:self.view]
        || [ZCPJudge judgeOutOfRangeTextInput:summary range:[ZCPLengthRange rangeWithMin:1 max:1000] showErrorMsg:@"简介不能超过30字" toView:self.view]) {
        return;
    }
    
    TTDPRINT(@"开始上传图书...");
    [[ZCPRequestManager sharedInstance] addBookCoverImage:uploadImage bookName:name bookAuthor:author bookPublisher:publisher bookPublishTime:publishTime bookSummary:summary fieldID:[self.fieldArray indexOfObject:field] + 1/*此处可能会有坑*/ currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            TTDPRINT(@"提交图书成功！正在审核中！");
            [MBProgressHUD showSuccess:@"提交图书成功！正在审核中！" toView:[[UIApplication sharedApplication].delegate window]];
        } else {
            TTDPRINT(@"提交图书失败！");
            [MBProgressHUD showError:@"提交图书失败！" toView:[[UIApplication sharedApplication].delegate window]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"提交失败！%@", error);
        [MBProgressHUD showError:@"提交图书失败！网络异常！" toView:[[UIApplication sharedApplication].delegate window]];
    }];
    
    TTDPRINT(@"上传图书成功!");
}

#pragma mark - private method
/**
 *  显示选择图片菜单
 */
- (void)showSelectPhotoMenu {
    // menu
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"选择一张图书封面" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (CAMERA_AVAILABLE) {
            UIImagePickerController *imagePicker = getImagePicker(self, UIImagePickerControllerSourceTypeCamera);
            [self presentViewController:imagePicker animated:YES completion:nil];
        } else {
            TTDPRINT(@"相机不可用！");
        }
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (PHOTO_LIBRARY_AVAILABLE) {
            UIImagePickerController *imagePicker = getImagePicker(self, UIImagePickerControllerSourceTypePhotoLibrary);
            [self presentViewController:imagePicker animated:YES completion:nil];
        } else {
            TTDPRINT(@"相册不可用！");
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [actionSheet addAction:cameraAction];
    [actionSheet addAction:albumAction];
    [actionSheet addAction:cancelAction];
    
    // present menu
    [self presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark - Create Picker
/**
 *  时间选择器
 */
ZCPDatePicker *getDatePicker() {
    ZCPDatePicker *datePicker = [[ZCPDatePicker alloc] initWithFrame: CGRectMake(0, 0, APPLICATIONWIDTH, 240)];
    
    datePicker.minimumDate = [NSDate dateFromString:@"1800-01-01"];
    datePicker.maximumDate = [NSDate dateFromString:@"2100-01-01"];
    datePicker.datePickerMode = UIDatePickerModeDate;
    return datePicker;
}
/**
 *  自定义选择器
 */
ZCPPickerView *getPicker(NSArray *optionsArr) {
    ZCPPickerView *pickerView = [[ZCPPickerView alloc] initWithFrame:CGRectMake(0, 0, APPLICATIONWIDTH, 200)];
    pickerView.optionsArr = optionsArr? @[optionsArr]: @[[NSArray array]];
    return pickerView;
}
/**
 *  图片选择器
 */
UIImagePickerController *getImagePicker(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>delegate, UIImagePickerControllerSourceType sourceType) {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = delegate;
    imagePicker.sourceType = sourceType;
    imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    imagePicker.navigationBar.barTintColor = [UIColor lightGrayColor];
    imagePicker.navigationBar.tintColor = [UIColor whiteColor];
    
    return imagePicker;
}

@end
