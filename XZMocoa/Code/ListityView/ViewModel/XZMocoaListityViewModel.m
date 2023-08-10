//
//  XZMocoaListityViewModel.m
//  XZMocoa
//
//  Created by Xezun on 2021/1/23.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import "XZMocoaListityViewModel.h"
#import "XZMocoaDefines.h"
#import "XZMocoaModule.h"
@import XZExtensions;

@interface XZMocoaListityViewModel () {
    /// 标记当前是否正处于批量更新过程中，记录了更新前的数据。
    NSOrderedSet<XZMocoaListitySectionViewModel *> *_isPerformingBatchUpdates;
    /// 批量更新时，被延迟的更新。
    NSMutableArray<XZMocoaListityDelayedBatchUpdate> *_delayedBatchUpdates;
    /// 是否需要执行批量更新的差异分析。
    /// @note 在批量更新时，由于同一对象不能重复操作，因此任一独立更新操作被调用时，都会标记此值为NO，以关闭差异分析，避免重复操作。
    BOOL _needsDifferenceBatchUpdates;
    /// 保存所有 section 视图模型。
    NSMutableOrderedSet<XZMocoaListitySectionViewModel *> *_sectionViewModels;
}

@end

@implementation XZMocoaListityViewModel

- (instancetype)initWithModel:(id)model {
    self = [super initWithModel:model];
    if (self) {
        _isPerformingBatchUpdates = nil;
        _sectionViewModels = [NSMutableOrderedSet orderedSet];
    }
    return self;
}

- (void)prepare {
    [self _loadDataWithoutEvents];
    [super prepare];
}

- (void)didRemoveSubViewModel:(__kindof XZMocoaViewModel *)viewModel {
    [_sectionViewModels removeObject:viewModel];
}

- (NSArray<XZMocoaListitySectionViewModel *> *)sectionViewModels {
    return _sectionViewModels.array;
}

- (BOOL)isEmpty {
    return _sectionViewModels.count == 0;
}

- (NSInteger)numberOfSections {
    return _sectionViewModels.count;
}

- (NSInteger)numberOfCellsInSection:(NSInteger)section {
    return _sectionViewModels[section].numberOfCells;
}

- (__kindof XZMocoaListitySectionViewModel *)sectionViewModelAtIndex:(NSInteger)index {
    return _sectionViewModels[index];
}

- (__kindof XZMocoaListityCellViewModel *)cellViewModelAtIndexPath:(NSIndexPath *)indexPath {
    return [_sectionViewModels[indexPath.section] cellViewModelAtIndex:indexPath.row];
}

- (NSInteger)indexOfSectionViewModel:(XZMocoaListitySectionViewModel *)sectionModel {
    return [_sectionViewModels indexOfObject:sectionModel];
}

#pragma mark - 处理 SectionViewModel 的事件

- (void)subViewModel:(__kindof XZMocoaViewModel *)subViewModel didEmit:(XZMocoaEmit *)emit {
    if ([emit.name isEqualToString:XZMocoaEmitUpdate]) {
        if (self.isPerformingBatchUpdates) {
            [_delayedBatchUpdates addObject:^void(XZMocoaListityViewModel *self) {
                [self subViewModel:subViewModel didEmit:emit];
            }];
            return;
        }
        NSInteger const index = [self indexOfSectionViewModel:subViewModel];
        if (index != NSNotFound) {
            [self didReloadSectionsAtIndexes:[NSIndexSet indexSetWithIndex:index]];
            return;
        }
    }
    [super subViewModel:subViewModel didEmit:emit];
}

#pragma mark - 局部更新

- (void)reloadData {
    _needsDifferenceBatchUpdates = NO;
    
    {
        // 清理旧数据
        NSOrderedSet * const sectionViewModels = _sectionViewModels.copy;
        [_sectionViewModels removeAllObjects];
        for (XZMocoaViewModel * const viewModel in sectionViewModels) {
            [viewModel removeFromSuperViewModel];
        }
        // 加载新数据
        [self _loadDataWithoutEvents];
    }
    
    [self didReloadData];
}

