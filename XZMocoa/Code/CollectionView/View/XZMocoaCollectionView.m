//
//  XZMocoaCollectionView.m
//  XZMocoa
//
//  Created by Xezun on 2023/7/24.
//

#import "XZMocoaCollectionView.h"
#import "XZMocoaCollectionCell.h"
#import "XZMocoaCollectionSectionSupplementaryView.h"
#import "XZMocoaCollectionPlaceholderCell.h"
#import "XZMocoaCollectionSectionPlaceholderSupplementaryView.h"

static XZMocoaKind XZMocoaKindFromElementKind(NSString *kind) {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) return XZMocoaKindHeader;
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) return XZMocoaKindFooter;
    return kind;
}

static NSString *UIElementKindFromMocoaKind(XZMocoaKind kind) {
    if ([kind isEqualToString:XZMocoaKindHeader]) return UICollectionElementKindSectionHeader;
    if ([kind isEqualToString:XZMocoaKindFooter]) return UICollectionElementKindSectionFooter;
    return kind;
}

@implementation XZMocoaCollectionView

@dynamic viewModel, contentView;

- (instancetype)initWithCoder:(NSCoder *)coder {
    return [super initWithCoder:coder];
}

- (instancetype)initWithCollectionViewClass:(Class)collectionViewClass layout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:UIScreen.mainScreen.bounds];
    if (self) {
        UICollectionView *contentView = [[collectionViewClass alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        [super setContentView:contentView];
    }
    return self;
}

- (instancetype)initWithLayout:(UICollectionViewLayout *)layout {
    return [self initWithFrame:UIScreen.mainScreen.bounds layout:layout];
}

- (instancetype)initWithFrame:(CGRect)frame layout:(UICollectionViewLayout *)layout {
    self = [self initWithCollectionViewClass:UICollectionView.class layout:layout];
    if (self) {
        self.frame = frame;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    return [self initWithCollectionViewClass:UICollectionView.class layout:layout];
}

- (void)contentViewWillChange {
    [super contentViewWillChange];
    
    UICollectionView *contentView = self.contentView;
    contentView.delegate = nil;
    contentView.dataSource = nil;
}

- (void)contentViewDidChange {
    [super contentViewDidChange];
    
    UICollectionView *contentView = self.contentView;
//    contentView.separatorStyle = UICollectionViewCellSeparatorStyleNone;
    contentView.contentInset   = UIEdgeInsetsZero;
//    
//    contentView.estimatedRowHeight = 0;
//    contentView.estimatedSectionFooterHeight = 0;
//    contentView.estimatedSectionHeaderHeight = 0;
    
    if (@available(iOS 11.0, *)) {
        contentView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    contentView.delegate   = self;
    contentView.dataSource = self;
}

- (void)viewModelDidChange {
    [super viewModelDidChange];
    
    // 刷新视图。
    UICollectionView * const collectionView = self.contentView;
    if (@available(iOS 11.0, *)) {
        if (collectionView && !collectionView.hasUncommittedUpdates) {
            [collectionView reloadData];
        }
    } else {
        [collectionView reloadData];
    }
}

- (void)registerModule:(XZMocoaModule *)module {
    UICollectionView * const collectionView = self.contentView;
    if (!module || !collectionView) {
        return;
    }
    { // 注册一个默认的 Cell
        NSString * const identifier = XZMocoaReuseIdentifier(XZMocoaNameNone, XZMocoaKindCell, XZMocoaNameNone);
        [collectionView registerClass:[XZMocoaCollectionPlaceholderCell class] forCellWithReuseIdentifier:identifier];
    }
    
    [module enumerateSubmodulesUsingBlock:^(XZMocoaModule *submodule, XZMocoaKind kind, XZMocoaName section, BOOL *stop) {
        if (![kind isEqualToString:XZMocoaKindSection]) {
            return; // 不是 section 的 module 不需要处理
        }

        [submodule enumerateSubmodulesUsingBlock:^(XZMocoaModule *submodule, XZMocoaKind mocoakind, XZMocoaName name, BOOL *stop) {
            if ([mocoakind isEqualToString:XZMocoaKindCell]) {
                NSString * const identifier = XZMocoaReuseIdentifier(section, mocoakind, name);
                if (submodule.viewNibName != nil) {
                    UINib *viewNib = [UINib nibWithNibName:submodule.viewNibName bundle:submodule.viewNibBundle];
                    [collectionView registerNib:viewNib forCellWithReuseIdentifier:identifier];
                } else if (submodule.viewClass != Nil) {
                    [collectionView registerClass:submodule.viewClass forCellWithReuseIdentifier:identifier];
                } else {
                    Class const aClass = [XZMocoaCollectionPlaceholderCell class];
                    [collectionView registerClass:aClass forCellWithReuseIdentifier:identifier];
                }
            } else {
                NSString * const identifier = XZMocoaReuseIdentifier(section, mocoakind, name);
                NSString * const kind       = UIElementKindFromMocoaKind(mocoakind);
                if (submodule.viewNibName != Nil) {
                    UINib *viewNib = [UINib nibWithNibName:submodule.viewNibName bundle:submodule.viewNibBundle];
                    [collectionView registerNib:viewNib forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
                } else if (submodule.viewClass != Nil) {
                    [collectionView registerClass:submodule.viewClass forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
                } else {
                    Class const aClass = [XZMocoaCollectionSectionPlaceholderSupplementaryView class];
                    [collectionView registerClass:aClass forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
                }
            }
        }];
    }];
}

- (void)unregisterModule:(XZMocoaModule *)module {
    
}

@end

@implementation XZMocoaCollectionView (UIScrollViewDelegate)
@end

@implementation XZMocoaCollectionView (UICollectionViewDelegate)

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell<XZMocoaCollectionCell> *cell = (id)[collectionView cellForItemAtIndexPath:indexPath];
    [cell collectionView:self didSelectItemAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell<XZMocoaCollectionCell> *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [cell collectionView:self willDisplayItemAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell<XZMocoaCollectionCell> *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [cell collectionView:self didEndDisplayingItemAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView<XZMocoaCollectionSectionSupplementaryView> *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    [view collectionView:self willDisplaySupplementaryViewAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView<XZMocoaCollectionSectionSupplementaryView> *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    [view collectionView:self didEndDisplayingSupplementaryViewAtIndexPath:indexPath];
}

@end


@implementation XZMocoaCollectionView (UICollectionViewDataSource)

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.viewModel numberOfSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel numberOfCellsInSection:section];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XZMocoaCollectionCellViewModel *viewModel = [self.viewModel cellViewModelAtIndexPath:indexPath];
    UICollectionViewCell<XZMocoaCollectionCell> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:viewModel.identifier forIndexPath:indexPath];
    cell.viewModel = viewModel;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    XZMocoaKind const mocoaKind = XZMocoaKindFromElementKind(kind);
    
    XZMocoaListityViewSupplementaryViewModel *viewModel = [[self.viewModel sectionViewModelAtIndex:indexPath.section] viewModelForSupplementaryKind:mocoaKind atIndex:indexPath.item];
    if (viewModel == nil) {
        return nil;
    }
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:viewModel.identifier forIndexPath:indexPath];
    return view;
}

@end

@implementation XZMocoaCollectionView (UICollectionViewDelegateFlowLayout)

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    XZMocoaCollectionCellViewModel *viewModel = [self.viewModel cellViewModelAtIndexPath:indexPath];
    return viewModel.size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    XZMocoaCollectionSectionViewModel *viewModel = [self.viewModel sectionViewModelAtIndex:section];
    return viewModel.insets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    XZMocoaCollectionSectionViewModel *viewModel = [self.viewModel sectionViewModelAtIndex:section];
    return viewModel.minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    XZMocoaCollectionSectionViewModel *viewModel = [self.viewModel sectionViewModelAtIndex:section];
    return viewModel.minimumInteritemSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    XZMocoaCollectionSectionSupplementaryViewModel *viewModel = [[self.viewModel sectionViewModelAtIndex:section] viewModelForSupplementaryKind:XZMocoaKindHeader atIndex:0];
    return viewModel.size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    XZMocoaCollectionSectionSupplementaryViewModel *viewModel = [[self.viewModel sectionViewModelAtIndex:section] viewModelForSupplementaryKind:XZMocoaKindFooter atIndex:0];
    return viewModel.size;
}

@end


@implementation XZMocoaCollectionView (XZMocoaCollectionViewModelDelegate)

- (void)collectionViewModel:(XZMocoaCollectionViewModel *)collectionViewModel didReloadData:(void *)null {
    [self.contentView reloadData];
}

- (void)collectionViewModel:(XZMocoaCollectionViewModel *)collectionViewModel didReloadCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self.contentView reloadItemsAtIndexPaths:indexPaths];
}

- (void)collectionViewModel:(XZMocoaCollectionViewModel *)collectionViewModel didInsertCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self.contentView insertItemsAtIndexPaths:indexPaths];
}

