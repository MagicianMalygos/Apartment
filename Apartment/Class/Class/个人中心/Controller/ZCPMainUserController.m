//
//  ZCPMainUserController.m
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPMainUserController.h"
#import "ZCPUserImageCell.h"
#import "ZCPSectionCell.h"
#import "ZCPImageTextCell.h"
#import "ZCPUserControllerHelper.h"
#import "ZCPUserFocusOnPeopleController.h"
#import "ZCPUserAchievementController.h"
#import "ZCPUserCollectionController.h"
#import "ZCPUserSettingController.h"
#import "ZCPUserAboutController.h"
#import "ZCPFieldModel.h"

@interface ZCPMainUserController () <ZCPImageTextSwitchCellItemDelegate>

@end

@implementation ZCPMainUserController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 设置nav
    [self clearNavigationBar];
    self.tabBarController.title = @"个人中心";
    
    // 重新刷新用户信息
    [self constructData];
    [self.tableView reloadData];
    // 设置背景颜色
    [self setThemeColor];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar - Height_TABBAR);
}

#pragma mark - constructData
- (void)constructData {
    
    ZCPUserModel *currUserModel = [ZCPUserCenter sharedInstance].currentUserModel;
    
    // 文字主题颜色
    UIColor *textColor = ([ZCPControlingCenter sharedInstance].appTheme == LightTheme)?LIGHT_TEXT_COLOR: NIGHT_TEXT_COLOR;
    
    // userImage
    ZCPUserImageCellItem *userImageItem = [[ZCPUserImageCellItem alloc] initWithDefault];
    userImageItem.cellHeight = @200;
    userImageItem.bgImageURL = currUserModel.userFaceURL;
    userImageItem.userHeadURL = currUserModel.userFaceURL;
    userImageItem.userName = currUserModel.userName;
    
    // BasicInfo Section
    ZCPSectionCellItem *sectionItem1 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem1.cellHeight = @20;
    sectionItem1.backgroundColor = [UIColor lightGrayColor];;
    sectionItem1.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem1.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"用户信息" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    
    // 年龄cell
    ZCPImageTextCellItem *ageItem = [[ZCPImageTextCellItem alloc] initWithDefault];
    ageItem.accessoryType = UITableViewCellAccessoryNone;
    ageItem.cellHeight = @50;
    ageItem.imageName = @"年龄.png";
    ageItem.text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"年龄：%lu", currUserModel.userAge] attributes:@{NSForegroundColorAttributeName: textColor}];
    // 文采值cell
    ZCPImageTextCellItem *expItem = [[ZCPImageTextCellItem alloc] initWithDefault];
    expItem.accessoryType = UITableViewCellAccessoryNone;
    expItem.cellHeight = @50;
    expItem.imageName = @"文采值.png";
    expItem.text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"文采值：%lu", currUserModel.userEXP] attributes:@{NSForegroundColorAttributeName: textColor}];
    // 称号cell
    ZCPImageTextCellItem *appellationItem = [[ZCPImageTextCellItem alloc] initWithDefault];
    appellationItem.accessoryType = UITableViewCellAccessoryNone;
    appellationItem.cellHeight = @50;
    appellationItem.imageName = @"称号.png";
    appellationItem.text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"称号：%@", currUserModel.userLevel] attributes:@{NSForegroundColorAttributeName: textColor}];
    
    // 成绩cell
    ZCPImageTextCellItem *scoreItem = [[ZCPImageTextCellItem alloc] initWithDefault];
    scoreItem.accessoryType = UITableViewCellAccessoryNone;
    scoreItem.cellHeight = @50;
    scoreItem.imageName = @"成绩.png";
    scoreItem.text = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"成绩：%lu", currUserModel.userScore] attributes:@{NSForegroundColorAttributeName: textColor}];
    
    // CommunityInfo Section
    ZCPSectionCellItem *sectionItem2 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem2.cellHeight = @20;
    sectionItem2.backgroundColor = [UIColor lightGrayColor];
    sectionItem2.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem2.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"社交信息" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    
    // 关注领域cell
    ZCPImageTextCellItem *fieldItem = [[ZCPImageTextCellItem alloc] initWithDefault];
    fieldItem.accessoryType = UITableViewCellAccessoryNone;
    fieldItem.cellHeight = @50;
    fieldItem.imageName = @"关注领域.png";
    NSMutableString *fields = [NSMutableString string];
    for (int i = 0; i < currUserModel.focusFieldArr.count; i++) {
        [fields appendString:((ZCPFieldModel *)[currUserModel.focusFieldArr objectAtIndex:i]).fieldName];
        if (i != currUserModel.focusFieldArr.count - 1) {
            [fields appendString:@"  "];
        }
    }
    fieldItem.text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"关注领域： %@", fields] attributes:@{NSForegroundColorAttributeName: textColor}];
    
    // 所关注人cell
    ZCPImageTextCellItem *peopleItem = [[ZCPImageTextCellItem alloc] initWithDefault];
    peopleItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    peopleItem.cellTag = ZCPUserFocusOnPeopleCellTag;
    peopleItem.cellHeight = @50;
    peopleItem.imageName = @"所关注人.png";
    peopleItem.text = [[NSMutableAttributedString alloc] initWithString:@"我关注的人" attributes:@{NSForegroundColorAttributeName: textColor}];
    
    // 个人成就
    ZCPImageTextCellItem *achievementItem = [[ZCPImageTextCellItem alloc] initWithDefault];
    achievementItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    achievementItem.cellTag = ZCPUserAchievementCellTag;
    achievementItem.cellHeight = @50;
    achievementItem.imageName = @"个人成就.png";
    achievementItem.text = [[NSMutableAttributedString alloc] initWithString:@"个人成就" attributes:@{NSForegroundColorAttributeName: textColor}];
    
    // 我的收藏
    ZCPImageTextCellItem *collectionItem = [[ZCPImageTextCellItem alloc] initWithDefault];
    collectionItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    collectionItem.cellTag = ZCPUserCollectionCellTag;
    collectionItem.cellHeight = @50;
    collectionItem.imageName = @"我的收藏.png";
    collectionItem.text = [[NSMutableAttributedString alloc] initWithString:@"我的收藏" attributes:@{NSForegroundColorAttributeName: textColor}];
    
    // Setting Section
    ZCPSectionCellItem *sectionItem3 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem3.cellHeight = @20;
    sectionItem3.backgroundColor = [UIColor lightGrayColor];;
    sectionItem3.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem3.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"设置" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    
    // 夜间模式设置cell
    ZCPImageTextSwitchCellItem *themeItem = [[ZCPImageTextSwitchCellItem alloc] initWithDefault];
    themeItem.accessoryType = UITableViewCellAccessoryNone;
    themeItem.cellHeight = @50;
    themeItem.imageName = @"夜间模式.png";
    themeItem.text = [[NSMutableAttributedString alloc] initWithString:@"夜间模式" attributes:@{NSForegroundColorAttributeName: textColor}];
    themeItem.switchResponser = self;
    
    // 设置
    ZCPImageTextCellItem *settingItem = [[ZCPImageTextCellItem alloc] initWithDefault];
    settingItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    settingItem.cellTag = ZCPUserSettingCellTag;
    settingItem.cellHeight = @50;
    settingItem.imageName = @"设置.png";
    settingItem.text = [[NSMutableAttributedString alloc] initWithString:@"个人设置" attributes:@{NSForegroundColorAttributeName: textColor}];
    
    // About Section
    ZCPSectionCellItem *sectionItem4 = [[ZCPSectionCellItem alloc] initWithDefault];
    sectionItem4.cellHeight = @20;
    sectionItem4.backgroundColor = [UIColor lightGrayColor];
    sectionItem4.titleEdgeInset = UIEdgeInsetsZero;
    sectionItem4.sectionAttrTitle = [[NSMutableAttributedString alloc] initWithString:@"其他" attributes:@{NSForegroundColorAttributeName: textColor, NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}];
    
    // 关于cell
    ZCPTextCellItem *aboutItem = [[ZCPTextCellItem alloc] initWithDefault];
    aboutItem.cellTag = ZCPUserAboutCellTag;
    aboutItem.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    aboutItem.cellHeight = @50;
    aboutItem.text = [[NSMutableAttributedString alloc] initWithString:@"关于" attributes:@{NSForegroundColorAttributeName: textColor}];
    
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:userImageItem];
    [items addObject:sectionItem1];
    [items addObject:ageItem];
    [items addObject:expItem];
    [items addObject:appellationItem];
    [items addObject:scoreItem];
    
    [items addObject:sectionItem2];
    [items addObject:fieldItem];
    [items addObject:peopleItem];
    [items addObject:achievementItem];
    [items addObject:collectionItem];
    
    [items addObject:sectionItem3];
    [items addObject:themeItem];
    [items addObject:settingItem];
    
    [items addObject:sectionItem4];
    [items addObject:aboutItem];
    
    self.tableViewAdaptor.items = items;
}

