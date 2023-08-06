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

- (void)didPerformBatchUpdates:(void (^NS_NOESCAPE)(void))batchUpdates {
    if (!self.isReady) return;
    [self.delegate tableViewModel:self performBatchUpdates:batchUpdates];
}

- (XZMocoaListitySectionViewModel *)loadSectionViewModelWithModule:(XZMocoaModule *)sectionModule model:(id)model {
    Class ViewModel = sectionModule.viewModelClass;
    if (ViewModel == Nil) {
        ViewModel = [XZMocoaTableSectionViewModel class];
    }
    return [[ViewModel alloc] initWithModel:model];
}

@end
