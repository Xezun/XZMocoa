//
//  XZMocoaListitySectionViewModel.m
//  XZMocoa
//
//  Created by Xezun on 2021/1/13.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import "XZMocoaListitySectionViewModel.h"
#import "XZMocoaDefines.h"
@import XZExtensions;

NSString * const XZMocoaListitySectionEmitReloadData   = @"XZMocoaListitySectionEmitReloadData";
NSString * const XZMocoaListitySectionEmitReloadCells  = @"XZMocoaListitySectionEmitReloadCells";
NSString * const XZMocoaListitySectionEmitInsertCells  = @"XZMocoaListitySectionEmitInsertCells";
NSString * const XZMocoaListitySectionEmitDeleteCells  = @"XZMocoaListitySectionEmitDeleteCells";
NSString * const XZMocoaListitySectionEmitMoveCell     = @"XZMocoaListitySectionEmitMoveCell";
NSString * const XZMocoaListitySectionEmitBatchUpdates = @"XZMocoaListitySectionEmitBatchUpdates";

@interface XZMocoaListitySectionViewModel () {
    /// 非 nil 时，表示当前正在批量更新。
    NSOrderedSet *_isPerformingBatchUpdates;
    /// 是否需要执行批量更新的差异分析。
    /// @note 在批量更新时，任一更新操作被调用，都会标记此值为 NO
    BOOL _needsDifferenceBatchUpdates;
    /// 记录 cell 视图模型的数组。
    NSMutableOrderedSet<XZMocoaListityCellViewModel *> *_cellViewModels;
    NSMutableDictionary<XZMocoaKind, NSMutableArray<XZMocoaViewModel *> *> *_supplementaryViewModels;
}
@end

@implementation XZMocoaListitySectionViewModel

@dynamic model;