#pragma mark - ZCPListTableViewAdaptorDelegate
/**
 *  cell点击事件
 *
 *  @param tableView cell所属的tableview
 *  @param object    cellItem
 *  @param indexPath cell索引
 */
- (void)tableView:(UITableView *)tableView didSelectObject:(id<ZCPTableViewCellItemBasicProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    switch (object.cellTag) {
        case ZCPUserFocusOnPeopleCellTag:
            [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_USER_FOCUSON_PEOPLE
                                                 paramDictForInit:@{@"_currUserID": @([ZCPUserCenter sharedInstance].currentUserModel.userId)}];
            break;
        case ZCPUserAchievementCellTag:
            [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_USER_ACHIEVEMENT
                                                 paramDictForInit:@{@"_currUserID": @([ZCPUserCenter sharedInstance].currentUserModel.userId)}];
            break;
        case ZCPUserCollectionCellTag:
            [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_USER_COLLECTION
                                                 paramDictForInit:@{@"_currUserID": @([ZCPUserCenter sharedInstance].currentUserModel.userId)}];
            break;
        case ZCPUserSettingCellTag:
            [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_USER_SETTING
                                                 paramDictForInit:nil];
            break;
        case ZCPUserAboutCellTag:
            [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_USER_ABOUT
                                                 paramDictForInit:nil];
            break;
        default:
            break;
    }
}

#pragma mark - ZCPImageTextSwitchCellItemDelegate
/**
 *  夜间模式开关值改变响应事件
 *
 *  @param cell       cell
 *  @param switchView 夜间模式开关
 */
- (void)cell:(ZCPImageTextSwitchCell *)cell switchValueChanged:(UISwitch *)switchView {
    if (!switchView.on) {
        [[ZCPControlingCenter sharedInstance] setAppTheme:LightTheme];
    }
    else {
        [[ZCPControlingCenter sharedInstance] setAppTheme:DarkTheme];
    }
    
    // 设置背景颜色
    [self setThemeColor];
    
    // 重新刷新用户信息，更新颜色
    [self constructData];
    [self.tableView reloadData];
}

#pragma mark - private method
- (void)setThemeColor {
    // 设置主题颜色
    if ([ZCPControlingCenter sharedInstance].appTheme == LightTheme) {
        [self.tableView setBackgroundColor:LIGHT_BG_COLOR];
    }
    else if([ZCPControlingCenter sharedInstance].appTheme == DarkTheme) {
        [self.tableView setBackgroundColor:NIGHT_BG_COLOR];
    }
}

@end