- (void)reloadSectionAtIndex:(NSInteger)section {
    [self reloadSectionsAtIndexes:[NSIndexSet indexSetWithIndex:section]];
}

- (void)insertSectionAtIndex:(NSInteger)section {
    [self insertSectionsAtIndexes:[NSIndexSet indexSetWithIndex:section]];
}

- (void)deleteSectionAtIndex:(NSInteger)section {
    [self deleteSectionsAtIndexes:[NSIndexSet indexSetWithIndex:section]];
}

- (void)reloadSectionsAtIndexes:(NSIndexSet *)sections {
    _needsDifferenceBatchUpdates = NO;
    
    if (sections.count == 0) {
        return;
    }
    
    // 在批量操作时，同一个元素只能进行一种操作，包括被动的操作（比如减少一个元素，后面的元素自动向前移动一个位置）。
    // 并且在 -[UITableView reloadSections:withRowAnimation:] 的接口文档中，reload 行为与 delete 类似。
    // 所以即使在批量更新过程中，也只能对未进行任何操作的元素，即还保持在原始位置的元素，执行 reload 操作。
    
    if (self.isPerformingBatchUpdates) {
        // 在批量更新的过程中，由于操作的先后顺序的随机性，元素的实时排序，可能并非最终排序，
        // 所以需要根据当前位置找到对应元素的原始位置，对原始位置执行 reload 操作。
        NSMutableIndexSet * const oldSections = [NSMutableIndexSet indexSet];
        [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
            XZMocoaListitySectionViewModel * const oldViewModel = [self sectionViewModelAtIndex:idx];
            NSInteger const oldSection = [_isPerformingBatchUpdates indexOfObject:oldViewModel];
            [oldSections addIndex:oldSection];
            [oldViewModel removeFromSuperViewModel];
            
            id const newViewModel = [self loadViewModelForSectionAtIndex:idx];
            [self _insertSectionViewModel:newViewModel atIndex:idx];
        }];
        
        [self didReloadSectionsAtIndexes:oldSections];
    } else {
        [sections enumerateIndexesUsingBlock:^(NSUInteger const section, BOOL * _Nonnull stop) {
            XZMocoaListitySectionViewModel * const oldViewModel = [self sectionViewModelAtIndex:section];
            [oldViewModel removeFromSuperViewModel];
            
            XZMocoaListitySectionViewModel *newViewModel = [self loadViewModelForSectionAtIndex:section];
            [self _insertSectionViewModel:newViewModel atIndex:section];
        }];
        
        [self didReloadSectionsAtIndexes:sections];
    }
}

- (void)insertSectionsAtIndexes:(NSIndexSet *)sections {
    _needsDifferenceBatchUpdates = NO;
    
    if (sections.count == 0) {
        return;
    }
    
    // 添加元素，正向遍历：只有前面的元素正确了，后面的才能正确。
    [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL * _Nonnull stop) {
        id const newViewModel = [self loadViewModelForSectionAtIndex:section];
        [self _insertSectionViewModel:newViewModel atIndex:section];
    }];
    
    [self didInsertSectionsAtIndexes:sections];
    
    // 后更新 index 以避免因 index 改变而发生视图刷新时，当前的事件还没有派发。
    NSInteger const count = self.numberOfSections;
    for (NSInteger section = sections.firstIndex; section < count; section++) {
        [self sectionViewModelAtIndex:section].index = section;
    }
}

