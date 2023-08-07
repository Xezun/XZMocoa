//
//  XZMocoaView.m
//  XZMocoa
//
//  Created by Xezun on 2021/4/12.
//

#import "XZMocoaView.h"
#import "XZMocoaDefines.h"
@import XZExtensions;
@import XZDefines;

static const void * const _viewModel = &_viewModel;

static void mocoa_copyMethod(Class const cls, SEL const target, SEL const source) {
    if (xz_objc_class_copyMethod(cls, target, source)) return;
    XZLog(@"为协议 XZMocoaView 的方法 %@ 提供默认实现失败", NSStringFromSelector(target));
}

#pragma mark - XZMocoaView 协议

@interface UIResponder (XZMocoaView) <XZMocoaView>
@end
@implementation UIResponder (XZMocoaView)

+ (void)load {
    Class const cls = UIResponder.class;
    
    mocoa_copyMethod(cls, @selector(viewModel), @selector(mocoa_viewModel));
    mocoa_copyMethod(cls, @selector(setViewModel:), @selector(mocoa_setViewModel:));
    mocoa_copyMethod(cls, @selector(viewModelWillChange), @selector(mocoa_viewModelWillChange));
    mocoa_copyMethod(cls, @selector(viewModelDidChange), @selector(mocoa_viewModelDidChange));
    
    mocoa_copyMethod(cls, @selector(viewController), @selector(mocoa_viewController));
    mocoa_copyMethod(cls, @selector(navigationController), @selector(mocoa_navigationController));
    mocoa_copyMethod(cls, @selector(tabBarController), @selector(mocoa_tabBarController));
    
    mocoa_copyMethod(cls, @selector(shouldPerformSegueWithIdentifier:), @selector(mocoa_shouldPerformSegueWithIdentifier:));
    mocoa_copyMethod(cls, @selector(prepareForSegue:), @selector(mocoa_prepareForSegue:));
}

- (UIViewController *)mocoa_viewControllerImplementation {
    UIViewController *viewController = (id)self.nextResponder;
    while (viewController != nil) {
        if ([viewController isKindOfClass:UIViewController.class]) {
            return viewController;
        }
        viewController = (id)viewController.nextResponder;
    }
    return nil;
}

- (UIViewController *)mocoa_viewController {
    return [self mocoa_viewControllerImplementation];
}

- (UINavigationController *)mocoa_navigationController {
    return [self mocoa_viewControllerImplementation].navigationController;
}

- (UITabBarController *)mocoa_tabBarController {
    return [self mocoa_viewControllerImplementation].tabBarController;
}

- (XZMocoaViewModel *)mocoa_viewModel {
    return objc_getAssociatedObject(self, _viewModel);
}

- (void)mocoa_setViewModel:(XZMocoaViewModel *)viewModel {
    XZMocoaViewModel *oldValue = objc_getAssociatedObject(self, _viewModel);
    if (oldValue == nil && viewModel == nil) {
        return;
    }
    if ([oldValue isEqual:viewModel]) {
        return;
    }
    [(id<XZMocoaView>)self viewModelWillChange];
    // 在 viewModel 使用前（与 view 关联前），使其进入 isReady 状态
    // [viewModel ready];
    objc_setAssociatedObject(self, _viewModel, viewModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [(id<XZMocoaView>)self viewModelDidChange];
}

- (void)mocoa_viewModelDidChange {
    
}

- (void)mocoa_viewModelWillChange {
    
}

- (BOOL)mocoa_shouldPerformSegueWithIdentifier:(NSString *)identifier {
    return YES;
}

- (void)mocoa_prepareForSegue:(UIStoryboardSegue *)segue {
    
}

@end



@interface UIViewController (XZMocoaView)
@end
@implementation UIViewController (XZMocoaView)

- (UIViewController *)mocoa_viewControllerImplementation {
    return self;
}

// MARK: 转发控制器的 IB 事件给视图
// 如果 sender 为 MVVM 的视图，则将事件转发给视图 sender 处理。

+ (void)load {
    Class const cls = UIViewController.class;
    
    {
        SEL const selT = @selector(shouldPerformSegueWithIdentifier:sender:);
        SEL const selN = @selector(mocoa_new_shouldPerformSegueWithIdentifier:sender:);
        SEL const selE = @selector(mocoa_exchange_shouldPerformSegueWithIdentifier:sender:);
        if (xz_objc_class_addMethod(cls, selT, selN, NULL, selE)) {
            XZLog(@"为 UIViewController 重载方法 %@ 失败，相关事件请手动处理", NSStringFromSelector(selT));
        }
    }
    
    {
        SEL const selT = @selector(prepareForSegue:sender:);
        SEL const selN = @selector(mocoa_new_prepareForSegue:sender:);
        SEL const selE = @selector(mocoa_exchange_prepareForSegue:sender:);
        if (xz_objc_class_addMethod(cls, selT, selN, NULL, selE)) {
            XZLog(@"为 UIViewController 重载方法 %@ 失败，相关事件请手动处理", NSStringFromSelector(selT));
        }
    }
}

- (BOOL)mocoa_new_shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([sender conformsToProtocol:@protocol(XZMocoaView)]) {
        return [sender shouldPerformSegueWithIdentifier:identifier];
    }
    return YES;
}

