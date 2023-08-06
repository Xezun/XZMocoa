//
//  XZMocoaView.h
//  XZMocoa
//
//  Created by Xezun on 2021/4/12.
//

#import <UIKit/UIKit.h>
#import <XZMocoa/XZMocoaViewModel.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - XZMocoaView 协议

/// 任何 UIView 及子类，声明遵循此协议，即可获得协议中定义的方法。
/// @note 由于运行时特性，Mocoa 的方法实现可能会被类目或子类覆盖，需要开发者自行注意。
@protocol XZMocoaView <NSObject>

@optional
/// 视图模型。
@property (nonatomic, strong, nullable) __kindof XZMocoaViewModel *viewModel;

/// 视图模型 KVC 事件，默认不执行任何操作。
- (void)viewModelWillChange;

/// 视图模型 KVC 事件，默认不执行任何操作。
- (void)viewModelDidChange;

/// 获取当前视图所在的视图控制器，如果自身已经是控制器，则返回自身。
@property (nonatomic, readonly, nullable) __kindof UIViewController *viewController;

/// 当前视图所属的导航控制器。
@property (nonatomic, readonly, nullable) __kindof UINavigationController *navigationController;

/// 当前视图所属栏目控制器。
@property (nonatomic, readonly, nullable) __kindof UITabBarController *tabBarController;

/// 控制器分发过来的 IB 转场事件。
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier;

/// 控制器分发过来的 IB 转场事件。
- (void)prepareForSegue:(UIStoryboardSegue *)segue;

@end


//@interface XZMocoaOptions : NSMutableDictionary
//
//+ (XZMocoaOptions *)optionsWithURL:(NSURL *)url;
//+ (XZMocoaOptions *)optionsWithDictionar:(NSDictionary *)dict;
//
//@end


@interface UIViewController (XZMocoaModuleSupporting)

/// 根据视图控制器的模块地址，构造视图控制器。
/// @discussion
/// 一般情况下，此方法用于进入，以视图控制器作为入口的模块，构造视图控制器用。
/// @discussion
/// 本方法使用 -initWithMocoaURL:nibName:bundle: 方法初始化视图控制器。
/// @discussion
/// 可通过 url 的 query 携带参数传递给新的控制器。
/// @param url 模块地址
+ (nullable __kindof UIViewController *)viewControllerWithMocoaURL:(NSURL *)url;
//+ (nullable __kindof UIViewController *)viewControllerWithMocoaModule:(XZMocoaModule *)aModule options:(id)options;

/// XZMocoaModule 使用此方法初始化控制器。
/// @discussion
/// 便利初始化方法，默认直接调用 -initWithNibName:bundle: 方法完成初始化。
/// @discussion
/// 子类可以通过重写此方法获取 url 中的参数信息，或将控制器的初始化改为其它初始化方法。
/// @param url 创建控制器时所用的 url 对象
- (instancetype)initWithMocoaURL:(NSURL *)url nibName:(nullable NSString *)nibName bundle:(nullable NSBundle *)bundle;
//- (instancetype)initWithMocoaOptions:(id)options nibName:(nullable NSString *)nibName bundle:(nullable NSBundle *)bundle;

/// 通过 XZMocoaURL 弹出层控制器。
/// @discussion 如果 XZMocoaURL 没有对应的控制器，那么此方法将不产生任何效果。
/// @param url XZMocoaURL
/// @param flag 是否动画
/// @param completion 回调
- (nullable __kindof UIViewController *)presentViewControllerWithMocoaURL:(nullable NSURL *)url animated:(BOOL)flag completion:(void (^_Nullable)(void))completion;

/// 通过 XZMocoaURL 添加子控制器。
/// @discussion 如果 XZMocoaURL 没有对应的控制器，那么此方法将不产生任何效果。
/// @param url XZMocoaURL
- (nullable __kindof UIViewController *)addChildViewControllerWithMocoaURL:(nullable NSURL *)url;

@end

@interface UINavigationController (XZMocoaModuleSupporting)

/// 通过 XZMocoaURL 创建根控制器初始化。
/// @discussion 如果没有找到 XZMocoaURL 对应的控制器，那么将调用 -init 方法进行初始化。
/// @param url XZMocoaURL
- (instancetype)initWithRootViewControllerWithMocoaURL:(nullable NSURL *)url;
/// 通过 XZMocoaURL 压栈子控制器。
/// @discussion 如果 XZMocoaURL 没有对应的控制器，那么此方法将不产生任何效果。
/// @param url XZMocoaURL
/// @param animated 是否动画。
- (nullable __kindof UIViewController *)pushViewControllerWithMocoaURL:(nullable NSURL *)url animated:(BOOL)animated;

@end

@interface UITabBarController (XZMocoaModuleSupporting)
/// 通过 XZMocoaURLs 设置子控制器。
/// @discussion 如果某个 XZMocoaURL 没有对应的控制器，那么该 XZMocoaURL 会被忽略。
/// @param urls XZMocoaURLs
/// @param animated 是否动画
- (nullable NSArray<__kindof UIViewController *> *)setViewControllersWithMocoaURLs:(nullable NSArray<NSURL *> *)urls animated:(BOOL)animated;
@end


NS_ASSUME_NONNULL_END