- (instancetype)initWithModel:(id)model {
    self = [super initWithModel:model];
    if (self) {
        _isPerformingBatchUpdates = nil;
        _cellViewModels           = [NSMutableOrderedSet orderedSet];
        _supplementaryViewModels  = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)prepare {
    [self loadDataWithoutEvents];
    [super prepare];
}

- (void)didRemoveSubViewModel:(__kindof XZMocoaViewModel *)viewModel {
    for (XZMocoaKind kind in _supplementaryViewModels) {
        NSMutableArray * const viewModels = _supplementaryViewModels[kind];
        NSInteger        const count      = viewModels.count;
        if (count == 1) {
            if (viewModels.firstObject == viewModel) {
                _supplementaryViewModels[kind] = nil;
                return;
            }
        } else {
            for (NSInteger index = 0; index < count; index++) {
                if (viewModels[index] == viewModel) {
                    [viewModels removeObjectAtIndex:index];
                    return;
                }
            }
        }
    }
    [_cellViewModels removeObject:viewModel];
}

#pragma mark - 公开方法

- (BOOL)isEmpty {
    return _supplementaryViewModels.count == 0 && _cellViewModels.count == 0;
}

- (NSArray *)cellViewModels {
    return _cellViewModels.array;
}

- (XZMocoaViewModel *)viewModelForSupplementaryKind:(XZMocoaKind)kind atIndex:(NSInteger)index {
    return _supplementaryViewModels[kind][index];
}

- (NSInteger)numberOfCells {
    return _cellViewModels.count;
}

- (__kindof XZMocoaListityCellViewModel *)cellViewModelAtIndex:(NSInteger)index {
    return [_cellViewModels objectAtIndex:index];
}

- (NSInteger)indexOfCellViewModel:(XZMocoaListityCellViewModel *)cellModel {
    return [_cellViewModels indexOfObject:cellModel];
}

#pragma mark - 局部更新

- (void)reloadData {
    _needsDifferenceBatchUpdates = NO;
    
    { // 清理旧数据
        NSMutableDictionary * const supplementaryViewModels = _supplementaryViewModels.copy;
        NSOrderedSet        * const cellViewModels          = _cellViewModels.copy;
        
        [_supplementaryViewModels removeAllObjects];
        [_cellViewModels removeAllObjects];
        
        [supplementaryViewModels enumerateKeysAndObjectsUsingBlock:^(id key, NSMutableArray *obj, BOOL *stop) {
            [obj enumerateObjectsUsingBlock:^(XZMocoaViewModel *viewModel, NSUInteger idx, BOOL * _Nonnull stop) {
                [viewModel removeFromSuperViewModel];
            }];
        }];
        for (XZMocoaViewModel *viewModel in cellViewModels) {
            [viewModel removeFromSuperViewModel];
        }
    }
    // 加载新数据
    [self loadDataWithoutEvents];
    
    // 发送事件
    [self didReloadData];
}

- (void)reloadCellAtIndex:(NSInteger)row {
    [self reloadCellsAtIndexes:[NSIndexSet indexSetWithIndex:row]];
}

- (void)insertCellAtIndex:(NSInteger)row {
    [self insertCellsAtIndexes:[NSIndexSet indexSetWithIndex:row]];
}

- (void)deleteCellAtIndex:(NSInteger)row {
    [self deleteCellsAtIndexes:[NSIndexSet indexSetWithIndex:row]];
}

- (void)reloadCellsAtIndexes:(NSIndexSet *)rows {
    _needsDifferenceBatchUpdates = NO;
    
    if (rows.count == 0) {
        return;
    }
    
    if (self.isPerformingBatchUpdates) {
        NSMutableIndexSet * const oldRows = [NSMutableIndexSet indexSet];
        [rows enumerateIndexesUsingBlock:^(NSUInteger row, BOOL * _Nonnull stop) {
            XZMocoaListityCellViewModel * const oldViewModel = [self cellViewModelAtIndex:row];
            NSInteger const oldRow = [_isPerformingBatchUpdates indexOfObject:oldViewModel];
            [oldRows addIndex:oldRow];
            [oldViewModel removeFromSuperViewModel];
            
            id const newViewModel = [self loadViewModelForCellAtIndex:row];
            [self insertCellViewModel:newViewModel atIndex:row];
        }];
        [self didReloadCellsAtIndexes:oldRows];
    } else {
        [rows enumerateIndexesUsingBlock:^(NSUInteger row, BOOL * _Nonnull stop) {
            XZMocoaListityCellViewModel * const oldViewModel = _cellViewModels[row];
            [oldViewModel removeFromSuperViewModel]; // 由 -didRemoveSubViewModel: 执行清理
            
            id const newViewModel = [self loadViewModelForCellAtIndex:row];
            [self insertCellViewModel:newViewModel atIndex:row];
        }];
        [self didReloadCellsAtIndexes:rows];
    }
}

- (void)insertCellsAtIndexes:(NSIndexSet *)rows {
    _needsDifferenceBatchUpdates = NO;
    
    if (rows.count == 0) {
        return;
    }
    
    [rows enumerateIndexesUsingBlock:^(NSUInteger row, BOOL * _Nonnull stop) {
        id const newViewModel = [self loadViewModelForCellAtIndex:row];
        [self insertCellViewModel:newViewModel atIndex:row];
    }];
    
    [self didInsertCellsAtIndexes:rows];
    
    NSInteger const count = self.numberOfCells;
    for (NSInteger row = rows.firstIndex; row < count; row++) {
        if ([rows containsIndex:row]) {
            continue;
        }
        [self cellViewModelAtIndex:row].index = row;
    }
}

- (void)deleteCellsAtIndexes:(NSIndexSet *)rows {
    _needsDifferenceBatchUpdates = NO;
    
    if (rows.count == 0) {
        return;
    }
    
    if (self.isPerformingBatchUpdates) {
        NSMutableIndexSet * const oldRows = [NSMutableIndexSet indexSet];
        [rows enumerateIndexesWithOptions:NSEnumerationReverse usingBlock:^(NSUInteger row, BOOL * _Nonnull stop) {
            XZMocoaListityCellViewModel * const oldViewModel = [self cellViewModelAtIndex:row];
            NSInteger const oldRow = [_isPerformingBatchUpdates indexOfObject:oldViewModel];
            [oldRows addIndex:oldRow];
            
            [oldViewModel removeFromSuperViewModel];
        }];
        [self didDeleteCellsAtIndexes:oldRows];
    } else {
        [rows enumerateIndexesWithOptions:NSEnumerationReverse usingBlock:^(NSUInteger row, BOOL * _Nonnull stop) {
            XZMocoaListityCellViewModel * const oldViewModel = [self cellViewModelAtIndex:row];
            [oldViewModel removeFromSuperViewModel];
        }];
        [self didDeleteCellsAtIndexes:rows];
        
        NSInteger const count = self.numberOfCells;
        for (NSInteger row = rows.firstIndex; row < count; row++) {
            [self cellViewModelAtIndex:row].index = row;
        }
    }
}

- (void)moveCellAtIndex:(NSInteger)row toIndex:(NSInteger)newRow {
    if (self.isPerformingBatchUpdates) {
        id const viewModel = [self cellViewModelAtIndex:row];
        NSInteger const oldRow = [_isPerformingBatchUpdates indexOfObject:viewModel];
        [self moveCellAtIndex:row fromIndex:oldRow toIndex:newRow];
    } else {
        [self moveCellAtIndex:row fromIndex:row toIndex:newRow];
        
        NSInteger const min = MIN(row, newRow);
        NSInteger const max = MAX(row, newRow);
        for (NSInteger row = min; row <= max; row++) {
            [self cellViewModelAtIndex:row].index = row;
        }
    }
}

/// 移动 Cell 位置。
/// @param row 当前位置
/// @param oldRow 原始位置（批量更新前的位置）
/// @param newRow 目标位置
- (void)moveCellAtIndex:(NSInteger)row fromIndex:(NSInteger)oldRow toIndex:(NSInteger)newRow {
    _needsDifferenceBatchUpdates = NO;
    
    if (row != newRow) {
        [self moveCellViewModelFromIndex:row toIndex:newRow];
    }
    
    if (oldRow == newRow) {
        return;
    }
    
    [self didMoveCellAtIndex:oldRow toIndex:newRow];
}

#pragma mark - 事件派发

- (void)didReloadData {
    if (self.isReady) {
        [self emit:XZMocoaListitySectionEmitReloadData value:nil];
    }
}

- (void)didReloadCellsAtIndexes:(NSIndexSet *)rows {
    if (self.isReady) {
        [self emit:XZMocoaListitySectionEmitReloadCells value:rows];
    }
}

- (void)didInsertCellsAtIndexes:(NSIndexSet *)rows {
    if (self.isReady) {
        [self emit:XZMocoaListitySectionEmitInsertCells value:rows];
    }
}

- (void)didDeleteCellsAtIndexes:(NSIndexSet *)rows {
    if (self.isReady) {
        [self emit:XZMocoaListitySectionEmitDeleteCells value:rows];
    }
}

- (void)didMoveCellAtIndex:(NSInteger)row toIndex:(NSInteger)newRow {
    if (self.isReady) {
        [self emit:XZMocoaListitySectionEmitMoveCell value:@{
            @"from": @(row),
            @"to": @(newRow)
        }];
    }
}

#pragma mark - 批量更新

- (BOOL)isPerformingBatchUpdates {
    return _isPerformingBatchUpdates != nil;
}

- (BOOL)prepareBatchUpdates {
    if (_isPerformingBatchUpdates) {
        XZLog(@"当前正在批量更新，本次操作取消");
        return NO;
    }
    _isPerformingBatchUpdates = _cellViewModels.copy;
    return YES;
}

- (void)cleanupBatchUpdates {
    _isPerformingBatchUpdates = nil;
}

- (void)performBatchUpdates:(void (^NS_NOESCAPE)(void))batchUpdates {
    NSAssert(batchUpdates != nil, @"必须提供 batchUpdates 参数");
    XZLog(@"----- 批量更新开始 %@ -----", self);
    if (![self prepareBatchUpdates]) {
        return;
    }
    
    void (^const tableViewBatchUpdates)(void) = ^{
        self->_needsDifferenceBatchUpdates = YES;
        batchUpdates();
        [self differenceBatchUpdatesIfNeeded];
    };
    
    if (self.isReady) {
        [self emit:XZMocoaListitySectionEmitBatchUpdates value:tableViewBatchUpdates];
    } else {
        tableViewBatchUpdates();
    }
    [self cleanupBatchUpdates];
    
    NSInteger const count = self.numberOfCells;
    for (NSInteger row = 0; row < count; row++) {
        [self cellViewModelAtIndex:row].index = row;
    }
    
    XZLog(@"----- 批量更新结束 %@ -----", self);
}

- (void)differenceBatchUpdatesIfNeeded {
    if (!_needsDifferenceBatchUpdates) {
        return;
    }
    _needsDifferenceBatchUpdates = NO;
    
    id<XZMocoaListitySectionModel> const model = self.model;
    
    BOOL needsUpdateAll = NO;
    for (XZMocoaKind const kind in model.supplementaryKinds) {
        NSInteger const count = [model numberOfModelsForSupplementaryKind:kind];
        for (NSInteger index = 0; index < count; index++) {
            id newModel = [model modelForSupplementaryKind:kind atIndex:index];
            id oldModel = _supplementaryViewModels[kind][index].model;
            if (!(newModel == oldModel || [newModel isEqual:oldModel])) {
                needsUpdateAll = YES;
                break;
            }
        }
        if (needsUpdateAll) break;
    }
    
    NSInteger      const oldCount      = self.numberOfCells;
    NSArray      * const oldDataModels = [NSMutableArray arrayWithCapacity:oldCount];
    NSOrderedSet * const oldViewModels = _isPerformingBatchUpdates.copy;
    for (NSInteger i = 0; i < oldCount; i++) {
        XZMocoaListityCellViewModel * const viewModel = oldViewModels[i];
        
        id dataModel = viewModel.model;
        if (dataModel == nil) {
            dataModel = NSNull.null;
        }
        [(NSMutableArray *)oldDataModels addObject:dataModel];
    }
    
    if (oldDataModels.xz_containsDuplicateObjects) {
        [self reloadData];
        XZLog(@"由于旧数据中包含重复元素，本次批量更新没有进行差异化分析");
        return;
    }
    
    NSInteger        const newCount      = model.numberOfCellModels;
    NSMutableArray * const newDataModels = [NSMutableArray arrayWithCapacity:newCount];
    for (NSInteger i = 0; i < newCount; i++) {
        id dataModel = [self.model modelForCellAtIndex:i];
        if (dataModel == nil) {
            dataModel = NSNull.null;
        }
        [newDataModels addObject:dataModel];
    }
    
    if (newDataModels.xz_containsDuplicateObjects) {
        [self reloadData];
        XZLog(@"由于新数据中包含重复元素，本次批量更新没有进行差异化分析");
        return;
    }
    
    NSIndexSet   * const inserts = [NSMutableIndexSet indexSet];
    NSIndexSet   * const deletes = [NSMutableIndexSet indexSet];
    NSIndexSet   * const remains = [NSMutableIndexSet indexSet];
    NSDictionary<NSNumber *, NSNumber *> * const changes = [NSMutableDictionary dictionaryWithCapacity:oldCount];
    [newDataModels xz_differenceFromArray:oldDataModels inserts:(id)inserts deletes:(id)deletes changes:(id)changes remains:(id)remains];
    
    XZLog(@"【差异分析】开始");
    XZLog(@"『原始』%@", oldDataModels);
    XZLog(@"『目标』%@", newDataModels);
    XZLog(@"『保留』%@", remains);

    // 1、更新数据：先执行删除，后执行添加
    [deletes enumerateIndexesWithOptions:NSEnumerationReverse usingBlock:^(NSUInteger row, BOOL * _Nonnull stop) {
        [[self cellViewModelAtIndex:row] removeFromSuperViewModel];
    }];
    
    [inserts enumerateIndexesUsingBlock:^(NSUInteger row, BOOL * _Nonnull stop) {
        XZMocoaListityCellViewModel * const newViewModel = [self loadViewModelForCellAtIndex:row];
        [self insertCellViewModel:newViewModel atIndex:row];
    }];
    
    // 2、更新视图：整体刷新时，就不需要差异性分析
    if ( needsUpdateAll ) {
        // 视图整体刷新
        [self didReloadData];
    } else {
        // 视图局部刷新
        [self didDeleteCellsAtIndexes:deletes];
        XZLog(@"『删除』%@", deletes);
        [self didInsertCellsAtIndexes:inserts];
        XZLog(@"『添加』%@", inserts);
        // 记录新插入的元素，因为排序移动的过程中，新插入元素的位置可能发生变化。
        NSDictionary * const insertedViewModels = [inserts xz_reduce:nil next:^id(NSMutableDictionary *result, NSInteger idx, BOOL *stop) {
            if (result == nil) {
                result = [NSMutableDictionary dictionaryWithCapacity:inserts.count];
            }
            result[@(idx)] = [self cellViewModelAtIndex:idx];
            return result;
        }];
        
        // 排序移动
        for (NSInteger to = 0; to < newCount; to++) {
            if ([inserts containsIndex:to]) {
                // to 位置为新插入的元素，先找到 viewModel 当前位置，然后将其移动到 to 位置上。
                id const viewModel = insertedViewModels[@(to)];
                NSInteger const index = [self indexOfCellViewModel:viewModel];
                [self moveCellViewModelFromIndex:index toIndex:to];
            } else if ([remains containsIndex:to]) {
                // to 位置为保持不变的元素，在 old 中找到 viewModel 然后将其移动到 to 位置上。
                id const viewModel = oldViewModels[to];
                NSInteger const index = [self indexOfCellViewModel:viewModel];
                [self moveCellViewModelFromIndex:index toIndex:to];
            } else {
                // to 位置为被移动的元素，先找到它原来的位置，然后找到 viewModel 然后再移动位置。
                NSInteger const from = changes[@(to)].integerValue;
                id const viewModel = oldViewModels[from];
                NSInteger const index = [self indexOfCellViewModel:viewModel];
                [self moveCellAtIndex:index fromIndex:from toIndex:to];
                XZLog(@"『移动』%ld(%ld) -> %ld, %@", (long)from, (long)index, (long)to, self.cellDataModels);
            }
        }
    }
    
    // 检查结果
    NSAssert([self.cellDataModels isEqualToArray:newDataModels], @"更新结果与预期不一致");
}

#pragma mark - 私有方法

- (void)addCellViewModel:(XZMocoaListityCellViewModel *)cellViewModel {
    [_cellViewModels addObject:cellViewModel];
    [self addSubViewModel:cellViewModel];
}

- (void)insertCellViewModel:(XZMocoaListityCellViewModel *)cellViewModel atIndex:(NSInteger)index {
    [_cellViewModels insertObject:cellViewModel atIndex:index];
    [self addSubViewModel:cellViewModel];
}

- (void)moveCellViewModelFromIndex:(NSInteger)row toIndex:(NSInteger)newRow {
    id const viewModel = _cellViewModels[row];
    [_cellViewModels removeObjectAtIndex:row];
    [_cellViewModels insertObject:viewModel atIndex:newRow];
}

- (void)loadDataWithoutEvents {
    NSAssert(_supplementaryViewModels.count == 0 && _cellViewModels.count == 0, @"调用此方法前要清除现有的数据");
    
    id<XZMocoaListitySectionModel> const model = self.model;
    
    for (XZMocoaKind kind in model.supplementaryKinds) {
        NSInteger const count = [model numberOfModelsForSupplementaryKind:kind];
        for (NSInteger index = 0; index < count; index++) {
            XZMocoaListitySectionSupplementaryViewModel *vm = [self loadViewModelForSupplementaryKind:kind atIndex:index];
            if (vm) {
                if (_supplementaryViewModels[kind]) {
                    [_supplementaryViewModels[kind] addObject:vm];
                } else {
                    _supplementaryViewModels[kind] = [NSMutableArray arrayWithObject:vm];
                }
                [self addSubViewModel:vm];
            }
        }
    }
    
    NSInteger const count = model.numberOfCellModels;
    for (NSInteger index = 0; index < count; index++) {
        XZMocoaListityCellViewModel *viewModel = [self loadViewModelForCellAtIndex:index];
        [self addCellViewModel:viewModel];
    }
}

#if DEBUG
- (NSArray *)cellDataModels {
    NSInteger const count = self.numberOfCells;
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i = 0; i < count; i++) {
        id dataModel = [self cellViewModelAtIndex:i].model;
        if (dataModel == nil) {
            dataModel = [NSNull null];
        }
        [result addObject:dataModel];
    }
    return result;
}
#endif

