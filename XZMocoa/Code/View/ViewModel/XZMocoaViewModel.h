//
//  XZMocoaViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2021/4/10.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XZMocoa/XZMocoaDefines.h>
#import <XZMocoa/XZMocoaModule.h>
#import <XZMocoa/XZMocoaModel.h>

NS_ASSUME_NONNULL_BEGIN

/// 视图模型 ViewModel 基类。
/// @discussion 本基类为简化开发而提供，并非 module 必须，可选。
/// @discussion 为视图模型提供了`ready`机制、层级关系等基础功能。
@interface XZMocoaViewModel : NSObject

/// 当前 MVVM 模块对象。
/// @note 一般情况下，此属性并非必须，但对于某些用于管理子视图的视图，比如拿 UITableView 或 UICollectionView 来说，可能需要设置此属性才能正常工作。
@property (nonatomic, strong, nullable) XZMocoaModule *module;

/// 数据。
@property (nonatomic, strong, readonly, nullable) id model;

/// 排序。
@property (nonatomic) NSInteger index;

/// 标准初始化方法。一般情况下，子类应尽量避免添加新的初始化方法，保证接口统一。
/// @param model 数据
- (instancetype)initWithModel:(nullable id)model NS_DESIGNATED_INITIALIZER;

/// 是否已完成初始化。
@property (nonatomic, readonly) BOOL isReady;

/// 若 isReady == NO 则调用 -prepare 方法，否则不执行任何操作。
- (void)ready;

/// 便利初始化方法：先调用 -initWithModel: 初始化，然后执行 -ready 方法。
/// @note
/// 一般用于根模块的 ViewModel 初始化。在层级关系中，子模块初始化，由上级模块管理。
/// @param model 数据
/// @param synchronously YES，立即同步执行 ready 方法；NO，在 -[NSRunLoop performBlock:] 中异步执行 ready 方法。
- (instancetype)initWithModel:(nullable id)model ready:(BOOL)synchronously;

/// 调用所有子 MVVM 模块的 -ready 方法，并标记为 isReady 状态。
/// @discussion ViewModel 应在此方法中，处理初始化逻辑。
/// @discussion 子类重写应根据需要，在合适的时机调用`super`实现。
/// @discussion 此方法仅供子类重写用，外部不应该直接调用此方法。
- (void)prepare;

@end

@interface XZMocoaViewModel (XZMocoaViewModelHierarchy)

/// 所有下级视图模型。
/// @note 属性值虽然为不可变数组，但并非拷贝，会跟随实际自动变化。
@property (nonatomic, strong, readonly) NSArray<__kindof XZMocoaViewModel *> *subViewModels;

/// 上级视图模型。
@property (nonatomic, readonly, nullable) __kindof XZMocoaViewModel *superViewModel;

/// 添加下级。
/// @note 会从其现有的上级移除。
- (void)addSubViewModel:(nullable XZMocoaViewModel *)subViewModel;

/// 将下级添加到指定位置。
/// @param subViewModel 下级
/// @param index 位置
- (void)insertSubViewModel:(nullable XZMocoaViewModel *)subViewModel atIndex:(NSInteger)index;

/// 移动原来在 index 位置的下级，到 newIndex 位置。
/// @param index 原始位置
/// @param newIndex 新位置，移动后所在的位置
- (void)moveSubViewModelAtIndex:(NSInteger)index toIndex:(NSInteger)newIndex;

/// 从上级中移除。
- (void)removeFromSuperViewModel;

/// 如果某一个下级被移除，那么此方法会被调用。
/// @note 默认不执行任何操作。
/// @param viewModel 已被移除的下级
- (void)didRemoveSubViewModel:(__kindof XZMocoaViewModel *)viewModel;

@end


// - Mocoa Hierarchy Emit -
// 在具有层级关系的业务模块中，下级模块向上级模块传递数据或事件，或者上级模块监听下级模块的数据或事件，
// 在 iOS 开发中一般使用代理模式，因为代理协议可以让上下级的逻辑关系看起来更清晰。
// 但是在使用 MVVM 设计模式开发时，因为模块的划分，原本在 MVC 模式下，可以直接交互的逻辑，变得不再
// 直接，这将间接导致我们在开发时，需要额外的工作量来设计模块交互的代码，开发效率和开发体验将会受影响。
// 而如果不进行模块分层，或减少划分模块，那么很可能导致模块太大，代码也就不可避免的出现臃肿，这又与我
// 们采用 MVVM 设计模式开发的初衷不符，所以划分模块是必须也是必要的。幸运的是，在实际开发中，大部分情
// 况下，模块与模块之间的交互，都是一些简单的交互，在框架层提供一种简单的交互机制，即可解决大部分层级模
// 块间的交互需求，所以 Mocoa 设计了基于层级关系的 Mocoa Hierarchy Emit 机制。
// Mocoa Hierarchy Emit 机制，只为解决层级模块间的交互问题，对于不同模块间的交互，或者比较复杂的
// 交互，Mocoa 也是建议采用常规代理或通知机制，对于代码而言，保持可维护性是优先级最高的。

///
typedef struct XZMocoaEmit {
    /// 事件名。
    NSString *                  __unsafe_unretained name;
    /// 事件值。
    id _Nullable                __unsafe_unretained value;
    /// 事件源。
    __kindof XZMocoaViewModel * __unsafe_unretained source;
} XZMocoaEmit;

/// 没有名称的事件，一般作为默认事件的事件名。
FOUNDATION_EXPORT NSString * const XZMocoaEmitNone;

