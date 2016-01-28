//
//  ZCPMainHotTrendController.m
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPMainHotTrendController.h"

@interface ZCPMainHotTrendController () <UITextFieldDelegate>

@end

@implementation ZCPMainHotTrendController

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 这几个根控制器都是tabBarControler上的tab，要修改他们的title的时候需要去修改tabBarController上的title
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 300, 100)];
    infoLabel.text = @"这是热门动态主界面";
    infoLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:infoLabel];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self clearNavigationBar];
    self.title = @"热门动态";
}
@end