- (void)deleteSectionsAtIndexes:(NSIndexSet *)sections {
    _needsDifferenceBatchUpdates = NO;
    
    if (sections.count == 0) {
        return;
    }
    
    // 删除元素，反向遍历：从后面开始删除，不会影响前面的
    if (self.isPerformingBatchUpdates) {
        NSMutableIndexSet * const oldSections = [NSMutableIndexSet indexSet];
        [sections enumerateIndexesWithOptions:NSEnumerationReverse usingBlock:^(NSUInteger section, BOOL *stop) {
            XZMocoaListitySectionViewModel * const oldViewModel = [self sectionViewModelAtIndex:section];
            NSInteger const oldSection   = [_isPerformingBatchUpdates indexOfObject:oldViewModel];
            [oldSections addIndex:oldSection];
            [oldViewModel removeFromSuperViewModel];
        }];
        [self didDeleteSectionsAtIndexes:oldSections];
    } else {
        [sections enumerateIndexesWithOptions:NSEnumerationReverse usingBlock:^(NSUInteger section, BOOL *stop) {
            XZMocoaListitySectionViewModel * const oldViewModel = [self sectionViewModelAtIndex:section];
            [oldViewModel removeFromSuperViewModel];
        }];
        
        [self didDeleteSectionsAtIndexes:sections];
        
        // 后更新 index 以避免因 index 改变而发生视图刷新时，当前的事件还没有派发。
        NSInteger const count = self.numberOfSections;
        for (NSInteger section = sections.firstIndex; section < count; section++) {
            [self sectionViewModelAtIndex:section].index = section;
        }
    }
}

- (void)moveSectionAtIndex:(NSInteger)section toIndex:(NSInteger)newSection {
    if (self.isPerformingBatchUpdates) {
        // 批量更新过程中，移动 section 需要找到原始位置
        id        const oldViewModel = [self sectionViewModelAtIndex:section];
        NSInteger const oldSection   = [_isPerformingBatchUpdates indexOfObject:oldViewModel];
        [self _moveSectionAtIndex:section fromIndex:oldSection toIndex:newSection];
    } else {
        [self _moveSectionAtIndex:section fromIndex:section toIndex:newSection];
        
        // 先刷型视图，后更新 index 的原因：
        // 因为 index 改变，可能会导致视图再次发生刷新，那么就会导致
        // 后续的刷新先应用到视图，从而发生问题。
        NSInteger const min = MIN(section, newSection);
        NSInteger const max = MAX(section, newSection);
        for (NSInteger index = min; index <= max; index++) {
            [self sectionViewModelAtIndex:index].index = index;
        }
    }
}

#pragma mark - 事件派发

- (void)didReloadData {
    NSString *reason = [NSString stringWithFormat:@"应该使用子类，并重 %s 方法", __PRETTY_FUNCTION__];
    @throw [NSException exceptionWithName:NSGenericException reason:reason userInfo:nil];
}

- (void)didReloadCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    NSString *reason = [NSString stringWithFormat:@"应该使用子类，并重 %s 方法", __PRETTY_FUNCTION__];
    @throw [NSException exceptionWithName:NSGenericException reason:reason userInfo:nil];
}

- (void)didInsertCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    NSString *reason = [NSString stringWithFormat:@"应该使用子类，并重 %s 方法", __PRETTY_FUNCTION__];
    @throw [NSException exceptionWithName:NSGenericException reason:reason userInfo:nil];
}

- (void)didDeleteCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    NSString *reason = [NSString stringWithFormat:@"应该使用子类，并重 %s 方法", __PRETTY_FUNCTION__];
    @throw [NSException exceptionWithName:NSGenericException reason:reason userInfo:nil];
}

- (void)didMoveCellAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath {
    NSString *reason = [NSString stringWithFormat:@"应该使用子类，并重 %s 方法", __PRETTY_FUNCTION__];
    @throw [NSException exceptionWithName:NSGenericException reason:reason userInfo:nil];
}

- (void)didReloadSectionsAtIndexes:(NSIndexSet *)sections {
    NSString *reason = [NSString stringWithFormat:@"应该使用子类，并重 %s 方法", __PRETTY_FUNCTION__];
    @throw [NSException exceptionWithName:NSGenericException reason:reason userInfo:nil];
}

- (void)didInsertSectionsAtIndexes:(NSIndexSet *)sections {
    NSString *reason = [NSString stringWithFormat:@"应该使用子类，并重 %s 方法", __PRETTY_FUNCTION__];
    @throw [NSException exceptionWithName:NSGenericException reason:reason userInfo:nil];
}

- (void)didDeleteSectionsAtIndexes:(NSIndexSet *)sections {
    NSString *reason = [NSString stringWithFormat:@"应该使用子类，并重 %s 方法", __PRETTY_FUNCTION__];
    @throw [NSException exceptionWithName:NSGenericException reason:reason userInfo:nil];
}

