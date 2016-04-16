//
//  ZCPQuestionMainController.m
//  Apartment
//
//  Created by apple on 16/1/21.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPQuestionMainController.h"
#import "ZCPOptionCell.h"
#import "ZCPSectionCell.h"
#import "ZCPButtonCell.h"
#import "ZCPQuestionCell.h"
#import "ZCPRequestManager+Question.h"

#define OptionHeight            44.0f
#define QUESTION_COUNT          5

@interface ZCPQuestionMainController () <ZCPOptionViewDelegate, ZCPQuestionCellDelegate, ZCPButtonCellDelegate>

@property (nonatomic, strong) ZCPOptionView *optionView;            // 选项视图
@property (nonatomic, assign) BOOL userHaveAnswer;                  // 用户是否已经回答过题目
@property (nonatomic, copy) NSString *answers;                      // 用户答案（用户已答题）
@property (nonatomic, copy) NSMutableArray *userSelectAnswerArr;    // 用户选择答案（用户未答题）
@property (nonatomic, strong) NSMutableArray *questionListArray;    // 列表数组

@end

@implementation ZCPQuestionMainController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化相关属性
    self.userHaveAnswer = YES;
    self.answers = @"";
    
    // 加载数据
    [self loadData];
    
    // 初始化上拉下拉控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    // 添加选项视图
    [self.view addSubview:self.optionView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 设置主题颜色
    self.tableView.backgroundColor = APP_THEME_BG_COLOR;
    // 更新cell颜色
    [self constructData];
    [self.tableView reloadData];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar - Height_TABBAR - OptionHeight);
}

#pragma mark - constructData
- (void)constructData {
    NSMutableArray *items = [NSMutableArray array];
    
    // 选项视图cell
    ZCPOptionCellItem *optionItem = [[ZCPOptionCellItem alloc] initWithDefault];
    optionItem.cellHeight = @(35.0f);
    optionItem.delegate = self;
    optionItem.attributedStringArr = @[[[NSAttributedString alloc] initWithString:@"点我，可以出题哦~"
                                                                       attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f], NSForegroundColorAttributeName: APP_THEME_TEXT_COLOR}]];
    [items addObject:optionItem];
    
    // 问题Item
    for (int i = 0; i < self.questionListArray.count; i++) {
        ZCPQuestionModel *model = [self.questionListArray objectAtIndex:i];
        ZCPQuestionCellItem *questionItem = [[ZCPQuestionCellItem alloc] initWithDefault];
        questionItem.questionModel = model;
        questionItem.userHaveAnswer = self.userHaveAnswer;  // 传参用户是否已经答题
        if (self.userHaveAnswer) { // 如果用户已经回答过问题，传参用户答案的索引
            questionItem.userAnswerIndex = [[self.answers substringWithRange:NSMakeRange(i, 1)] integerValue] - 1;
        } else {  // 如果用户还未回答过问题，传参用户当前选择的选项的索引
            questionItem.userSelectIndex = [[self.userSelectAnswerArr objectAtIndex:i] integerValue];
        }
        questionItem.delegate = self;
        [items addObject:questionItem];
    }
    
    // 按钮Item
    ZCPLineCellItem *topBlankItem = [[ZCPLineCellItem alloc] initWithDefault];
    ZCPLineCellItem *bottomBlankItem = [[ZCPLineCellItem alloc] initWithDefault];
    bottomBlankItem.cellHeight = @(10);
    ZCPButtonCellItem *determineItem = [[ZCPButtonCellItem alloc] initWithDefault];
    determineItem.buttonConfigBlock = ^(UIButton *button) {
        [button setTitleColor:[UIColor buttonTitleDefaultColor] forState:UIControlStateNormal];
    };
    if (self.userHaveAnswer) {
        determineItem.buttonTitle = @"您已答过本期题目";
    } else {
        determineItem.buttonTitle = @"提交";
    }
    determineItem.delegate = self;
    
    [items addObject:topBlankItem];
    [items addObject:determineItem];
    [items addObject:bottomBlankItem];
    self.tableViewAdaptor.items = items;
}

#pragma mark - getter / setter
- (NSMutableArray *)questionListArray {
    if (_questionListArray == nil) {
        _questionListArray = [NSMutableArray array];
    }
    return _questionListArray;
}
- (NSMutableArray *)userSelectAnswerArr {
    if (_userSelectAnswerArr == nil) {
        _userSelectAnswerArr = [NSMutableArray array];
        // 设置默认值
        for (int i = 0; i < QUESTION_COUNT; i++) {
            [_userSelectAnswerArr addObject:@(DEFAULT_INDEX)];
        }
    }
    return _userSelectAnswerArr;
}

#pragma mark - ZCPOptionViewDelegate
- (void)label:(UILabel *)label didSelectedAtIndex:(NSInteger)index {
    [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_QUESTION_ADD paramDictForInit:nil];
}

