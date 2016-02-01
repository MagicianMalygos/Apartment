//
//  ZCPBaseNavigator.m
//  Apartment
//
//  Created by apple on 15/12/28.
//  Copyright © 2015年. All rights reserved.
//

#import "ZCPBaseNavigator.h"

#import "ZCPViewDataModel.h"

@interface ZCPBaseNavigator ()
// 存放ViewController的相关信息
// key是ViewController对象的identifier，value是ZCPViewDataModel对象
@property (nonatomic, strong) NSMutableDictionary *viewModelDict;
@property (nonatomic, strong) UIViewController *rootViewController;

@end

@implementation ZCPBaseNavigator

#pragma mar - synthesize
@synthesize window = _window;
@synthesize viewModelDict = _viewModelDict;

#pragma mark - 初始化
/**
 *  初始化方法
 */
- (instancetype)init {
    if (self = [super init]) {
        [self readViewControllerConfigurations];
    }
    return self;
}

#pragma mark - getter / setter
- (UIWindow *)window {
    if (_window == nil) {
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return _window;
}
- (NSMutableDictionary *)viewModelDict {
    if (_viewModelDict == nil) {
        _viewModelDict = [NSMutableDictionary dictionary];
    }
    return _viewModelDict;
}
- (void)setupRootViewController {
    self.rootViewController = [[ZCPControlingCenter sharedInstance] generateRootViewController];
    self.window.rootViewController = self.rootViewController;
}

#pragma mark - 私有方法
/**
 *  读取控制器配置信息
 */
-  (void)readViewControllerConfigurations {
    NSString *viewMapPath = [[NSBundle mainBundle] pathForResource:@"viewMap" ofType:@"plist"];
    NSArray *viewMaps = [NSArray arrayWithContentsOfFile:viewMapPath];
    
    if (viewMapPath && viewMaps.count) {
        for (NSDictionary *viewMap in viewMaps) {
            NSString *className = [viewMap objectForKey:@"className"];
            NSString *identifier = [viewMap objectForKey:@"identifier"];
            
            if (className && className.length && identifier && identifier.length) {
                Class vcClass = NSClassFromString(className);
                // 生成identifier:viewDataModel键值对，并加入视图模型字典
                SEL initMethod = @selector(initWithParams:);
                SEL instanceMethod = @selector(doInitializeWithParams:);
                
                // 创建ViewController 配置对象
                ZCPViewDataModel *viewDataModel = [[ZCPViewDataModel alloc] init];
                viewDataModel.vcClass = vcClass;
                viewDataModel.vcInitMethod = [NSValue valueWithPointer:initMethod];
                viewDataModel.vcInstanceMethod = [NSValue valueWithPointer:instanceMethod];
                
                [self.viewModelDict setObject:viewDataModel forKey:identifier];
            }
        }
    }
}

/**
 *  配置object
 *
 *  @param object               object                控制器对象
 *  @param viewDataModel        viewDataModel         视图数据模型对象
 *  @param shouldCallInitMethod shouldCallInitMethod  是否回调初始化方法
 */
- (void)configObject:(NSObject *)object withViewDataModel:(ZCPViewDataModel *)viewDataModel shouldCallInitMethod:(BOOL)shouldCallInitMethod {
    if (object && viewDataModel) {
        // 获取相关参数
        Class           vcClass                     = viewDataModel.vcClass;
        SEL             initMethod                  = [viewDataModel.vcInitMethod pointerValue];
        SEL             instanceMethod              = [viewDataModel.vcInstanceMethod pointerValue];
        NSDictionary    *paramDictForInit           = viewDataModel.paramDictForInit;
        NSDictionary    *paramDictForInstance       = viewDataModel.paramDictForInstance;
        
        if (vcClass && initMethod) {
            // 初始化
            if ([object respondsToSelector:initMethod] && shouldCallInitMethod) {
//                NSArray *params = nil;
//                if (paramDictForInit) {
//                    params = @[paramDictForInit];
//                }
                SuppressPerformSelectorLeakWarning(
                    [object performSelector:initMethod  withObject:paramDictForInit];
                );
            }
            // 实例化方法
            if ([object respondsToSelector:instanceMethod]) {
//                NSArray *params = nil;
//                if (paramDictForInstance) {
//                    params = @[paramDictForInstance];
//                }
                SuppressPerformSelectorLeakWarning (
                    [object performSelector:instanceMethod withObject:paramDictForInstance];
                );
            }
        }
    }
}

#pragma mark - 公有方法
/**
 *  通过identifier获取视图模型
 *
 *  @param identifier 控制器标识
 *
 *  @return 视图数据模型对象
 */
- (ZCPViewDataModel *)viewDataModelForIdentifier:(NSString *)identifier {
    ZCPViewDataModel *viewDataModel = nil;
    viewDataModel = [self.viewModelDict objectForKey:identifier];
    return viewDataModel;
}

- (UIViewController *)pushViewControllerWithViewDataModel:(ZCPViewDataModel *)viewDataModel animated:(BOOL)animated {
    UIViewController *controller = nil;
    if (viewDataModel) {
        // 获取相关参数
        Class       vcClass             = viewDataModel.vcClass;
        SEL         initMethod          = [viewDataModel.vcInitMethod pointerValue];
        NSObject    *object             = nil;
        
        // 判断并进行跳转
        if (vcClass && initMethod) {
            object = [vcClass alloc];
            // 配置object
            [self configObject:object withViewDataModel:viewDataModel shouldCallInitMethod:YES];
            /**
             *  此处不懂为什么object会变成野指针，可能跟performSelector:withObjects:方法有关
             */
            // 跳转
            if ([object isKindOfClass:[UIViewController class]]) {
                controller = (UIViewController *)object;
                [self pushViewController:controller animated:animated];
                viewDataModel.paramDictForInit = nil;
            }
        }
    }
    return controller;
}

#pragma mark - 基础跳转方法
- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated {
    if (self.rootViewController && [self.rootViewController isKindOfClass:[UIViewController class]]) {
        [(UINavigationController *)self.rootViewController pushViewController:controller animated:animated];
    }
}

@end