- (void)didMoveSectionAtIndex:(NSInteger)oldSection toIndex:(NSInteger)newSection {
    NSString *reason = [NSString stringWithFormat:@"应该使用子类，并重 %s 方法", __PRETTY_FUNCTION__];
    @throw [NSException exceptionWithName:NSGenericException reason:reason userInfo:nil];
}

- (void)didPerformBatchUpdates:(void (^NS_NOESCAPE)(void))batchUpdates completion:(void (^ _Nullable)(BOOL))completion {
    NSString *reason = [NSString stringWithFormat:@"应该使用子类，并重 %s 方法", __PRETTY_FUNCTION__];
    @throw [NSException exceptionWithName:NSGenericException reason:reason userInfo:nil];
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
    
    _isPerformingBatchUpdates = _sectionViewModels.copy;
    _delayedBatchUpdates = [NSMutableArray array];
    return YES;
}

- (NSArray<XZMocoaListityDelayedBatchUpdate> *)cleanupBatchUpdates {
    if (!_isPerformingBatchUpdates) {
        return nil;
    }
    _isPerformingBatchUpdates = nil;
    NSArray *delayedBatchUpdates = _delayedBatchUpdates;
    _delayedBatchUpdates = nil;
    return delayedBatchUpdates;
}

- (void)setNeedsDifferenceBatchUpdates {
    _needsDifferenceBatchUpdates = YES;
}

- (void)performBatchUpdates:(void (^NS_NOESCAPE)(void))batchUpdates completion:(void (^ _Nullable)(BOOL))completion {
    NSParameterAssert(batchUpdates != nil);
    XZLog(@"===== 批量更新开始 %@ =====", self);
    
    if (![self prepareBatchUpdates]) {
        return;
    }
    
    // 批量更新的过程中，由于 section 内的局部更新可能并不会反馈到 section 的变化上来。
    // 比如对 section 数据进行了排序，这并不是 section 整体的更新，
    // 因此对于未更新的 section 会在 table 批量更新后，执行 -performBatchUpdates:completion: 方法以进行更新。
    NSIndexSet * __block forwardIndexes = nil;
    // 由于进行了分步批量更新，需要一个标记，使 completion 在所有更新完成后再执行。
    NSInteger    __block flagCompletion = 0;
    
    void (^const tableViewBatchUpdates)(void) = ^{
        flagCompletion += 1;
        [self setNeedsDifferenceBatchUpdates];
        batchUpdates();
        forwardIndexes = [self differenceBatchUpdatesIfNeeded];
    };
    void (^const tableViewCompletion)(BOOL) = ^(BOOL finished){
        XZLog(@"flagCompletion: %ld", flagCompletion);
        flagCompletion -= 1;
        if (flagCompletion > 0) return;
        if (completion) completion(finished);
    };
    
    // 批量事件
    [self didPerformBatchUpdates:tableViewBatchUpdates completion:tableViewCompletion];
    
    // 清理批量更新环境，并执行延迟的事件
    [self cleanupBatchUpdates];
    
    // 后更新 index 以避免因 index 改变而发生视图刷新时，当前的事件还没有派发。
    NSInteger const count = self.numberOfSections;
    for (NSInteger section = 0; section < count; section++) {
        [self sectionViewModelAtIndex:section].index = section;
    }
    
    // 传递事件给保留的下级
    if (forwardIndexes.count > 0) {
        void (^const tableViewBatchUpdates)(void) = ^{
            flagCompletion += 1;
            [forwardIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                [[self sectionViewModelAtIndex:idx] performBatchUpdates:^{
                    // section 内的更新数据已经在 batchUpdates() 执行了。
                } completion:nil];
            }];
        };
        [self didPerformBatchUpdates:tableViewBatchUpdates completion:tableViewCompletion];
    }
    
    XZLog(@"===== 批量更新结束 %@ =====", self);
}

