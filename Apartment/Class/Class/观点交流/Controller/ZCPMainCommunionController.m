//
//  ZCPMainCommunionController.m
//  Apartment
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 zcp. All rights reserved.
//

#import "ZCPMainCommunionController.h"

@interface ZCPMainCommunionController ()

@end

@implementation ZCPMainCommunionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 300, 100)];
    infoLabel.text = @"这是观点交流主界面";
    infoLabel.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:infoLabel];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self clearNavigationBar];
    self.tabBarController.title = @"观点交流";
}

@end
