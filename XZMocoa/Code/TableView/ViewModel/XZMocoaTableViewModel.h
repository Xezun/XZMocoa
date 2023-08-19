//
//  XZMocoaTableViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import <XZMocoa/XZMocoaListityViewModel.h>
#import <XZMocoa/XZMocoaTableViewSectionViewModel.h>
#import <XZMocoa/XZMocoaTableViewHeaderFooterViewModel.h>
#import <XZMocoa/XZMocoaTableViewCellViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@class XZMocoaTableViewModel;
@protocol XZMocoaTableViewModelDelegate <XZMocoaListityViewModelDelegate>

@required
- (void)tableViewModel:(XZMocoaTableViewModel *)tableViewModel didReloadData:(void * _Nullable)null;

- (void)tableViewModel:(XZMocoaTableViewModel *)tableViewModel didReloadCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
- (void)tableViewModel:(XZMocoaTableViewModel *)tableViewModel didInsertCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
- (void)tableViewModel:(XZMocoaTableViewModel *)tableViewModel didDeleteCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
- (void)tableViewModel:(XZMocoaTableViewModel *)tableViewModel didMoveCellAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath;

- (void)tableViewModel:(XZMocoaTableViewModel *)tableViewModel didReloadSectionsAtIndexes:(NSIndexSet *)sections;
- (void)tableViewModel:(XZMocoaTableViewModel *)tableViewModel didInsertSectionsAtIndexes:(NSIndexSet *)sections;
- (void)tableViewModel:(XZMocoaTableViewModel *)tableViewModel didDeleteSectionsAtIndexes:(NSIndexSet *)sections;
- (void)tableViewModel:(XZMocoaTableViewModel *)tableViewModel didMoveSectionAtIndex:(NSInteger)section toIndex:(NSInteger)newSection;

- (void)tableViewModel:(XZMocoaTableViewModel *)tableViewModel didPerformBatchUpdates:(void (^NS_NOESCAPE)(void))batchUpdates completion:(void (^ _Nullable)(BOOL finished))completion;

@end

@interface XZMocoaTableViewModel : XZMocoaListityViewModel<XZMocoaTableViewCellViewModel *, XZMocoaTableViewSectionViewModel *>

/// 在进行批量更新或局部更新时，视图更新的动画效果，默认为 UITableViewRowAnimationAutomatic 自动选择合适的动画效果。
@property (nonatomic) UITableViewRowAnimation rowAnimation;

@property (nonatomic, weak) id<XZMocoaTableViewModelDelegate> delegate;
/// 总高度。
@property (nonatomic, readonly) CGFloat height;

@end

NS_ASSUME_NONNULL_END