/// 对数据进行差异分析，并执行更新。
/// @discussion
/// 单次批量更新，同一个`Cell`只能有一种变化行为，比如，在移动`Section`的同时操作该`Section`中的`Cell`会直接发生崩溃。
/// 所以，先处理 Section 的变化，然后再由 Section 处理 Cell 的变化：
/// @discussion
/// 1、对于`updates`或`inserts`操作，由于会创建的新视图模型，所以其内部的`Cell`视图模型也是最新的，不需要额外处理。
/// @discussion
/// 2、对于`remains`或`changes`操作，由于不能同时执行其它操作，所以需要在批量更新执行完之后，再发送批量更新事件。
/// @discussion
/// 理论上，由于 remains 没有任何操作，在批量更新时应该可以直接发送批量更新事件，但实际在测试中，还是会发生重复操作的崩溃。
/// 测试数据如下：
/// @code
/// // 更新前
/// NSArray *old = @[@"0", @"1", @"2", @"3", @"4", @"F", @"6", @"E", @"8", @"9", @"10", @"11", @"C"];
/// NSArray *new = @[@"A", @"B", @"C", @"D", @"E", @"F"];
/// @endcode
/// @todo 实现二维数组的差异比较，解决跨 section 的更新问题。
- (NSIndexSet *)differenceBatchUpdatesIfNeeded {
    if (!_needsDifferenceBatchUpdates) {
        return nil;
    }
    _needsDifferenceBatchUpdates = NO;
    
    // 记录更新前的数据。
    NSInteger      const oldCount      = self.numberOfSections;
    NSArray      * const oldDataModels = [NSMutableArray arrayWithCapacity:oldCount];
    NSOrderedSet * const oldViewModels = _isPerformingBatchUpdates.copy;
    for (NSInteger i = 0; i < oldCount; i++) {
        XZMocoaListitySectionViewModel * const viewModel = oldViewModels[i];
        id const dataModel = viewModel.model;
        [(NSMutableArray *)oldDataModels addObject:(dataModel ?: NSNull.null)];
    }
    
    if (oldDataModels.xz_containsDuplicateObjects) {
        [self reloadData];
        XZLog(@"由于旧数据中包含重复元素，本次批量更新没有进行差异化分析");
        return nil;
    }
    
    id<XZMocoaListityModel> const model = self.model;
    
    // 获取更新后的数据。
    NSInteger const newCount      = model.numberOfSectionModels;
    NSArray * const newDataModels = [NSMutableArray arrayWithCapacity:newCount];
    for (NSInteger i = 0; i < newCount; i++) {
        id const dataModel = [model modelForSectionAtIndex:i];
        [(NSMutableArray *)newDataModels addObject:(dataModel ?: NSNull.null)];
    }
    
    if (newDataModels.xz_containsDuplicateObjects) {
        [self reloadData];
        XZLog(@"由于新数据中包含重复元素，本次批量更新没有进行差异化分析");
        return nil;
    }
    
    // 差异分析及更新算法：
    // 对于更新后的所有元素，只可能属于 remain/updates/changes/inserts 中的一个。
    // 在执行删除、插入操作后，列表数量就与预期的一致了，即仅需要排序即可，但是由于删除或插入操作，
    // 也可能会改变 remain、changes 中的元素，且排序的过程中，也可能会改变其他元素的位置，
    // 因此在处理排序时，应从低位 0 开始遍历，逐个查找该位置上预期元素，然后将其移动到该位置上。
    
    XZLog(@"【原始】%@", oldDataModels);
    XZLog(@"【目标】%@", newDataModels);
    XZLog(@"【差异分析】开始");

    NSIndexSet                           * const inserts = [NSMutableIndexSet indexSet];
    NSIndexSet                           * const deletes = [NSMutableIndexSet indexSet];
    NSIndexSet                           * const remains = [NSMutableIndexSet indexSet];
    NSDictionary<NSNumber *, NSNumber *> * const changes = [NSMutableDictionary dictionaryWithCapacity:oldCount];
    [newDataModels xz_differenceFromArray:oldDataModels inserts:(id)inserts deletes:(id)deletes changes:(id)changes remains:(id)remains];
    XZLog(@"【不变】%@", remains);

    // 删除元素，反向遍历：从后面开始删除，不会影响前面的
    [deletes enumerateIndexesWithOptions:NSEnumerationReverse usingBlock:^(NSUInteger section, BOOL *stop) {
        XZMocoaListitySectionViewModel * const oldViewModel = [self sectionViewModelAtIndex:section];
        [oldViewModel removeFromSuperViewModel];
    }];
    [self didDeleteSectionsAtIndexes:deletes];
    XZLog(@"【删除】%@", deletes);
    
    // 添加元素，正向遍历：按位置记录下新添加的元素，以便在后续排序时，查找该位置上的元素。
    NSMutableDictionary * const insertedViewModels = [NSMutableDictionary dictionaryWithCapacity:inserts.count];
    [inserts enumerateIndexesUsingBlock:^(NSUInteger section, BOOL * _Nonnull stop) {
        XZMocoaListitySectionViewModel * const newViewModel = [self loadViewModelForSectionAtIndex:section];
        [self _insertSectionViewModel:newViewModel atIndex:section];
        insertedViewModels[@(section)] = newViewModel;
    }];
    [self didInsertSectionsAtIndexes:inserts];
    XZLog(@"【添加】%@", inserts);
    
    NSMutableIndexSet * const forwardIndexes = [NSMutableIndexSet indexSet];
    
    // 排序元素：从低位开始遍历，每一个位置，都应该能根据 inserts/remains/changes 中找到对应的元素。
    for (NSInteger to = 0; to < newCount; to++) {
        if ([inserts containsIndex:to]) {
            NSInteger const index = [self indexOfSectionViewModel:insertedViewModels[@(to)]];
            [self _moveSectionViewModelFromIndex:index toIndex:to];
            XZLog(@"【调整】%ld -> %ld, %@", (long)index, (long)to, self.sectionDataModels);
        } else if ([remains containsIndex:to]) {
            // to 位置为保持不变的元素，在 old 中找到 viewModel 然后将其移动到 to 位置上。
            XZMocoaListitySectionViewModel *viewModel = oldViewModels[to];
            NSInteger const index = [self indexOfSectionViewModel:viewModel];
            [self moveSubViewModelAtIndex:index toIndex:to];
            // 执行更新。在数据更新的过程中，由数据引发的更新已经在更新数据时被拦截下来，在这里差异分析时，不会再触发了。
            [viewModel performBatchUpdates:^{
                // Model 已更新，ViewModel 未更新，直接发送事件即可。
            } completion:nil];;
            XZLog(@"【调整】%ld -> %ld, %@", (long)index, (long)to, self.sectionDataModels);
        } else {
            // to 位置为被移动的元素，先找到它原来的位置，然后找到 viewModel 然后再移动位置。
            NSInteger const from  = changes[@(to)].integerValue;
            NSInteger const index = [self indexOfSectionViewModel:oldViewModels[from]];
            // 移动 section 并更新视图
            [self _moveSectionViewModelFromIndex:index toIndex:to];
            [self didMoveSectionAtIndex:from toIndex:to];
            XZLog(@"【移动】%ld(%ld) -> %ld, %@", from, index, to, self.sectionDataModels);
            // 记录待更新的 section
            [forwardIndexes addIndex:to];
        }
    }

    // 检查结果
    NSAssert([self.sectionDataModels isEqualToArray:newDataModels], @"更新结果与预期不一致");
    
    return forwardIndexes;
}