- (BOOL)mocoa_exchange_shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([sender conformsToProtocol:@protocol(XZMocoaView)]) {
        return [sender shouldPerformSegueWithIdentifier:identifier];
    }
    return [self mocoa_exchange_shouldPerformSegueWithIdentifier:identifier sender:sender];;
}

- (void)mocoa_new_prepareForSegue:(UIStoryboardSegue *)segue sender:(id<XZMocoaView>)sender {
    if ([sender conformsToProtocol:@protocol(XZMocoaView)]) {
        [sender prepareForSegue:segue];
    }
}

- (void)mocoa_exchange_prepareForSegue:(UIStoryboardSegue *)segue sender:(id<XZMocoaView>)sender {
    if ([sender conformsToProtocol:@protocol(XZMocoaView)]) {
        [sender prepareForSegue:segue];
    } else {
        [self mocoa_exchange_prepareForSegue:segue sender:sender];
    }
}

@end


@implementation UIViewController (XZMocoaModuleSupporting)

+ (__kindof UIViewController *)viewControllerWithMocoaURL:(NSURL *)url {
    XZMocoaOptions const options = [XZURLQuery queryForURL:url].dictionaryRepresentation;
    return [self viewControllerWithMocoaModule:[XZMocoaModule moduleForURL:url] options:options];
}
+ (__kindof UIViewController *)viewControllerWithMocoaModule:(XZMocoaModule *)module options:(XZMocoaOptions)options {
    Class const ViewController = module.viewClass;
    if (![ViewController isSubclassOfClass:UIViewController.class]) {
        return nil;
    }
    NSString *nibName = module.viewNibName;
    NSBundle *bundle  = module.viewNibBundle;
    return [[ViewController alloc] initWithMocoaOptions:options nibName:nibName bundle:bundle];
}

- (instancetype)initWithMocoaOptions:(XZMocoaOptions)options nibName:(NSString *)nibName bundle:(NSBundle *)bundle {
    return [self initWithNibName:nibName bundle:bundle];
}

- (__kindof UIViewController *)presentViewControllerWithMocoaURL:(NSURL *)url animated:(BOOL)flag completion:(void (^)(void))completion {
    UIViewController *nextVC = [UIViewController viewControllerWithMocoaURL:url];
    if (nextVC != nil) {
        [self presentViewController:nextVC animated:flag completion:completion];
    }
    return nextVC;
}

- (__kindof UIViewController *)addChildViewControllerWithMocoaURL:(NSURL *)url {
    UIViewController *nextVC = [UIViewController viewControllerWithMocoaURL:url];
    if (nextVC != nil) {
        [self addChildViewController:nextVC];
    }
    return nextVC;
}

@end



@implementation UINavigationController (XZMocoaModuleSupporting)

- (instancetype)initWithRootViewControllerWithMocoaURL:(NSURL *)url {
    UIViewController *rootVC = [UIViewController viewControllerWithMocoaURL:url];
    if (rootVC == nil) {
        return [self init];
    }
    return [self initWithRootViewController:rootVC];
}

- (__kindof UIViewController *)pushViewControllerWithMocoaURL:(NSURL *)url animated:(BOOL)animated {
    UIViewController *nextVC = [UIViewController viewControllerWithMocoaURL:url];
    if (nextVC != nil) {
        [self pushViewController:nextVC animated:animated];
    }
    return nextVC;
}

@end



@implementation UITabBarController (XZMocoaModuleSupporting)

- (NSArray<__kindof UIViewController *> *)setViewControllersWithMocoaURLs:(NSArray<NSURL *> *)urls animated:(BOOL)animated {
    NSArray *viewControllers = [urls xz_compactMap:^id(NSURL *url, NSInteger idx, BOOL *stop) {
        return [UIViewController viewControllerWithMocoaURL:url];
    }];
    [self setViewControllers:viewControllers animated:animated];
    return viewControllers;
}

@end
