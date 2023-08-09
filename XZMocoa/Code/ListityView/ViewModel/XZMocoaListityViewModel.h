//
//  XZMocoaListityViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2021/1/23.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import <XZMocoa/XZMocoaViewModel.h>
#import <XZMocoa/XZMocoaListitySectionViewModel.h>
#import <XZMocoa/XZMocoaListityCellViewModel.h>
#import <XZMocoa/XZMocoaListityModel.h>
#import <XZMocoa/XZMocoaListityBatchUpdatable.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZMocoaListityViewModelDelegate <NSObject>
@end

/// 具有列表形式视图的一般视图模型。
/// @attention 由于需要管理子视图，因此需要设置 module 属性才能正常工作。
@interface XZMocoaListityViewModel<__covariant CellViewModelType: XZMocoaListityCellViewModel *, __covariant SectionViewModelType: XZMocoaListitySectionViewModel *> : XZMocoaViewModel <XZMocoaListityBatchUpdatable>

/// 在进行批量更新或局部更新时，视图更新的动画效果，默认为 UITableViewRowAnimationAutomatic 自动选择合适的动画效果。
@property (nonatomic) UITableViewRowAnimation rowAnimation;

/// 一般而言 TableViewModel 只会有一个事件接收者，这里直接用了代理。
@property (nonatomic, weak) id<XZMocoaListityViewModelDelegate> delegate;

/// 判断是否为空。
@property (nonatomic, readonly) BOOL isEmpty;

/// 下级视图模型。
@property (nonatomic, readonly) NSArray<SectionViewModelType> *sectionViewModels;

- (SectionViewModelType)sectionViewModelAtIndex:(NSInteger)index;
- (NSInteger)indexOfSectionViewModel:(SectionViewModelType)sectionViewModel;

@property (nonatomic, readonly) NSInteger numberOfSections;
- (NSInteger)numberOfCellsInSection:(NSInteger)section;
- (CellViewModelType)cellViewModelAtIndexPath:(NSIndexPath *)indexPath;


// MARK: - 局部更新

/// 数据更新后，调用此方法以重载所有视图模型。
- (void)reloadData;

/// 指定 section 的数据更新后，调用此方法以重载该 section 的视图模型。
/// @param section 数据发生更新的行
- (void)reloadSectionAtIndex:(NSInteger)section;

/// 新增指定 section 的数据后，调用此方法以构造该 section 的视图模型。
/// @param section 新增的行
- (void)insertSectionAtIndex:(NSInteger)section;

/// 指定 section 的数据更新后，调用此方法以重载该 section 的视图模型。
/// @param section 数据发生更新的行
- (void)deleteSectionAtIndex:(NSInteger)section;

/// 指定 sections 的数据更新后，调用此方法以重载该 sections 的视图模型。
/// @param sections 数据发生更新的行
- (void)reloadSectionsAtIndexes:(nullable NSIndexSet *)sections;

/// 新增指定 sections 的数据后，调用此方法以构造该 sections 的视图模型。
/// @param sections 新增的行
- (void)insertSectionsAtIndexes:(nullable NSIndexSet *)sections;

/// 指定 sections 的数据更新后，调用此方法以重载该 sections 的视图模型。
/// @param sections 数据发生更新的行
- (void)deleteSectionsAtIndexes:(nullable NSIndexSet *)sections;

/// 移动行 section 到新行 newSection 处。
/// @param section 移动前的位置
/// @param newSection 移动后的位置
- (void)moveSectionAtIndex:(NSInteger)section toIndex:(NSInteger)newSection;

// MARK: - 事件派发

- (void)didReloadData;
- (void)didReloadCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
- (void)didInsertCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
- (void)didDeleteCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
- (void)didMoveCellAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath;
- (void)didReloadSectionsAtIndexes:(NSIndexSet *)sections;
- (void)didInsertSectionsAtIndexes:(NSIndexSet *)sections;
- (void)didDeleteSectionsAtIndexes:(NSIndexSet *)sections;
- (void)didMoveSectionAtIndex:(NSInteger)section toIndex:(NSInteger)newSection;
- (void)didPerformBatchUpdates:(void (^NS_NOESCAPE)(void))batchUpdates completion:(void (^ _Nullable)(BOOL finished))completion;

// MARK: 子类必须重写的方法

/// 子类应该重写此方法，并返回所需的 SectionViewModel 对象。
- (SectionViewModelType)loadViewModelForSectionAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