#pragma mark - 私有方法

/// 将 viewModel 添加到末尾，并添加为子元素。
- (void)_addSectionViewModel:(XZMocoaListitySectionViewModel *)sectionViewModel {
    NSParameterAssert([sectionViewModel isKindOfClass:[XZMocoaListitySectionViewModel class]]);
    [_sectionViewModels addObject:sectionViewModel];
    [self addSubViewModel:sectionViewModel];
}

/// 将 viewModel 插入到 index 位置，并添加为子元素。
- (void)_insertSectionViewModel:(XZMocoaListitySectionViewModel *)sectionViewModel atIndex:(NSInteger)index {
    NSParameterAssert([sectionViewModel isKindOfClass:[XZMocoaListitySectionViewModel class]]);
    [_sectionViewModels insertObject:sectionViewModel atIndex:index];
    [self addSubViewModel:sectionViewModel];
}

/// 将 oldIndex 位置上的 viewModel 移动到 newIndex 位置上，在子元素集合中的位置不变。
- (void)_moveSectionViewModelFromIndex:(NSInteger)oldIndex toIndex:(NSInteger)newIndex {
    if (newIndex == oldIndex) return;
    id const viewModel = _sectionViewModels[oldIndex];
    [_sectionViewModels removeObjectAtIndex:oldIndex];
    [_sectionViewModels insertObject:viewModel atIndex:newIndex];
}

