//
//  XZMocoaCollectionViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import <XZMocoa/XZMocoaListityViewModel.h>
#import <XZMocoa/XZMocoaCollectionCellViewModel.h>
#import <XZMocoa/XZMocoaCollectionSectionViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@class XZMocoaCollectionViewModel;
@protocol XZMocoaCollectionViewModelDelegate <XZMocoaListityViewModelDelegate>

@required
- (void)collectionViewModel:(XZMocoaCollectionViewModel *)collectionViewModel didReloadData:(void * _Nullable)null;

- (void)collectionViewModel:(XZMocoaCollectionViewModel *)collectionViewModel didReloadCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
- (void)collectionViewModel:(XZMocoaCollectionViewModel *)collectionViewModel didInsertCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
- (void)collectionViewModel:(XZMocoaCollectionViewModel *)collectionViewModel didDeleteCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
- (void)collectionViewModel:(XZMocoaCollectionViewModel *)collectionViewModel didMoveCellAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath;

- (void)collectionViewModel:(XZMocoaCollectionViewModel *)collectionViewModel didReloadSectionsAtIndexes:(NSIndexSet *)sections;
- (void)collectionViewModel:(XZMocoaCollectionViewModel *)collectionViewModel didInsertSectionsAtIndexes:(NSIndexSet *)sections;
- (void)collectionViewModel:(XZMocoaCollectionViewModel *)collectionViewModel didDeleteSectionsAtIndexes:(NSIndexSet *)sections;
- (void)collectionViewModel:(XZMocoaCollectionViewModel *)collectionViewModel didMoveSectionAtIndex:(NSInteger)section toIndex:(NSInteger)newSection;

- (void)collectionViewModel:(XZMocoaCollectionViewModel *)collectionViewModel didPerformBatchUpdates:(void (^NS_NOESCAPE)(void))batchUpdates completion:(void (^ _Nullable)(BOOL finished))completion;

@end

@interface XZMocoaCollectionViewModel : XZMocoaListityViewModel <XZMocoaCollectionCellViewModel *, XZMocoaCollectionSectionViewModel *>
@property (nonatomic, weak) id<XZMocoaCollectionViewModelDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
