//
//  XZMocoaView.m
//  XZMocoa
//
//  Created by Xezun on 2021/4/12.
//

#import "XZMocoaView.h"
#import "XZMocoaDefines.h"
@import XZExtensions;

static const void * const _viewModel = &_viewModel;

static void xz_mocoa_copyMethod(Class const cls, SEL const target, SEL const source) {
    if (xz_objc_class_copyMethod(cls, source, nil, target)) return;
    XZLog(@"为协议 XZMocoaView 的方法 %@ 提供默认实现失败", NSStringFromSelector(target));
}

#pragma mark - XZMocoaView 协议默认实现

@interface UIResponder (XZMocoaView) <XZMocoaView>
@end

@implementation UIResponder (XZMocoaView)

+ (void)load {
    Class const aClass = UIResponder.class;
    if (self == aClass) {
        xz_mocoa_copyMethod(aClass, @selector(viewModel), @selector(xz_mocoa_viewModel));
        xz_mocoa_copyMethod(aClass, @selector(setViewModel:), @selector(xz_mocoa_setViewModel:));
        xz_mocoa_copyMethod(aClass, @selector(viewModelWillChange), @selector(xz_mocoa_viewModelWillChange));
        xz_mocoa_copyMethod(aClass, @selector(viewModelDidChange), @selector(xz_mocoa_viewModelDidChange));
        
        xz_mocoa_copyMethod(aClass, @selector(viewController), @selector(xz_mocoa_viewController));
        xz_mocoa_copyMethod(aClass, @selector(navigationController), @selector(xz_mocoa_navigationController));
        xz_mocoa_copyMethod(aClass, @selector(tabBarController), @selector(xz_mocoa_tabBarController));
        
        xz_mocoa_copyMethod(aClass, @selector(shouldPerformSegueWithIdentifier:), @selector(xz_mocoa_shouldPerformSegueWithIdentifier:));
        xz_mocoa_copyMethod(aClass, @selector(prepareForSegue:), @selector(xz_mocoa_prepareForSegue:));
    }
}

- (UIViewController *)xz_mocoa_viewControllerImplementation {
    UIViewController *viewController = (id)self.nextResponder;
    while (viewController != nil) {
        if ([viewController isKindOfClass:UIViewController.class]) {
            return viewController;
        }
        viewController = (id)viewController.nextResponder;
    }
    return nil;
}

- (UIViewController *)xz_mocoa_viewController {
    return [self xz_mocoa_viewControllerImplementation];
}

- (UINavigationController *)xz_mocoa_navigationController {
    return [self xz_mocoa_viewControllerImplementation].navigationController;
}

- (UITabBarController *)xz_mocoa_tabBarController {
    return [self xz_mocoa_viewControllerImplementation].tabBarController;
}

- (XZMocoaViewModel *)xz_mocoa_viewModel {
    return objc_getAssociatedObject(self, _viewModel);
}

- (void)xz_mocoa_setViewModel:(XZMocoaViewModel *)viewModel {
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

- (void)xz_mocoa_viewModelDidChange {
    
}

- (void)xz_mocoa_viewModelWillChange {
    
}

- (BOOL)xz_mocoa_shouldPerformSegueWithIdentifier:(NSString *)identifier {
    return YES;
}

- (void)xz_mocoa_prepareForSegue:(UIStoryboardSegue *)segue {
    
}

@end



@interface UIViewController (XZMocoaView)
@end
@implementation UIViewController (XZMocoaView)

- (UIViewController *)xz_mocoa_viewControllerImplementation {
    return self;
}

// MARK: 转发控制器的 IB 事件给视图
// 如果 sender 为 MVVM 的视图，则将事件转发给视图 sender 处理。

+ (void)load {
    Class const aClass = UIViewController.class;
    if (self == aClass) {
        {
            SEL const selT = @selector(shouldPerformSegueWithIdentifier:sender:);
            SEL const selN = @selector(xz_mocoa_new_shouldPerformSegueWithIdentifier:sender:);
            SEL const selE = @selector(xz_mocoa_exchange_shouldPerformSegueWithIdentifier:sender:);
            if (xz_objc_class_addMethod(aClass, selT, nil, selN, NULL, selE)) {
                XZLog(@"为 UIViewController 重载方法 %@ 失败，相关事件请手动处理", NSStringFromSelector(selT));
            }
        } {
            SEL const selT = @selector(prepareForSegue:sender:);
            SEL const selN = @selector(xz_mocoa_new_prepareForSegue:sender:);
            SEL const selE = @selector(xz_mocoa_exchange_prepareForSegue:sender:);
            if (xz_objc_class_addMethod(aClass, selT, nil, selN, NULL, selE)) {
                XZLog(@"为 UIViewController 重载方法 %@ 失败，相关事件请手动处理", NSStringFromSelector(selT));
            }
        }
    }
}

- (BOOL)xz_mocoa_new_shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([sender conformsToProtocol:@protocol(XZMocoaView)]) {
        return [sender shouldPerformSegueWithIdentifier:identifier];
    }
    return YES;
}

- (BOOL)xz_mocoa_exchange_shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([sender conformsToProtocol:@protocol(XZMocoaView)]) {
        return [sender shouldPerformSegueWithIdentifier:identifier];
    }
    return [self xz_mocoa_exchange_shouldPerformSegueWithIdentifier:identifier sender:sender];;
}

- (void)xz_mocoa_new_prepareForSegue:(UIStoryboardSegue *)segue sender:(id<XZMocoaView>)sender {
    if ([sender conformsToProtocol:@protocol(XZMocoaView)]) {
        [sender prepareForSegue:segue];
    }
}

- (void)xz_mocoa_exchange_prepareForSegue:(UIStoryboardSegue *)segue sender:(id<XZMocoaView>)sender {
    if ([sender conformsToProtocol:@protocol(XZMocoaView)]) {
        [sender prepareForSegue:segue];
    } else {
        [self xz_mocoa_exchange_prepareForSegue:segue sender:sender];
    }
}

@end

@implementation XZMocoaModule (UIViewControllerInstantiation)

- (__kindof UIViewController *)instantiateViewControllerWithOptions:(XZMocoaOptions)options {
    Class const ViewController = self.viewClass;
    if (![ViewController isSubclassOfClass:UIViewController.class]) {
        XZLog(@"当前模块 %@ 不是 UIViewController 模块，无法构造视图控制器", self);
        return nil;
    }
    NSString *nibName = self.viewNibName;
    NSBundle *bundle  = self.viewNibBundle;
    return [[ViewController alloc] initWithMocoaOptions:options nibName:nibName bundle:bundle];
}

- (__kindof UIView *)instantiateViewWithFrame:(CGRect)frame {
    if (self.viewNibName) {
        UINib *nib = [UINib nibWithNibName:self.viewNibName bundle:self.viewNibBundle];
        for (UIView *object in [nib instantiateWithOwner:nil options:nil]) {
            if ([object isKindOfClass:self.viewNibClass]) {
                object.frame = frame;
                return object;
            };
        }
    }
    return [[self.viewClass alloc] initWithFrame:frame];
}

@end


@implementation UIViewController (XZMocoaModuleSupporting)

+ (__kindof UIViewController *)viewControllerWithMocoaURL:(NSURL *)url {
    XZMocoaOptions const options = [XZURLQuery queryForURL:url].dictionaryRepresentation;
    return [[XZMocoaModule moduleForURL:url] instantiateViewControllerWithOptions:options];
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