/// 添加所有 section 元素，需先清理数据。
- (void)_loadDataWithoutEvents {
    id<XZMocoaListityModel> const model = self.model;
    NSInteger const count = model.numberOfSectionModels;
    
    for (NSInteger section = 0; section < count; section++) {
        XZMocoaListitySectionViewModel *viewModel = [self loadViewModelForSectionAtIndex:section];
        [self _addSectionViewModel:viewModel];
    }
}

/// 移动 section 。
/// @discussion 对于 UITableView 而言，变化就是从旧位置移动到新位置，但是对于 ViewModel 而言，
///             每次 move 都会改变数据源中数据的排序，所以数据的移动与视图的移动可能不一致。
/// @param section 当前位置
/// @param oldSection 原始位置
/// @param newSection 目标位置
- (void)_moveSectionAtIndex:(NSInteger)section fromIndex:(NSInteger)oldSection toIndex:(NSInteger)newSection {
    _needsDifferenceBatchUpdates = NO;
    
    // 更新数据
    [self _moveSectionViewModelFromIndex:section toIndex:newSection];
    
    // 新旧位置无变化，不需要发送事件。
    if (oldSection == newSection) {
        return;
    }
    
    [self didMoveSectionAtIndex:oldSection toIndex:newSection];
}

#pragma mark - 子类重写

- (XZMocoaListitySectionViewModel *)loadViewModelForSectionAtIndex:(NSInteger)index {
    id<XZMocoaListitySectionModel> const model = [self.model modelForSectionAtIndex:index];
    XZMocoaName     const name    = model.mocoaName;
    XZMocoaModule * const module  = [self.module submoduleIfLoadedForKind:XZMocoaKindSection forName:name];
    Class           const VMClass = module.viewModelClass ?: [XZMocoaListitySectionViewModel class];
    
    XZMocoaListitySectionViewModel * const viewModel = [[VMClass alloc] initWithModel:model];
    viewModel.module = module;
    viewModel.index  = index;
    return viewModel;
}

#pragma mark - DEBUG

#if DEBUG
- (NSArray *)sectionDataModels {
    NSInteger const count = self.numberOfSections;
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i = 0; i < count; i++) {
        id const dataModel = [self sectionViewModelAtIndex:i].model;
        [result addObject:(dataModel ?: NSNull.null)];
    }
    return result;
}
#endif

- (void)sectionViewModel:(XZMocoaListitySectionViewModel *)viewModel didReloadData:(void * _Nullable)null {
    NSInteger const index = [self indexOfSectionViewModel:viewModel];
    if (index == NSNotFound) return;
    if (!self.isReady) return;
    
    if (!self.isPerformingBatchUpdates || (self.isPerformingBatchUpdates && viewModel.isPerformingBatchUpdates)) {
        NSIndexSet *indexes = [NSIndexSet indexSetWithIndex:index];
        [self didReloadSectionsAtIndexes:indexes];
    } else {
        [_delayedBatchUpdates addObject:^void(XZMocoaListityViewModel *self) {
            [self sectionViewModel:viewModel didReloadData:null];
        }];
    }
}