@interface XZMocoaViewModel (XZMocoaViewModelHierarchyEmitting)
/// 收到下级模块的事件，或监听到下级模块的数据变化。
/// @discussion
/// 默认情况下，该方法直接将事件继续向上级模块传递，开发者可重写此方法，根据业务需要，控制事件是否向上传递。
/// @param subViewModel 传递事件的下级视图模型，可能非事件源，请根据 emit.source 获取事件源
/// @param emit 事件信息
- (void)subViewModel:(__kindof XZMocoaViewModel *)subViewModel didEmit:(XZMocoaEmit)emit;

/// 向上级模块发送事件或数据的便利方法，当前对象将作为事件源。
/// @param name 事件名，如为 nil 则为默认名称 XZMocoaEmitNone
/// @param value 事件值
- (void)emit:(nullable NSString *)name value:(nullable id)value;
@end


// Mocoa Keyed Actions
// 设计背景：
// 一种基于 target-action 方式的事件监听机制。
// 在 iOS 开发中，不论采用何种方式进行“键-值”绑定，都有着不小的开发量。
// “高级”的绑定，在形式上会减少一些代码量，但是其带来的维护成本，相对这些代码量并不是经济的。
// 而在 iOS 开发中，UI展示才是主要部分，对于响应式要求其实并不高，不应该放在设计架构的首选。
// 而 target-action 是 iOS 开发中的常用机制，与引入新机制相比，开发和维护成本都大大降低。
// 设计目的：
// ViewModel 的 target-action 机制，主要用于 ViewModel 向 View 发送事件。
// 在开发中，如果 ViewModel 的事件较多且复杂，建议使用 delegate 发送事件。但是对于大多数
// 业务场景中，ViewModel 事件不仅少而且单一，使用 target-action 机制就完全可以满足要求。
//


/// Mocoa Keyed Actions 事件名。
typedef NSString *XZMocoaKeyEvents;

/// 没有 key 也可作为一种事件，或者称为默认事件，值为空字符串。
FOUNDATION_EXPORT XZMocoaKeyEvents const XZMocoaKeyEventsNone;

/// 用于标记属性可以被添加 target-action 的属性或方法，仅起标记作用。
/// @code
/// @property (nonatomic) BOOL isLoading XZ_MOCOA_KEY();          // The keyEvents is 'isLoading'
/// @property (nonatomic) BOOL isLoading XZ_MOCOA_KEY("loading"); // The keyEvents is 'loading'
/// - (void)startLoading XZ_MOCOA_KEY("isLoading");               // The keyEvents is 'isLoading'
/// @endcode
/// @todo
/// 编译器插件，在属性中添加 mocoa=keyEvents 标记，生成的 setter 中添加发送 keyEvents 事件的代码。
#define XZ_MOCOA_KEY(keyEvents)

@interface XZMocoaViewModel (XZMocoaViewModelKeyEvents)

/// 添加 target-action 事件。
/// @note
/// 由于使用 -performSelector:withObject: 方法，所以 action 方法的必须没有返回值，即返回 void 值，否则可能会引起内存泄漏。
/// @note
/// 调用此方法时，target-action 会立即触发一次。
/// @param target 接收事件的对象
/// @param action 执行事件的方法，可接收一个参数，无返回值
/// @param keyEvents 事件，nil 表示添加默认事件
- (void)addTarget:(id)target action:(SEL)action forKeyEvents:(nullable XZMocoaKeyEvents)keyEvents;
/// 移除 target-action 事件。
/// @discussion
/// 移除所有匹配 target、action、keyEvents 的事件，值 nil 表示匹配所有，例如都为 nil 会移除所有事件。
/// @param target 接收事件的对象
/// @param action 执行事件的方法
/// @param keyEvents 绑定的事件
- (void)removeTarget:(nullable id)target action:(nullable SEL)action forKeyEvents:(nullable XZMocoaKeyEvents)keyEvents;
/// 发送 target-action 事件。
/// @param keyEvents 事件，nil 表示发送默认事件
- (void)sendActionsForKeyEvents:(nullable XZMocoaKeyEvents)keyEvents;

@end


//FOUNDATION_EXPORT void __mocoa_bind_3(XZMocoaViewModel *vm, SEL keySel, UILabel *target) XZATTR_OVERLOAD;
//FOUNDATION_EXPORT void __mocoa_bind_3(XZMocoaViewModel *vm, SEL keySel, UIImageView *target) XZATTR_OVERLOAD;
//
//FOUNDATION_EXPORT void __mocoa_bind_4(XZMocoaViewModel *vm, SEL keySel, UILabel *target, id _Nullable no) XZATTR_OVERLOAD;
//FOUNDATION_EXPORT void __mocoa_bind_4(XZMocoaViewModel *vm, SEL keySel, UIImageView *target, id _Nullable completion) XZATTR_OVERLOAD;
//
//FOUNDATION_EXPORT void __mocoa_bind_5(XZMocoaViewModel *vm, SEL keySel, id target, SEL setter, id _Nullable no) XZATTR_OVERLOAD;
//FOUNDATION_EXPORT void __mocoa_bind_5(XZMocoaViewModel *vm, SEL keySel, id target, XZMocoaAction action, id _Nullable no) XZATTR_OVERLOAD;
//
//#define __mocoa_bind_macro_imp_(index, vm, sel, view, ...) xzmacro_args_paste(__mocoa_bind_, index)(vm, @selector(sel), view, ##__VA_ARGS__)
//#define mocoa(viewModel, key, view, ...) xzmacro_keyize __mocoa_bind_macro_imp_(xzmacro_args_args_count(viewModel, key, view, ##__VA_ARGS__), viewModel, key, view, ##__VA_ARGS__)

NS_ASSUME_NONNULL_END