- (void)collectionViewModel:(XZMocoaCollectionViewModel *)collectionViewModel didDeleteCellsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self.contentView deleteItemsAtIndexPaths:indexPaths];
}

- (void)collectionViewModel:(XZMocoaCollectionViewModel *)collectionViewModel didMoveCellAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath {
    [self.contentView moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
}

- (void)collectionViewModel:(XZMocoaCollectionViewModel *)collectionViewModel didReloadSectionsAtIndexes:(NSIndexSet *)sections {
    [self.contentView reloadSections:sections];
}

- (void)collectionViewModel:(XZMocoaCollectionViewModel *)collectionViewModel didInsertSectionsAtIndexes:(NSIndexSet *)sections {
    [self.contentView insertSections:sections];
}

- (void)collectionViewModel:(XZMocoaCollectionViewModel *)collectionViewModel didDeleteSectionsAtIndexes:(NSIndexSet *)sections {
    [self.contentView deleteSections:sections];
}

- (void)collectionViewModel:(XZMocoaCollectionViewModel *)collectionViewModel didMoveSectionAtIndex:(NSInteger)section toIndex:(NSInteger)newSection {
    [self.contentView moveSection:section toSection:newSection];
}

- (void)collectionViewModel:(XZMocoaCollectionViewModel *)collectionViewModel didPerformBatchUpdates:(void (^NS_NOESCAPE)(void))batchUpdates completion:(void (^ _Nullable)(BOOL))completion {
    [self.contentView performBatchUpdates:batchUpdates completion:completion];
}

@end
