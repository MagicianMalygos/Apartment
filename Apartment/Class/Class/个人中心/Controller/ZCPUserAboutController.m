//
//  ZCPUserAboutController.m
//  Apartment
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPUserAboutController.h"

@interface ZCPUserAboutController ()

@property (nonatomic, strong) UILabel *aboutLabel;  // 关于标签

@end

@implementation ZCPUserAboutController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.aboutLabel];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"关于";
    
    // 设置主题颜色
    self.tableView.backgroundColor = APP_THEME_BG_COLOR;
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

#pragma mark - getter / setter
- (UILabel *)aboutLabel {
    if (_aboutLabel == nil) {
        _aboutLabel = [[UILabel alloc] initWithFrame:({
            CGRectMake(HorizontalMargin, VerticalMargin, APPLICATIONWIDTH - HorizontalMargin * 2, APPLICATIONHEIGHT / 2 - VerticalMargin);
        })];
        _aboutLabel.font = [UIFont defaultFontWithSize:20.0f];
        _aboutLabel.text = @"    本项目由高博培训时四人小组共同设计，客户端、服务端、数据库均由朱超鹏个人实现。为纪念培训时期所住地文荟广场，故APP起名为汇文公寓，同时也寓意着APP汇聚着丰富的文学知识。";
        _aboutLabel.numberOfLines = 0;
    }
    return _aboutLabel;
}

@end
