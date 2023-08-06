//
//  XZMocoaListitySectionViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2021/1/13.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import <XZMocoa/XZMocoaViewModel.h>
#import <XZMocoa/XZMocoaListityBatchUpdatable.h>
#import <XZMocoa/XZMocoaListitySectionModel.h>
#import <XZMocoa/XZMocoaListitySectionHeaderViewModel.h>
#import <XZMocoa/XZMocoaListitySectionFooterViewModel.h>
#import <XZMocoa/XZMocoaListityCellViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZMocoaListitySectionViewModel<__covariant HeaderViewModelType: XZMocoaListitySectionHeaderViewModel *, __covariant FooterViewModelType: XZMocoaListitySectionFooterViewModel *, __covariant CellViewModelType: XZMocoaListityCellViewModel *> : XZMocoaViewModel <XZMocoaListityBatchUpdatable>

@property (nonatomic, strong, readonly, nullable) id<XZMocoaListitySectionModel> model;

@property (nonatomic, strong, readonly, nullable) HeaderViewModelType headerViewModel;
@property (nonatomic, strong, readonly, nullable) FooterViewModelType footerViewModel;
/// 所有 cell 视图模型。这是一个计算属性，除非遍历所有 cell 对象，请尽量避免直接使用。
@property (nonatomic, copy, readonly) NSArray<CellViewModelType> *cellViewModels;

/// 返回 YES 表示 header/cell/footer 都没有。
@property (nonatomic, readonly) BOOL isEmpty;

@property (nonatomic, readonly) NSInteger numberOfCells;
- (CellViewModelType)cellViewModelAtIndex:(NSInteger)index;
- (NSInteger)indexOfCellViewModel:(CellViewModelType)cellModel;

// MARK: - 局部更新

/// 重载所有视图模型。
- (void)reloadData;

/// 创建视图模型，并替换现有的视图模型。
/// @note 执行此方法前，请确保相应的数据已更新。
/// @param row 视图模型所在的行
- (void)reloadCellAtIndex:(NSInteger)row;

/// 创建视图模型，并插入到指定位置。
/// @note 执行此方法前，请确保已经新增相应的数据。
/// @param row 新增的行
- (void)insertCellAtIndex:(NSInteger)row;

/// 移除指定的视图模型。
/// @note 执行此方法前，请确保相应的数据已移除。
/// @param row 删除的行
- (void)deleteCellAtIndex:(NSInteger)row;

/// 创建视图模型，并替换现有的视图模型。
/// @note 执行此方法前，请确保相应的数据已更新。
/// @param rows 数据发生更新的行
- (void)reloadCellsAtIndexes:(nullable NSIndexSet *)rows;

/// 创建视图模型，并插入到指定位置。
/// @note 执行此方法前，请确保已经新增相应的数据。
/// @param rows 新增的行
- (void)insertCellsAtIndexes:(nullable NSIndexSet *)rows;

/// 移除指定的视图模型。
/// @note 执行此方法前，请确保相应的数据已移除。
/// @param rows 删除的行
- (void)deleteCellsAtIndexes:(nullable NSIndexSet *)rows;

/// 移动视图模型的位置。移动行 row 到新行 newRow 处。
/// @note 执行此方法前，请确保相应的数据已移动。
/// @param row 移动前的位置
/// @param newRow 移动后的位置
- (void)moveCellAtIndex:(NSInteger)row toIndex:(NSInteger)newRow;

// MARK: - 事件派发

/// 向上级发送 Section 重载事件，以刷新视图。
- (void)didReloadData;

/// 向上级发送 Cell 重载事件，以刷新视图。
- (void)didReloadCellsAtIndexes:(NSIndexSet *)rows;

/// 向上级发送 Cell 插入事件，以刷新视图。
- (void)didInsertCellsAtIndexes:(NSIndexSet *)rows;

/// 向上级发送 Cell 删除事件，以刷新视图。
- (void)didDeleteCellsAtIndexes:(NSIndexSet *)rows;

/// 向上级发送 Cell 移动事件，以刷新视图。
- (void)didMoveCellAtIndex:(NSInteger)row toIndex:(NSInteger)newRow;

// MARK: 子类必须重写的方法

- (HeaderViewModelType)loadHeaderViewModelWithModule:(nullable XZMocoaModule *)headerModule model:(nullable id)model;
- (CellViewModelType)loadCellViewModelWithModule:(nullable XZMocoaModule *)cellModule model:(nullable id)model;
- (FooterViewModelType)loadFooterViewModelWithModule:(nullable XZMocoaModule *)footerModule model:(nullable id)model;

@end

/// 整体刷新
FOUNDATION_EXPORT NSString * const XZMocoaListitySectionEmitReloadData;
/// 局部刷新，事件 value 为发生刷新的 cell 的 index 的集合 NSNSIndexSet 对象。
FOUNDATION_EXPORT NSString * const XZMocoaListitySectionEmitReloadCells;
/// 添加数据，事件 value 为发生添加的 cell 的 index 的集合 NSNSIndexSet 对象。
FOUNDATION_EXPORT NSString * const XZMocoaListitySectionEmitInsertCells;
/// 删除数据，事件 value 为发生删除的 cell 的 index 的集合 NSNSIndexSet 对象。
FOUNDATION_EXPORT NSString * const XZMocoaListitySectionEmitDeleteCells;
/// 添加数据，事件 value 为 { from: number, to: number } 字典。
FOUNDATION_EXPORT NSString * const XZMocoaListitySectionEmitMoveCell;
/// 批量更新，事件 value 为 block 函数
FOUNDATION_EXPORT NSString * const XZMocoaListitySectionEmitBatchUpdates;

NS_ASSUME_NONNULL_END