#pragma mark - 子类重写

- (XZMocoaListityCellViewModel *)loadViewModelForCellAtIndex:(NSInteger)index {
    id<XZMocoaModel> const model   = [self.model modelForCellAtIndex:index];
    XZMocoaName      const name    = model.mocoaName;
    XZMocoaModule *  const module  = [self.module cellForName:name];
    Class            const VMClass = module.viewModelClass ?: [XZMocoaListityCellViewModel class];
    
    XZMocoaListityCellViewModel *vm = [[VMClass alloc] initWithModel:model];
    vm.index      = index;
    vm.module     = module;
    vm.identifier = XZMocoaReuseIdentifier(self.model.mocoaName, XZMocoaKindCell, name);
    return vm;
}

- (XZMocoaListitySectionSupplementaryViewModel *)loadViewModelForSupplementaryKind:(XZMocoaKind)kind atIndex:(NSInteger)index {
    id<XZMocoaModel> model = [self.model modelForSupplementaryKind:kind atIndex:index];
    if (model == nil) {
        return nil;
    }
    XZMocoaName     const name    = model.mocoaName;
    XZMocoaModule * const module  = [self.module submoduleForKind:kind forName:name];
    Class           const VMClass = module.viewModelClass ?: [XZMocoaListitySectionSupplementaryViewModel class];
    
    XZMocoaListitySectionSupplementaryViewModel *vm = [[VMClass alloc] initWithModel:model];
    vm.index      = index;
    vm.module     = module;
    vm.identifier = XZMocoaReuseIdentifier(self.model.mocoaName, kind, name);
    return vm;
}

@end
