//
//  XZMocoaListityBatchUpdatable.h
//  XZMocoa
//
//  Created by Xezun on 2021/9/1.
//

#import <XZMocoa/XZMocoaDefines.h>

NS_ASSUME_NONNULL_BEGIN

/// 批量更新。
@protocol XZMocoaListityBatchUpdatable <NSObject>

/// 是否正在批量更新。
@property (nonatomic, readonly) BOOL isPerformingBatchUpdates;

/// 私有方法。准备批量更新环境，必须搭配`-cleanupBatchUpdates`使用。
/// @returns 是否可以开始批量更新
- (BOOL)prepareBatchUpdates XZ_UNAVAILABLE;

/// 私有方法。清理批量更新环境。
- (void)cleanupBatchUpdates XZ_UNAVAILABLE;

/// 批量更新：将一组`reload/insert/delete/move`操作放在块函数`batchUpdates`统一执行。
/// @discussion 一般情况下，仅需要在块函数`batchUpdates`中执行数据的更新逻辑，视图模型会自行分析数据变动并刷新视图。
/// @code
/// - (void)createView {
///     _dataArray = [NSMutableArray arrayWithObjects:@"A", @"B", @"C", nil];
///     _viewModel = [[XZMocoaTableViewModel alloc] initWithModel:_dataArray];
///     _tableView.viewModel = _viewModel;
/// }
///
/// - (void)updateView {
///     NSArray *newData = @[@"0", @"1", @"C", @"6", @"E", @"8", @"F"];
///     [_viewModel performBatchUpdates:^{
///         [_dataArray removeAllObjects];
///         [_dataArray addObjectsFromArray:newData];
///     }];
/// }
/// @endcode
/// @discussion 也可以在`batchUpdates`中执行`reload/insert/delete/move`方法更新视图，且此时视图模型的自动分析功能会关闭。
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
/// @attention 批量更新状态不可重入，上级进入批量更新状态，则所有下级都进入批量更新状态，所以不能批量更新中，嵌套执行上级的批量更新方法。
/// @attention 需要注意的是，调用`reload/insert/delete/move`方法操作的实时数据，每次操作的对象应该是上一步操作后的结果，这与`UITableView`不同。
/// @attention @b差异分析依赖于数据的`-isEqual:`方法，因此不能出现重复数据。
/// @param batchUpdates 执行数据更新的块函数
- (void)performBatchUpdates:(void (^NS_NOESCAPE)(void))batchUpdates;

@end

NS_ASSUME_NONNULL_END
