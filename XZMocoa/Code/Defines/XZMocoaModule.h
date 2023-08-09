//
//  XZMocoaModule.h
//  XZMocoa
//
//  Created by Xezun on 2021/8/13.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import <XZMocoa/XZMocoaDefines.h>
#import <XZMocoa/XZMocoaDomain.h>

NS_ASSUME_NONNULL_BEGIN

/// 名称。
/// @seealso XZMocoaModule
/// @attention 请仅用数字、字母（区分大小写）组成的名称。
typedef NSString *XZMocoaName;

/// 分类。
/// @seealso XZMocoaModule
/// @attention 请仅用数字、字母（区分大小写）组成的名称。
typedef NSString *XZMocoaKind;

/// 默认名称，或者没有名称。
FOUNDATION_EXPORT XZMocoaName const XZMocoaNameNone;
/// 默认分类，或者没有分类。
FOUNDATION_EXPORT XZMocoaKind const XZMocoaKindNone;
/// 用于表示 Header 的分类。
FOUNDATION_EXPORT XZMocoaKind const XZMocoaKindHeader;
/// 用于表示 Footer 的分类。
FOUNDATION_EXPORT XZMocoaKind const XZMocoaKindFooter;
/// 用于表示 Section 的分类。
FOUNDATION_EXPORT XZMocoaKind const XZMocoaKindSection;
/// 用于表示 Cell 的分类。
FOUNDATION_EXPORT XZMocoaKind const XZMocoaKindCell;

@class XZMocoaModule;

/// 为 XZMocoaModule 提供下标式访问方法的协议。
@protocol XZMocoaNamedModulesSubscripting <NSObject>
- (nullable XZMocoaModule *)objectForKeyedSubscript:(nullable XZMocoaName)name;
- (void)setObject:(nullable XZMocoaModule *)submodule forKeyedSubscript:(nullable XZMocoaName)name;
- (void)enumerateKeysAndObjectsUsingBlock:(void (NS_NOESCAPE ^)(XZMocoaName name, XZMocoaModule *submodule, BOOL *stop))block;
@end

/// 为 XZMocoaModule 提供下标式访问方法的协议。
/// @code
/// // 常规方式获取下级
/// XZMocoaModule *submodule = [module submoduleForKind:@"header" forName:@"black"];
/// // 下标方式来获取下级
/// XZMocoaModule *submodule = module[@"header"][@"black"];
/// @endcode
@protocol XZMocoaKindedModulesSubscripting <NSObject>
- (id<XZMocoaNamedModulesSubscripting>)objectForKeyedSubscript:(nullable XZMocoaKind)kind;
- (void)setObject:(nullable id<XZMocoaNamedModulesSubscripting>)newModules forKeyedSubscript:(nullable XZMocoaKind)kind;
@end

/// Mocoa MVVM 模块。
/// @discussion
/// 在 Mocoa 中，由 Model-View-ViewModel 组成的单元被称为模块。
@interface XZMocoaModule : NSObject <XZMocoaKindedModulesSubscripting>

/// 模块地址，每个模块都应该有唯一的地址。
/// @note
/// 在开发中，根据业务的分类和分层，将模块设计成 URL 的管理方式很常见，所以 Mocoa 也采取了这种方式。
/// @discussion
/// @b domain @c 不同类型的业务模块，使用 domain 进行区分。
/// @discussion
/// @b path   @c 相同类型的业务模块，使用 path 表示模块的层级关系。
/// @discussion
/// @b query  @c 模块传值。
/// @note
/// 模块的 path 名，由模块的 kind 和 name 组成，格式如下：
/// @discussion
/// @b kind:name @c 表示模块的 Mocoa Kind 和 Mocoa Name 都不为空。
/// @discussion
/// @b kind:     @c 表示模块的 Mocoa Name 为空。
/// @discussion
/// @b name      @c 表示模块的 Mocoa Kind 为空。
@property (nonatomic, copy, readonly) NSURL *url;

/// 请使用 +moduleForURL: 来创建对象。
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithURL:(NSURL *)url NS_DESIGNATED_INITIALIZER;

/// 获取指定 url 对应的模块的 XZMocoaModule 对象。
/// @discussion
/// 推荐使用 Mocoa(stringOrURL) 函数，获取模块对象。
/// @param url 模块地址
+ (nullable XZMocoaModule *)moduleForURL:(nullable NSURL *)url;

/// 获取指定 url 字符串对应的模块的 XZMocoaModule 对象。
/// @discussion
/// 推荐使用 Mocoa(stringOrURL) 函数，获取模块对象。
/// - Parameter urlString: 模块地址
+ (nullable XZMocoaModule *)moduleForURLString:(nullable NSString *)urlString;

/// 获取指定路径的子模块的 XZMocoaModule 对象。
/// @param path XZMocoaURLPath
- (XZMocoaModule *)submoduleForPath:(NSString *)path;

#pragma mark - MVVM 基本结构

