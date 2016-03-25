//
//  ZCPUserSettingController.m
//  Apartment
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPUserSettingController.h"
#import "ZCPSectionCell.h"
#import "ZCPButtonCell.h"
#import "ZCPImageTextCell.h"
#import "ZCPHeadImageCell.h"
#import "ZCPUserCenter.h"
#import "ZCPRequestManager+User.h"

@interface ZCPUserSettingController() <ZCPButtonCellDelegate, ZCPHeadImageCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIAlertController *actionSheet;       // 菜单视图
@property (nonatomic, strong) UIImagePickerController *imagePicker; // 图片选择器

@end

@implementation ZCPUserSettingController

#pragma mark - synthesize
@synthesize actionSheet     = _actionSheet;
@synthesize imagePicker     = _imagePicker;

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self constructData];
    [self.tableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"用户设置";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar);
}
#pragma mark - constructData
- (void)constructData {
    
    // 文字主题颜色
    UIColor *textColor = (self.appTheme == LightTheme)?[UIColor blackColor]:[UIColor whiteColor];
    
    // User Head Section
    ZCPSectionCellItem *sectionItem1 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem1.cellHeight = @20;
    sectionItem1.backgroundColor = [UIColor lightGrayColor];
    sectionItem1.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem1.sectionAttrTitle = [[NSAttributedString alloc] initWithString:@"修改头像" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    // 头像cell
    ZCPHeadImageCellItem *headItem = [[ZCPHeadImageCellItem alloc] initWithDefault];
    headItem.cellHeight = @150;
    headItem.headImageURL = [ZCPUserCenter sharedInstance].currentUserModel.userFaceURL;
    headItem.delegate = self;
    
    // Setting Section
    ZCPSectionCellItem *sectionItem2 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem2.cellHeight = @20;
    sectionItem2.backgroundColor = [UIColor lightGrayColor];
    sectionItem2.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem2.sectionAttrTitle = [[NSAttributedString alloc] initWithString:@"修改信息" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    
    // 修改个人资料
    ZCPTextCellItem *userInfoItem = [[ZCPTextCellItem alloc] initWithDefault];
    userInfoItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    userInfoItem.cellTag = ZCPSettingUserInfoCellTag;
    userInfoItem.cellHeight = @50;
    userInfoItem.text = [[NSMutableAttributedString alloc] initWithString:@"修改个人资料" attributes:@{NSForegroundColorAttributeName: textColor}];
    
    // 修改密码
    ZCPTextCellItem *changePwd = [[ZCPTextCellItem alloc] initWithDefault];
    changePwd.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    changePwd.cellTag = ZCPSettingChangePwdCellTag;
    changePwd.cellHeight = @50;
    changePwd.text = [[NSMutableAttributedString alloc] initWithString:@"修改密码" attributes:@{NSForegroundColorAttributeName: textColor}];
    
    // 修改密保
    ZCPTextCellItem *changeSecurity = [[ZCPTextCellItem alloc] initWithDefault];
    changeSecurity.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    changeSecurity.cellTag = ZCPSettingChangeSecurityCellTag;
    changeSecurity.cellHeight = @50;
    changeSecurity.text = [[NSMutableAttributedString alloc] initWithString:@"修改密保" attributes:@{NSForegroundColorAttributeName: textColor}];
    
    ZCPLineCellItem *blankItem = [[ZCPLineCellItem alloc] initWithDefault];
    
    // 退出登录
    ZCPButtonCellItem *logoutItem = [[ZCPButtonCellItem alloc] initWithDefault];
    logoutItem.cellHeight = @45;
    logoutItem.buttonTitle = @"退出登录";
    logoutItem.delegate = self;
    
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:sectionItem1];
    [items addObject:headItem];

    [items addObject:sectionItem2];
    [items addObject:userInfoItem];
    [items addObject:changePwd];
    [items addObject:changeSecurity];
    
    [items addObject:blankItem];
    [items addObject:logoutItem];
    self.tableViewAdaptor.items = items;
}
#pragma mark - getter / setter
- (UIAlertController *)actionSheet {
    if (_actionSheet == nil) {
        _actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        // 初始化Action
        if (CAMERA_AVAILABLE) {
            WEAK_SELF;
            UIAlertAction * takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                STRONG_SELF;
                // 资源类型为照相机
                weakSelf.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                // 跳转到相机视图控制器
                [self presentViewController:weakSelf.imagePicker animated:YES completion:nil];
                TTDPRINT(@"打开相机");
            }];
            [_actionSheet addAction:takePhotoAction];
        } else if (PHOTO_LIBRARY_AVAILABLE) {
            WEAK_SELF;
            UIAlertAction *openAlbumAction = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                STRONG_SELF;
                // 资源类型为图片库
                weakSelf.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                // 跳转到相册视图控制器
                [self presentViewController:weakSelf.imagePicker animated:YES completion:nil];
                TTDPRINT(@"打开相册");
            }];
            [_actionSheet addAction:openAlbumAction];
        }
        // 取消按钮
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [_actionSheet addAction:cancelAction];
    }
    return _actionSheet;
}
- (UIImagePickerController *)imagePicker {
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        _imagePicker.navigationBar.barTintColor = [UIColor lightGrayColor];
        _imagePicker.navigationBar.tintColor = [UIColor blueColor];
        
        
    }
    return _imagePicker;
}

