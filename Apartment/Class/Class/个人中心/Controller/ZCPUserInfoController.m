//
//  ZCPUserInfoController.m
//  Apartment
//
//  Created by apple on 16/4/8.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPUserInfoController.h"
#import "ZCPUserImageCell.h"
#import "ZCPSectionCell.h"
#import "ZCPImageTextCell.h"
#import "ZCPButtonCell.h"

@interface ZCPUserInfoController ()

@property (nonatomic, strong) ZCPUserModel *currUserModel;  // 当前用户模型

@end

@implementation ZCPUserInfoController

#pragma mark - init
- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super initWithParams:params]) {
        _currUserModel = [params valueForKey:@"_currUserModel"];
    }
    return self;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 设置nav
    [self clearNavigationBar];
    self.title = self.currUserModel.userName;
    
    // 重新刷新用户信息
    [self constructData];
    [self.tableView reloadData];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar);
    
    self.appTheme = [[ZCPControlingCenter sharedInstance] appTheme];
    if (self.appTheme == LightTheme) {
        [self.tableView setBackgroundColor:[UIColor colorFromHexRGB:@"ececec"]];
    }
    else if(self.appTheme == DarkTheme) {
        [self.tableView setBackgroundColor:[UIColor lightGrayColor]];
    }
}

#pragma mark - constructData
- (void)constructData {
    
    // 文字主题颜色
    UIColor *textColor = (self.appTheme == LightTheme)?[UIColor blackColor]:[UIColor whiteColor];
    
    // userImage
    ZCPUserImageCellItem *userImageItem = [[ZCPUserImageCellItem alloc] initWithDefault];
    userImageItem.cellHeight = @200;
    userImageItem.bgImageURL = self.currUserModel.userFaceURL;
    userImageItem.userHeadURL = self.currUserModel.userFaceURL;
    userImageItem.userName = self.currUserModel.userName;
    
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
    ageItem.text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"年龄：%lu", self.currUserModel.userAge] attributes:@{NSForegroundColorAttributeName: textColor}];
    // 文采值cell
    ZCPImageTextCellItem *expItem = [[ZCPImageTextCellItem alloc] initWithDefault];
    expItem.accessoryType = UITableViewCellAccessoryNone;
    expItem.cellHeight = @50;
    expItem.imageName = @"文采值.png";
    expItem.text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"文采值：%lu", self.currUserModel.userEXP] attributes:@{NSForegroundColorAttributeName: textColor}];
    // 称号cell
    ZCPImageTextCellItem *appellationItem = [[ZCPImageTextCellItem alloc] initWithDefault];
    appellationItem.accessoryType = UITableViewCellAccessoryNone;
    appellationItem.cellHeight = @50;
    appellationItem.imageName = @"称号.png";
    appellationItem.text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"称号：%@", self.currUserModel.userLevel] attributes:@{NSForegroundColorAttributeName: textColor}];
    
    // 成绩cell
    ZCPImageTextCellItem *scoreItem = [[ZCPImageTextCellItem alloc] initWithDefault];
    scoreItem.accessoryType = UITableViewCellAccessoryNone;
    scoreItem.cellHeight = @50;
    scoreItem.imageName = @"成绩.png";
    scoreItem.text = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"成绩：%lu", self.currUserModel.userScore] attributes:@{NSForegroundColorAttributeName: textColor}];
    
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
    for (int i = 0; i < self.currUserModel.focusFieldArr.count; i++) {
        [fields appendString:((ZCPFieldModel *)[self.currUserModel.focusFieldArr objectAtIndex:i]).fieldName];
        if (i != self.currUserModel.focusFieldArr.count - 1) {
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
    peopleItem.text = [[NSMutableAttributedString alloc] initWithString:@"他关注的人" attributes:@{NSForegroundColorAttributeName: textColor}];
    
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
    collectionItem.text = [[NSMutableAttributedString alloc] initWithString:@"他的收藏" attributes:@{NSForegroundColorAttributeName: textColor}];
    
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
    switch (object.cellTag) {
        case ZCPUserFocusOnPeopleCellTag:
            [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_USER_FOCUSON_PEOPLE
                                                 paramDictForInit:@{@"_currUserID": @(self.currUserModel.userId)}];
            break;
        case ZCPUserAchievementCellTag:
            [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_USER_ACHIEVEMENT
                                                 paramDictForInit:@{@"_currUserID": @(self.currUserModel.userId)}];
            break;
        case ZCPUserCollectionCellTag:
            [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_USER_COLLECTION
                                                 paramDictForInit:@{@"_currUserID": @(self.currUserModel.userId)}];
            break;
        default:
            break;
    }
}

@end
