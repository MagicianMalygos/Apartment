//
//  ZCPMainHotTrendController.m
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPMainHotTrendController.h"
#import "ZCPImageCircleView.h"
#import "ZCPTextView.h"
#import "ZCPCommentView.h"

@interface ZCPMainHotTrendController () <ZCPImageCircleViewDelegate>

@property (nonatomic, strong) ZCPImageCircleView *imageCircleView;  // 图片轮播视图

@end

@implementation ZCPMainHotTrendController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置图片轮播视图
    [self.view addSubview:self.imageCircleView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self clearNavigationBar];
    self.tabBarController.title = @"热门动态";
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, APPLICATIONHEIGHT - Height_NavigationBar - Height_TABBAR);
}

#pragma mark - construct data
- (void)constructData {
}

#pragma mark - getter / setter
- (ZCPImageCircleView *)imageCircleView {
    if (_imageCircleView == nil) {
        _imageCircleView = [[ZCPImageCircleView alloc] initWithFrame:({
            CGRectMake(0, 200, APPLICATIONWIDTH, 200);
        })];
        
        NSArray *imageArray = @[imageGetURL(@"Advertisement", @"couplet_ad.png")
                                , imageGetURL(@"Advertisement", @"thesis_ad.png")
                                , imageGetURL(@"Advertisement", @"question_ad.png")
                                , imageGetURL(@"Advertisement", @"book_ad.png")];
        self.imageCircleView.imageNameArray = imageArray;
        self.imageCircleView.delegate = self;
    }
    return _imageCircleView;
}

#pragma mark - ZCPImageCircleViewDelegate
- (void)pageView:(ZCPImageCircleView *)imageCircleView didSelectedPageAtIndex:(NSUInteger)index {
    NSLog(@"%li", index);
    switch (index) {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        default:
            break;
    }
}

@end