#pragma mark - ZCPListTableViewAdaptorDelegate
/**
 *  cell点击响应方法
 */
- (void)tableView:(UITableView *)tableView didSelectObject:(id<ZCPTableViewCellItemBasicProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    switch (object.cellTag) {
        case ZCPSettingUserInfoCellTag:
            [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_USER_SETTING_USERINFO
                                                 paramDictForInit:nil];
            break;
        case ZCPSettingChangePwdCellTag:
            [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_USER_SETTING_CHANGEPWD
                                                 paramDictForInit:nil];
            break;
        case ZCPSettingChangeSecurityCellTag:
            [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_USER_SETTING_CHANGESECURITY
                                                 paramDictForInit:nil];
            break;
        default:
            break;
    }
}

#pragma mark - ZCPButtonCell Delegate
/**
 *  退出登陆按钮点击响应方法
 */
- (void)cell:(UITableViewCell *)cell buttonClicked:(UIButton *)button {
    TTDPRINT(@"退出登陆");
}
#pragma mark - ZCPHeadImageCell Delegate
/**
 *  用户头像按钮点击响应方法
 */
- (void)cell:(UITableViewCell *)cell headImageButtonClicked:(UIButton *)button {
    TTDPRINT(@"显示菜单");
    
    // 显示ActionSheet
    [self presentViewController:self.actionSheet animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
/**
 *  点击图片响应事件
 *
 *  @param picker 相册视图控制器
 *  @param info   点击图片信息
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    TTDPRINT(@"所选图片信息：%@", info);
    if ([[info valueForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
        UIImage *selectedImage = [info valueForKey:UIImagePickerControllerOriginalImage];
        
        [[ZCPRequestManager sharedInstance] uploadUserHeadImage:selectedImage currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, UIImage *headImage, ZCPUserModel *userModel) {
            if (userModel && [userModel isKindOfClass:[ZCPUserModel class]]) {
                // 更新用户信息
                [[ZCPUserCenter sharedInstance] saveUserModel:(ZCPUserModel *)userModel];
                
                // 更新tableview（全局更新，可优化为局部更新）
                [self constructData];
                [self.tableView reloadData];
            }
            else {
                TTDPRINT(@"上传图片失败！");
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            TTDPRINT(@"上传图片失败！%@", error);
        }];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UIViewController Category
- (void)backTo {
    [super backTo];
    NSLog(@"Back");
}

@end
