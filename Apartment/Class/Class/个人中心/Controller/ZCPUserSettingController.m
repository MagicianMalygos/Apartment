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

@interface ZCPUserSettingController() <ZCPButtonCellDelegate, ZCPHeadImageCellDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ZCPUserSettingController

#pragma mark - life circle
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
    // 菜单视图
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开相册", nil];
    [sheet showInView:self.tableView];
}
#pragma mark - UIActionSheetDelegate
/**
 *  菜单视图选项按钮点击响应方法
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        TTDPRINT(@"打开相册");
        // 相册视图控制器
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;      // 资源类型为图片库
        
        // 跳转到相册视图控制器
        // 此处不能使用navigationController的push方法进行跳转，否则会crash
//        [self.navigationController pushViewController:picker animated:YES];
        [self presentViewController:picker animated:YES completion:nil];
    }
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
        
        [[ZCPRequestManager sharedInstance] uploadUserHeadImage:selectedImage
                                                         userID:[ZCPUserCenter sharedInstance].currentUserModel.userId
                                                        success:^(AFHTTPRequestOperation *operation, UIImage *headImage, ZCPDataModel *userModel) {
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
                                                        }
                                                        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                            TTDPRINT(@"上传图片失败");
                                                        }];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
/**
 *  点击取消按钮
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewController Category
- (void)backTo {
    [super backTo];
    NSLog(@"Back");
}

@end
