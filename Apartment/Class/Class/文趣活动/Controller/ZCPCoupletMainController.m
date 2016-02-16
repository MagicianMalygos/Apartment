//
//  ZCPCoupletMainController.m
//  Apartment
//
//  Created by apple on 16/1/21.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPCoupletMainController.h"

#import "ZCPOptionCell.h"
#import "ZCPCoupletMainCell.h"
#import "ZCPCoupletModel.h"
#import "ZCPRequestManager+Couplet.h"

#import "ZCPCoupletDetailController.h"

#define OptionHeight 35.0f

@interface ZCPCoupletMainController () <ZCPOptionViewDelegate, ZCPListTableViewAdaptorDelegate>

@property (nonatomic, strong) NSMutableArray *coupletModelArr;  // 对联模型数组

@end

@implementation ZCPCoupletMainController

@synthesize coupletModelArr = _coupletModelArr;

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 从网络获取数据
    [[ZCPRequestManager sharedInstance] getCoupletListByTimeWithPageCount:1 currUserID:1 success:^(AFHTTPRequestOperation *operation, ZCPDataModel *model) {
        self.coupletModelArr = [NSMutableArray array];
        
        // 重新构造并加载数据
        [self constructData];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"%@", error);
    }];
    
//    self.coupletModelArr = [NSMutableArray array];
//    for (int i = 0; i < 10; i++) {
//        ZCPCoupletModel *model = [ZCPCoupletModel modelFromDictionary:@{@"coupletId":[NSNumber numberWithInt:i]
//                                                                        ,@"coupletContent":@"asdasdasdasdasdasddddddddddddddddddddddasdddddddddd"
//                                                                        ,@"coupletReplyNumber":[NSNumber numberWithInt:i]
//                                                                        ,@"coupletCollectNumber":[NSNumber numberWithInt:i]
//                                                                        ,@"coupletSupport":[NSNumber numberWithInt:i]
//                                                                        ,@"coupletTime":@"2015-10-20"
//                                                                        ,@"user":@{@"userName":@"zcp"}}];
//        [self.coupletModelArr addObject:model];
//    }
//    // 重新构造并加载数据
//    [self constructData];
//    [self.tableView reloadData];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar - Height_TABBAR - OptionHeight);
}

#pragma mark - Construct Data
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    // 选项视图cell
    ZCPOptionCellItem *optionItem = [[ZCPOptionCellItem alloc] initWithDefault];
    optionItem.cellHeight = @OptionHeight;
    optionItem.delegate = self;
    optionItem.attributedStringArr = @[[[NSAttributedString alloc] initWithString:@"按时间排序"
                                                                       attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]}]
                                       ,[[NSAttributedString alloc] initWithString:@"按点赞量排序"
                                                                        attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]}]
                                       ,[[NSAttributedString alloc] initWithString:@"写对联"
                                                                        attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]}]];
    [items addObject:optionItem];
    
    // 对联列表cell
    for (ZCPCoupletModel *model in self.coupletModelArr) {
        ZCPCoupletMainCellItem *coupletItem = [[ZCPCoupletMainCellItem alloc] initWithDefault];
        coupletItem.userHeadImageURL = model.user.userFaceURL;
        coupletItem.userName = model.user.userName;
        coupletItem.coupletContent = model.coupletContent;
        coupletItem.time = model.coupletTime;
        coupletItem.supportNumber = model.coupletSupport;
        coupletItem.replyNumber = model.coupletReplyNumber;
        [items addObject:coupletItem];
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
    // 跳转到对联详情界面，并进行nil值判断
    ZCPCoupletModel *selectedCoupletModel = [self.coupletModelArr objectAtIndex:indexPath.row];
    [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_COUPLET_DETAIL paramDictForInit:@{@"_selectedCoupletModel": (selectedCoupletModel != nil)? selectedCoupletModel: [NSNull null]}];
}

#pragma mark - ZCPOptionView Delegate
/**
 *  label点击事件
 *
 *  @param label 被点击的label
 *  @param index 被点击的label下标
 */
- (void)label:(UILabel *)label didSelectedAtIndex:(NSInteger)index {
    
    switch (index) {
        case 0:
            // 获取按时间排序的对联数组
            self.coupletModelArr = [NSMutableArray array];
            for (int i = 0; i < 10; i++) {
                ZCPCoupletModel *model = [ZCPCoupletModel modelFromDictionary:@{@"coupletId":[NSNumber numberWithInt:i]
                                                                                ,@"coupletContent":@"按时间排序"
                                                                                ,@"coupletReplyNumber":[NSNumber numberWithInt:i]
                                                                                ,@"coupletCollectNumber":[NSNumber numberWithInt:i]
                                                                                ,@"coupletSupport":[NSNumber numberWithInt:i]
                                                                                ,@"coupletTime":@"2015-10-20"
                                                                                ,@"user":@{@"userName":@"zcp"}}];
                [self.coupletModelArr addObject:model];
            }
            
            // 重新构造并加载数据
            [self constructData];
            [self.tableView reloadData];
            break;
        case 1:
            // 获取按点赞量排序的对联数组
            self.coupletModelArr = [NSMutableArray array];
            for (int i = 0; i < 10; i++) {
                ZCPCoupletModel *model = [ZCPCoupletModel modelFromDictionary:@{@"coupletId":[NSNumber numberWithInt:i]
                                                                                ,@"coupletContent":@"按点赞量排序"
                                                                                ,@"coupletReplyNumber":[NSNumber numberWithInt:i]
                                                                                ,@"coupletCollectNumber":[NSNumber numberWithInt:i]
                                                                                ,@"coupletSupport":[NSNumber numberWithInt:i]
                                                                                ,@"coupletTime":@"2015-10-20"
                                                                                ,@"user":@{@"userName":@"zcp"}}];
                [self.coupletModelArr addObject:model];
            }
            
            // 重新构造并加载数据
            [self constructData];
            [self.tableView reloadData];
            break;
        case 2:
            // 跳转到添加对联页面
            [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_COUPLET_ADD paramDictForInit:nil];
            break;
        default:
            break;
    }
}

@end