- (void)sectionViewModel:(XZMocoaListitySectionViewModel *)viewModel didReloadCellsAtIndexes:(NSIndexSet *)rows {
    NSInteger const index = [self indexOfSectionViewModel:viewModel];
    if (index == NSNotFound) return;
    if (!self.isReady) return;
    
    if (!self.isPerformingBatchUpdates || (self.isPerformingBatchUpdates && viewModel.isPerformingBatchUpdates)) {
        NSArray * const indexPaths = [rows xz_map:^id(NSInteger idx, BOOL *stop) {
            return [NSIndexPath indexPathForRow:idx inSection:index];
        }];
        [self didReloadCellsAtIndexPaths:indexPaths];
    } else {
        [_delayedBatchUpdates addObject:^void(XZMocoaListityViewModel *self) {
            [self sectionViewModel:viewModel didReloadCellsAtIndexes:rows];
        }];
    }
}

- (void)sectionViewModel:(XZMocoaListitySectionViewModel *)viewModel didInsertCellsAtIndexes:(NSIndexSet *)rows {
    NSInteger const index = [self indexOfSectionViewModel:viewModel];
    if (index == NSNotFound) return;
    if (!self.isReady) return;
    
    if (!self.isPerformingBatchUpdates || (self.isPerformingBatchUpdates && viewModel.isPerformingBatchUpdates)) {
        NSArray * const indexPaths = [rows xz_map:^id(NSInteger idx, BOOL *stop) {
            return [NSIndexPath indexPathForRow:idx inSection:index];
        }];
        [self didInsertCellsAtIndexPaths:indexPaths];
    } else {
        [_delayedBatchUpdates addObject:^void(XZMocoaListityViewModel *self) {
            [self sectionViewModel:viewModel didInsertCellsAtIndexes:rows];
        }];
    }
}

- (void)sectionViewModel:(XZMocoaListitySectionViewModel *)viewModel didDeleteCellsAtIndexes:(NSIndexSet *)rows {
    NSInteger const index = [self indexOfSectionViewModel:viewModel];
    if (index == NSNotFound) return;
    if (!self.isReady) return;
    
    if (!self.isPerformingBatchUpdates || (self.isPerformingBatchUpdates && viewModel.isPerformingBatchUpdates)) {
        NSArray * const indexPaths = [rows xz_map:^id(NSInteger idx, BOOL *stop) {
            return [NSIndexPath indexPathForRow:idx inSection:index];
        }];
        [self didDeleteCellsAtIndexPaths:indexPaths];
    } else {
        [_delayedBatchUpdates addObject:^void(XZMocoaListityViewModel *self) {
            [self sectionViewModel:viewModel didDeleteCellsAtIndexes:rows];
        }];
    }
}

- (void)sectionViewModel:(XZMocoaListitySectionViewModel *)viewModel didMoveCellAtIndex:(NSInteger)row toIndex:(NSInteger)newRow {
    NSInteger const index = [self indexOfSectionViewModel:viewModel];
    if (index == NSNotFound) return;
    if (!self.isReady) return;
    
    if (!self.isPerformingBatchUpdates || (self.isPerformingBatchUpdates && viewModel.isPerformingBatchUpdates)) {
        NSIndexPath *from = [NSIndexPath indexPathForRow:row inSection:index];
        NSIndexPath *to   = [NSIndexPath indexPathForRow:newRow inSection:index];
        [self didMoveCellAtIndexPath:from toIndexPath:to];
    } else {
        [_delayedBatchUpdates addObject:^void(XZMocoaListityViewModel *self) {
            [self sectionViewModel:viewModel didMoveCellAtIndex:row toIndex:newRow];
        }];
    }
}

- (void)sectionViewModel:(XZMocoaListitySectionViewModel *)viewModel didPerformBatchUpdates:(void (^NS_NOESCAPE)(void))batchUpdates completion:(void (^ _Nullable)(BOOL))completion {
    NSInteger const index = [self indexOfSectionViewModel:viewModel];
    if (index == NSNotFound) return;
    
    // 应用 batchUpdates 中的数据操作，视图操作会被拦截
    if (!self.isReady || self.isPerformingBatchUpdates) {
        batchUpdates();
        if (completion) dispatch_async(dispatch_get_main_queue(), ^{ completion(NO); });
    } else {
        [self didPerformBatchUpdates:batchUpdates completion:completion];
    }
}

@end