/// MVVM 中 Model 的 class 对象。
@property (nonatomic, strong, nullable) Class modelClass;

/// MVVM 中 View 的 class 对象。
@property (nonatomic, strong, nullable) Class viewClass;
/// MVVM 中 View 的 class 对象，但是应该使用 nib 初始化。
@property (nonatomic, strong, getter=viewClass, setter=setViewNibWithClass:, nullable) Class viewNibClass;
/// MVVM 中 View 的 nib 的名称，优先级比属性 viewClass 高。
@property (nonatomic, strong, readonly, nullable) NSString *viewNibName;
/// MVVM 中 View 的 nib 所在的包。
@property (nonatomic, strong, readonly, nullable) NSBundle *viewNibBundle;
/// 设置 View 的 nib 信息。
/// @param viewClass 视图的 class 对象
/// @param nibName 视图 nib 名称
/// @param bundle 视图 nib 所在的包
- (void)setViewNibWithClass:(Class)viewClass name:(nullable NSString *)nibName bundle:(nullable NSBundle *)bundle;
/// nib 所在的 bundle 通过 +\[NSBundle bundleForClass:\] 方法获取。
- (void)setViewNibWithClass:(Class)viewClass name:(nullable NSString *)nibName;
/// nib 的名称通过 NSStringFromClass(aClass) 函数获取。
- (void)setViewNibWithClass:(Class)viewClass;

/// MVVM 中 ViewModel 的 class 对象。
@property (nonatomic, strong, nullable) Class viewModelClass;

/// 遍历所有子模块的 XZMocoaModule 对象。
/// - Parameter block: 块函数
- (void)enumerateSubmodulesUsingBlock:(void (^NS_NOESCAPE)(XZMocoaModule *submodule, XZMocoaKind kind, XZMocoaName name, BOOL *stop))block;

#pragma mark - 访问下级的基础方法

/// 获取指定分类下的子模块的 XZMocoaModule 对象。
/// @note 该方法为懒加载。
/// @param kind 分类
/// @param name 名称
- (XZMocoaModule *)submoduleForKind:(nullable XZMocoaKind)kind forName:(nullable XZMocoaName)name;

/// 设置或删除指定分类下指定名称的子模块的 XZMocoaModule 对象。
/// @note 该方法一般用于删除下级，添加下级请用懒加载方法。
/// @param newSubmodule 子模块的 XZMocoaModule 对象
/// @param kind 分类
/// @param name 名称
- (void)setSubmodule:(nullable XZMocoaModule *)newSubmodule forKind:(nullable XZMocoaKind)kind forName:(nullable XZMocoaName)name;

/// 获取指定分类下的子模块的的 XZMocoaModule 对象，非懒加载。
/// @param kind 分类
/// @param name 名称
- (nullable XZMocoaModule *)submoduleIfLoadedForKind:(nullable XZMocoaKind)kind forName:(nullable XZMocoaName)name;

/// 获取默认分类的子模块的 XZMocoaModule 对象。
/// @param name 子模块名称
- (XZMocoaModule *)submoduleForName:(nullable XZMocoaName)name;

/// 设置或删除默认分类下的子模块的 XZMocoaModule 对象。
/// @param newSubmodule 子模块的 XZMocoaModule 对象
/// @param name 名称
- (void)setSubmodule:(nullable XZMocoaModule *)newSubmodule forName:(nullable XZMocoaName)name;

@end

@interface XZMocoaModule (XZMocoaExtendedModule)

#pragma mark - 为 tableView、collectionView 提供的便利方法

/// 获取 UITableView/UICollection 的默认下级。
/// @note Section 是 UITableView/UICollection 的默认下级，如果只有一种 Section 的话，那么不需要为它具名。
/// @attention 此属性仅用于表示 UITableView/UICollection 的 Mocoa 对象。
/// @discussion 此属性等同于：
/// @code
/// [mocoa submoduleForName:XZMocoaNameNone forKind:XZMocoaKindNone];
/// @endcode
@property (nonatomic, strong, null_resettable) XZMocoaModule *section;

/// 获取 UITableView/UICollection 的指定名称的下级。
/// @note Section 是 UITableView/UICollection 的默认下级。
/// @attention 此方法仅用于表示 UITableView/UICollection 的 Mocoa 对象。
/// @discussion 此属性等同于：
/// @code
/// [mocoa submoduleForName:name forKind:XZMocoaKindNone];
/// @endcode
/// @param name 下级的名称
- (XZMocoaModule *)sectionForName:(XZMocoaName)name;
- (void)setSection:(nullable XZMocoaModule *)section forName:(XZMocoaName)name;

/// 获取 UITableView/UICollection 中 Section 的 Header 分类下默认下级。
/// @attention 此属性仅用于表示 UITableView/UICollection 中 Section 的 Mocoa 对象。
/// @discussion 此方法等同于：
/// @code
/// [mocoa submoduleForName:XZMocoaNameNone forKind:XZMocoaKindHeader];
/// @endcode
@property (nonatomic, strong, null_resettable) XZMocoaModule *header;

