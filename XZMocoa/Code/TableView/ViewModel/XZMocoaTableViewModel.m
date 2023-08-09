//
//  XZMocoaTableViewModel.m
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import "XZMocoaTableViewModel.h"

@implementation XZMocoaTableViewModel

@dynamic delegate;

- (CGFloat)height {
    CGFloat height = 0;
    for (XZMocoaTableSectionViewModel *section in self.sectionViewModels) {
        height += section.height;
    }
    return height;
}

- (void)didReloadData {
    if (!self.isReady) return;
    [self.delegate tableViewModelDidReloadData:self];
}

- (void)didReloadCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if (!self.isReady) return;
    [self.delegate tableViewModel:self didReloadCellsAtIndexPaths:indexPaths];
}

- (void)didInsertCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if (!self.isReady) return;
    [self.delegate tableViewModel:self didInsertCellsAtIndexPaths:indexPaths];
}

- (void)didDeleteCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if (!self.isReady) return;
    [self.delegate tableViewModel:self didDeleteCellsAtIndexPaths:indexPaths];
}

- (void)didMoveCellAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath {
    if (!self.isReady) return;
    [self.delegate tableViewModel:self didMoveCellAtIndexPath:indexPath toIndexPath:newIndexPath];
}

- (void)didReloadSectionsAtIndexes:(NSIndexSet *)sections {
    if (!self.isReady) return;
    [self.delegate tableViewModel:self didReloadSectionsAtIndexes:sections];
}

- (void)didInsertSectionsAtIndexes:(NSIndexSet *)sections {
    if (!self.isReady) return;
    [self.delegate tableViewModel:self didInsertSectionsAtIndexes:sections];
}

- (void)didDeleteSectionsAtIndexes:(NSIndexSet *)sections {
    if (!self.isReady) return;
    [self.delegate tableViewModel:self didDeleteSectionsAtIndexes:sections];
}

- (void)didMoveSectionAtIndex:(NSInteger)oldSection toIndex:(NSInteger)newSection {
    if (!self.isReady) return;
    [self.delegate tableViewModel:self didMoveSectionAtIndex:oldSection toIndex:newSection];
}

- (void)didPerformBatchUpdates:(void (^NS_NOESCAPE)(void))batchUpdates completion:(void (^ _Nullable)(BOOL))completion {
    if (!self.isReady) return;
    [self.delegate tableViewModel:self performBatchUpdates:batchUpdates completion:completion];
}

- (XZMocoaListitySectionViewModel *)loadViewModelForSectionAtIndex:(NSInteger)index {
    id<XZMocoaListitySectionModel> const model = [self.model modelForSectionAtIndex:index];
    XZMocoaName     const name    = model.mocoaName;
    XZMocoaModule * const module  = [self.module submoduleIfLoadedForKind:XZMocoaKindSection forName:name];
    Class           const VMClass = module.viewModelClass ?: [XZMocoaTableSectionViewModel class];
    
    XZMocoaListitySectionViewModel * const viewModel = [[VMClass alloc] initWithModel:model];
    viewModel.module = module;
    viewModel.index  = index;
    return viewModel;
}

@end
