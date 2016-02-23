//
//  ZCPRequestManager.m
//  Apartment
//
//  Created by apple on 16/2/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRequestManager.h"

#import <AFNetworkActivityIndicatorManager.h>
#import "ZCPRequestResponseTranslator.h"

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
        
        ((ZCPRequestManager *)instance).responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"image/png", nil];
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


/**
 *  得到领域列表
 */
- (NSOperation *)getFieldListSuccess:(void(^)(AFHTTPRequestOperation *operation, ZCPListDataModel *fieldListModel))success
                             failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString * scheme       = schemeForType(kURLTypeCommon);
    NSString * host         = hostForType(kURLTypeCommon);
    NSString * path         = urlForKey(FIELD_LIST);
    
    AFHTTPRequestOperation *operation = [self POST:ZCPMakeURLString(scheme, host, path)
                                        parameters:nil
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               if (success) {
                                                   ZCPListDataModel *model = [ZCPRequestResponseTranslator translateResponse_FieldListModel:[responseObject valueForKey:@"data"]];
                                                   success(operation, model);
                                               }
                                           }
                                           failure:failure];
    
    TTDPRINT(@"URL=%@  params=%@", operation.request.URL, [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
    return operation;
}

@end
