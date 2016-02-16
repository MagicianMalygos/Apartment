//
//  ZCPRequestManager.m
//  Apartment
//
//  Created by apple on 16/2/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestManager.h"

#import <AFNetworkActivityIndicatorManager.h>

@implementation ZCPRequestManager

#pragma mark - instancetype
+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithBaseURL:nil];
        
        // 设置默认访问的解析类
        [instance setResponseSerializer:[AFJSONResponseSerializer serializer]];
        [instance setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    });
    return instance;
}
- (instancetype)initWithBaseURL:(NSURL *)url {
    if (self = [super initWithBaseURL:url]) {
        // 不使用证书验证
        self.securityPolicy.allowInvalidCertificates = NO;
        
        // 打开网络活动指示器
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    return self;
}

@end