/// 获取 UITableView/UICollection 中 Section 的 Header 分类下指定下级。
/// @attention 此方法仅用于表示 UITableView/UICollection 中 Section 的 Mocoa 对象。
/// @discussion 此方法等同于：
/// @code
/// [mocoa submoduleForName:name forKind:XZMocoaKindHeader];
/// @endcode
/// @param name 下级的名称
- (XZMocoaModule *)headerForName:(XZMocoaName)name;
- (void)setHeader:(nullable XZMocoaModule *)header forName:(XZMocoaName)name;

/// 获取 UITableView/UICollection 中 Section 的默认下级。
/// @note Cell 是 UITableView/UICollection 中 Section 的默认下级，如果只有一种 Cell 的话，那么不需要为它具名。
/// @attention 此属性仅用于表示 UITableView/UICollection 中 Section 的 Mocoa 对象。
/// @discussion 此方法等同于：
/// @code
/// [mocoa submoduleForName:XZMocoaNameNone forKind:XZMocoaNameNone];
/// @endcode
@property (nonatomic, strong, null_resettable) XZMocoaModule *cell;

/// 获取 UITableView/UICollection 中 Section 的默认分类中的指定下级。
/// @note Cell 是 UITableView/UICollection 中 Section 的默认下级。
/// @attention 此方法仅用于表示 UITableView/UICollection 中 Section 的 Mocoa 对象。
/// @discussion 此方法等同于：
/// @code
/// [mocoa submoduleForName:name forKind:XZMocoaNameNone];
/// @endcode
/// @param name 下级的名称
- (XZMocoaModule *)cellForName:(XZMocoaName)name;
- (void)setCell:(nullable XZMocoaModule *)cell forName:(XZMocoaName)name;

/// 获取 UITableView/UICollection 中 Section 的 Footer 分类下默认下级。
/// @attention 此属性仅用于表示 UITableView/UICollection 中 Section 的 Mocoa 对象。
/// @discussion 此方法等同于：
/// @code
/// [mocoa submoduleForName:XZMocoaNameNone forKind:XZMocoaKindFooter];
/// @endcode
@property (nonatomic, strong, null_resettable) XZMocoaModule *footer;

/// 获取 UITableView/UICollection 中 Section 的 Footer 分类下指定下级。
/// @attention 此方法仅用于表示 UITableView/UICollection 中 Section 的 Mocoa 对象。
/// @discussion 此方法等同于：
/// @code
/// [mocoa submoduleForName:name forKind:XZMocoaKindFooter];
/// @endcode
/// @param name 下级的名称
- (XZMocoaModule *)footerForName:(XZMocoaName)name;
- (void)setFooter:(nullable XZMocoaModule *)footer forName:(XZMocoaName)name;

@end

/// 构造 cell 重用标识符。
/// - Parameters:
///   - sectionName: cell 所在的 section 的 mocoaName
///   - cellName: cell 的 mocoaName
FOUNDATION_STATIC_INLINE NSString *XZMocoaReuseIdentifier(XZMocoaName _Nullable section, XZMocoaKind _Nullable kind, XZMocoaName _Nullable cell) XZATTR_OVERLOAD {
    return [NSString stringWithFormat:@"%@-%@-%@", section ?: XZMocoaNameNone, kind ?: XZMocoaKindNone, cell ?: XZMocoaNameNone];
}

FOUNDATION_STATIC_INLINE NSString *XZMocoaReuseIdentifier(XZMocoaName section, XZMocoaName cell) XZATTR_OVERLOAD {
    return [NSString stringWithFormat:@"%@--%@", section, cell];
}

@interface XZMocoaModuleProvider : NSObject <XZMocoaModuleProvider>
/// 子类可以通过此方法构造统一格式的 URL 对象。
/// - Parameters:
///   - name: 域名
///   - path: 路径
- (NSURL *)urlForName:(NSString *)name path:(NSString *)path;
@end

/// 获取模块地址 NSURL 或 NSString 获取对应的 MVVM 模块。
/// @param stringOrURL 模块的地址，NSString 或 NSURL 对象
FOUNDATION_STATIC_INLINE XZMocoaModule * _Nullable XZMocoa(NSString *stringOrURL) XZATTR_OVERLOAD {
    return [XZMocoaModule moduleForURLString:stringOrURL];
}

/// 获取模块地址 NSURL 或 NSString 获取对应的 MVVM 模块。
/// @param stringOrURL 模块的地址，NSString 或 NSURL 对象
FOUNDATION_STATIC_INLINE XZMocoaModule * _Nullable XZMocoa(NSURL *stringOrURL) XZATTR_OVERLOAD {
    return [XZMocoaModule moduleForURL:stringOrURL];
}

NS_ASSUME_NONNULL_END