#pragma mark - ZCPQuestionCellDelegate
- (void)questionCell:(ZCPQuestionCell *)cell collectButtonClicked:(UIButton *)button {
    
    ZCPQuestionCellItem *item = cell.item;
    
    [[ZCPRequestManager sharedInstance] changeQuestionCurrCollectionState:item.questionModel.collected currQuestionID:item.questionModel.questionId currUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL isSuccess) {
        if (isSuccess) {
            if (cell.item.questionModel.collected == ZCPCurrUserNotCollectQuestion) {
                button.selected = YES;
                cell.item.questionModel.collected = ZCPCurrUserHaveCollectQuestion;
                cell.item.questionModel.questionCollectNumber ++;
                
                TTDPRINT(@"收藏成功！");
                [MBProgressHUD showSuccess:@"收藏成功！" toView:self.view];
            }
            else if (cell.item.questionModel.collected == ZCPCurrUserHaveCollectQuestion) {
                button.selected = NO;
                cell.item.questionModel.collected = ZCPCurrUserNotCollectQuestion;
                cell.item.questionModel.questionCollectNumber --;
                
                TTDPRINT(@"取消收藏成功！");
                [MBProgressHUD showSuccess:@"取消收藏成功！" toView:self.view];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TTDPRINT(@"操作失败！%@", error);
        [MBProgressHUD showSuccess:@"操作失败！网络异常！" toView:self.view];
    }];
}
- (void)questionCell:(ZCPQuestionCell *)cell optionButtonClicked:(UIButton *)button atIndex:(NSInteger)index {
    
    // 用户若已经答过题，则不允许触发选项按钮点击事件
    if (self.userHaveAnswer) {
        return;
    }
    
    // item索引
    NSUInteger itemIndex = [self.tableViewAdaptor.items indexOfObject:cell.item];
    // 设置用户选择选项
    self.userSelectAnswerArr[itemIndex] = @(index);
    
    NSArray *optionButtonArr = @[cell.optionOneButton, cell.optionTwoButton, cell.optionThreeButton, cell.optionFourButton];
    for (UIButton *optionButton in optionButtonArr) {
        optionButton.selected = NO;
    }
    button.selected = YES;
}

#pragma mark - ZCPButtonCellDelegate
- (void)cell:(UITableViewCell *)cell buttonClicked:(UIButton *)button {
    // 如果用户已答题，禁止提交
    if (self.userHaveAnswer) {
        return;
    }
    
    // 判断用户是否答题完毕，并拼接答案
    NSString *answers = @"";
    for (NSNumber *userSelectAnswer in self.userSelectAnswerArr) {
        if ([userSelectAnswer integerValue] == NSIntegerMax) {
            [MBProgressHUD showError:@"尚有未选择的题目！"];
            return;
        }
        answers = [answers stringByAppendingString:[NSString stringWithFormat:@"%li", [userSelectAnswer integerValue] + 1]];
    }
    
    // 提交答案
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] submitQuestionAnswersWithCurrUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId answers:answers success:^(AFHTTPRequestOperation *operation, BOOL isSuccess, NSInteger score) {
        if (isSuccess) {
            [MBProgressHUD showError:[NSString stringWithFormat:@"提交成功，您获得了%li分", score]];
        } else {
            [MBProgressHUD showError:@"网络异常！"];
        }
        [weakSelf loadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络异常！"];
        TTDPRINT(@"%@", error);
    }];
}

#pragma mark - Load Data
- (void)loadData {
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getUserAnswersRecordWithCurrUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL userHaveAnswer, NSString *answers) {
        
        // 设置用户是否回答过题目
        if ((self.userHaveAnswer = userHaveAnswer)) {
            self.answers = answers;
        }
        // 初始化用户选择答案数组，让其再去执行懒加载进行初始化
        self.userSelectAnswerArr = nil;
        
        [[ZCPRequestManager sharedInstance] getQuestionListWithCurrUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *questionListModel) {
            STRONG_SELF;
            if ([questionListModel isKindOfClass:[ZCPListDataModel class]] && questionListModel.items) {
                weakSelf.questionListArray = [NSMutableArray arrayWithArray:questionListModel.items];
                
                // 重新构造并加载数据
                [self constructData];
                [weakSelf.tableView reloadData];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [MBProgressHUD showError:@"获取题目列表失败！"];
            TTDPRINT(@"%@", error);
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络异常！"];
        TTDPRINT(@"%@", error);
    }];
}
- (void)headerRefresh {
    WEAK_SELF;
    [[ZCPRequestManager sharedInstance] getUserAnswersRecordWithCurrUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, BOOL userHaveAnswer, NSString *answers) {
        
        // 设置用户是否回答过题目
        if ((self.userHaveAnswer = userHaveAnswer)) {
            self.answers = answers;
        }
        // 初始化用户选择答案数组，让其再去执行懒加载进行初始化
        self.userSelectAnswerArr = nil;
        
        [[ZCPRequestManager sharedInstance] getQuestionListWithCurrUserID:[ZCPUserCenter sharedInstance].currentUserModel.userId success:^(AFHTTPRequestOperation *operation, ZCPListDataModel *questionListModel) {
            STRONG_SELF;
            if ([questionListModel isKindOfClass:[ZCPListDataModel class]] && questionListModel.items) {
                weakSelf.questionListArray = [NSMutableArray arrayWithArray:questionListModel.items];
                
                // 重新构造并加载数据
                [self constructData];
                [weakSelf.tableView reloadData];
            }
            [weakSelf.tableView.mj_header endRefreshing];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [MBProgressHUD showError:@"获取题目列表失败！"];
            TTDPRINT(@"%@", error);
            [weakSelf.tableView.mj_header endRefreshing];
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络异常！"];
        TTDPRINT(@"%@", error);
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}
@end
