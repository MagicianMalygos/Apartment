//
//  ZCPMainActivityController.m
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPMainActivityController.h"

#import "ZCPCoupletMainController.h"
#import "ZCPThesisMainController.h"
#import "ZCPQuestionMainController.h"

#import "ZCPOptionView.h"

#define OptionHeight 44.0f

@interface ZCPMainActivityController () <UIScrollViewDelegate, ZCPOptionViewDelegate>

@property (nonatomic, strong) ZCPOptionView *optionView;                        // 选项视图
@property (nonatomic, strong) UIScrollView *mainScrollView;                     // 滑动视图
@property (nonatomic, strong) ZCPCoupletMainController *coupletController;      // 对对联视图控制器
@property (nonatomic, strong) ZCPThesisMainController *thesisController;        // 舌场争锋视图控制器
@property (nonatomic, strong) ZCPQuestionMainController *questionController;    // 头脑风暴视图控制器

@end

@implementation ZCPMainActivityController

#pragma mark - synthesize
@synthesize optionView              = _optionView;
@synthesize mainScrollView          = _mainScrollView;
@synthesize coupletController       = _coupletController;
@synthesize thesisController        = _thesisController;
@synthesize questionController      = _questionController;

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化当前显示活动
    self.activityIndex = 0;
    
    self.view.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar - Height_TABBAR);
    [self.view addSubview:self.optionView];
    [self.view addSubview:self.mainScrollView];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 通过偏移量设置NavTitle
    [self setNavTitleByScrollViewOffset];
    
    // 设置当前显示的活动
    [self.optionView triggerOptionWithIndex:self.activityIndex];
}

#pragma mark - getter / setter
/**
 *  懒加载选项视图
 *
 *  @return 选项视图
 */
- (ZCPOptionView *)optionView {
    if (_optionView == nil) {
        NSArray *attrStringArr = @[[[NSAttributedString alloc] initWithString:@"对对联"
                                                                   attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}]
                                   ,[[NSAttributedString alloc] initWithString:@"舌场争锋"
                                                                    attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}]
                                   ,[[NSAttributedString alloc] initWithString:@"头脑风暴"
                                                                    attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]}]];
        _optionView = [[ZCPOptionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, OptionHeight) attributeStringArr:attrStringArr];
        _optionView.delegate = self;
    }
    return _optionView;
}
/**
 *  初始化mainScrollView，并添加将要展示的视图
 *
 *  @return mainScrollView
 */
- (UIScrollView *)mainScrollView {
    if (_mainScrollView == nil) {
        CGFloat width = self.view.frame.size.width;
        CGFloat height = self.view.frame.size.height;
        
        // 设置mainScrollView
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, OptionHeight, width, height - OptionHeight)];
        _mainScrollView.contentSize = CGSizeMake(width * 3, height - OptionHeight);
        _mainScrollView.scrollEnabled = YES;                        // 设置可以滑动
        _mainScrollView.bounces = YES;                              // 设置弹簧效果
        [_mainScrollView setPagingEnabled:YES];                     // 设置分页
        [_mainScrollView setShowsHorizontalScrollIndicator:NO];     // 隐藏水平滚动条
        [_mainScrollView setShowsVerticalScrollIndicator:NO];       // 隐藏垂直滚动条
        _mainScrollView.delegate = self;                            // 设置代理
        
        // 初始化将要展示的视图控制器
        self.coupletController = [ZCPCoupletMainController new];
        self.coupletController.view.frame = CGRectMake(0, 0, width, height);
        self.thesisController = [ZCPThesisMainController new];
        self.thesisController.view.frame = CGRectMake(width, 0, width, height);
        self.questionController = [ZCPQuestionMainController new];
        self.questionController.view.frame = CGRectMake(width * 2, 0, width, height);
        
        // 添加视图控制器的视图作为mainScrollView的滑动视图
        [_mainScrollView addSubview:self.coupletController.view];
        [_mainScrollView addSubview:self.thesisController.view];
        [_mainScrollView addSubview:self.questionController.view];
    }
    return _mainScrollView;
}

#pragma mark - Private Method
/**
 *  通过MainScrollView的偏移量设置要显示的NavTitle
 */
- (void)setNavTitleByScrollViewOffset{
    
    NSString *titleString = @"";
    if (self.mainScrollView.contentOffset.x < self.mainScrollView.width / 2) {
        titleString = @"对对联";
    }
    else if (self.mainScrollView.contentOffset.x > self.mainScrollView.width / 2 && self.mainScrollView.contentOffset.x < self.mainScrollView.width * 3 / 2) {
        titleString = @"舌场争锋";
    }
    else if (self.mainScrollView.contentOffset.x > self.mainScrollView.width * 3 / 2) {
        titleString = @"头脑风暴";
    }
    self.tabBarController.title = titleString;
}

#pragma mark - ZCPOptionView Delegate
/**
 *  label点击事件，动画将要开始时
 *
 *  @param label 被点击的label
 *  @param index 被点击label的索引号
 */
- (void)label:(UILabel *)label animateWillBeginDidSelectedAtIndex:(NSInteger)index {
    self.mainScrollView.contentOffset = CGPointMake(APPLICATIONWIDTH * index, 0);
    self.activityIndex = index;
}
/**
 *  label点击事件，动画将要结束时
 *
 *  @param label 被点击的label
 *  @param index 被点击的label的索引号
 */
- (void)label:(UILabel *)label animateWillEndDidSelectedAtIndex:(NSInteger)index {
    NSString *titleString = @"";
    switch (index) {
        case 0:
            titleString = @"对对联";
            break;
        case 1:
            titleString = @"舌场争锋";
            break;
        case 2:
            titleString = @"头脑风暴";
            break;
        default:
            break;
    }
    self.tabBarController.title = titleString;
    self.activityIndex = index;
}

#pragma mark - UIScrollView Delegate
/**
 *  mainScrollView滑动事件
 *  用于处理markView随着scrollView同步移动
 *
 *  @param scrollView mainScrollView
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 移动markView
    [self.optionView moveMarkViewByOffsetX:scrollView.contentOffset.x offsetRange:NSMakeRange(0, scrollView.contentSize.width - scrollView.width)];
}
/**
 *  mainScrollView结束滑动事件
 *
 *  @param scrollView mainScrollView
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self setNavTitleByScrollViewOffset];
}

// 弃用：用力滑动的时候，由于惯性的关系不能保证结束拖拽点在最终显示视图的偏移量范围里
/**
 *  mainScrollView结束拖拽事件
 *  用于处理移动后Nav的title的判定
 *
 *  @param scrollView mainScrollView
 */
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    [self setNavTitleByScrollViewOffset];
//}

#pragma mark - public method
// 通过对应的索引切换当前显示的活动
- (void)switchActivityWithIndex:(NSInteger)index {
    self.activityIndex = index;
}

@end
