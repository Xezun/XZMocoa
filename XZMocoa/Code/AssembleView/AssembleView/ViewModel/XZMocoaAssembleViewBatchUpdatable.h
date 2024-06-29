//
//  XZMocoaAssembleViewBatchUpdatable.h
//  XZMocoa
//
//  Created by Xezun on 2021/9/1.
//

#import <XZMocoa/XZMocoaDefines.h>

NS_ASSUME_NONNULL_BEGIN

@class XZMocoaViewModel;
/// 在批量更新的过程中，同一元素只能应用一个操作，但是在 MVVM 结构中，
/// 数据变化也可能会引起刷新操作，为了避免多个更新操作，因此会将这些操作暂存并延迟执行。
/// Mocoa 并不能区分所有重复操作，开发者应避免。
typedef void(^XZMocoaAssembleViewDelayedBatchUpdate)(__kindof XZMocoaViewModel *self);

/// 批量更新。
@protocol XZMocoaAssembleViewBatchUpdatable <NSObject>

/// 是否正在批量更新。
@property (nonatomic, readonly) BOOL isPerformingBatchUpdates;

/// 私有方法。准备批量更新环境，必须搭配`-cleanupBatchUpdates`使用。
/// @returns 是否可以开始批量更新
- (BOOL)prepareBatchUpdates XZ_UNAVAILABLE;

/// 私有方法。清理批量更新环境。
- (void)cleanupBatchUpdates XZ_UNAVAILABLE;

/// 批量更新：将一组`reload/insert/delete/move`操作放在块函数`batchUpdates`统一执行。
/// @discussion
/// 自动分析：一般情况下，仅需要在块函数`batchUpdates`中执行数据的更新逻辑，视图模型会自行分析数据变动并刷新视图。
/// @discussion
/// 差异分析依据`-isEqual:`方法，如果有重复数据，则差异分析关闭，执行整体刷新。
/// @code
/// [_viewModel performBatchUpdates:^{
///     [_dataArray removeAllObjects];
///     [_dataArray addObjectsFromArray:newData];
/// }];
/// @endcode
/// @discussion
/// 手动分析：在`batchUpdates`中，更新数据的同时执行`reload/insert/delete/move`方法。
/// @code
/// [_viewModel performBatchUpdates:^{
///     [_dataArray removeObjectAtIndex:0];
///     [_viewModel deleteSectionAtIndex:0];
///
///     id const data = _dataArray[3];
///     [_dataArray removeObjectAtIndex:3];
///     [_dataArray insertObject:data atIndex:5];
///     [_viewModel moveSectionAtIndex:3 toIndex:5];
/// }];
/// @endcode
/// @discussion
/// 需要注意的是，调用`reload/insert/delete/move`方法操作的实时数据，每次操作的对象应该是上一步操作后的结果，这与`UITableView`不同。
/// @discussion
/// 手动分析的更新逻辑由开发者控制，性能更好，能提高大批量数据情形下的性能，请以实际体验采用合适的方式。
/// @attention
/// 批量更新状态不可重入，上级进入批量更新状态，所有下级也会进入批量更新状态，即不能批量更新中，嵌套执行上级的批量更新方法。
/// @param batchUpdates 执行数据更新的块函数
- (void)performBatchUpdates:(void (^NS_NOESCAPE)(void))batchUpdates completion:(void (^ _Nullable)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
