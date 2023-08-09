//
//  XZMocoaCollectionView.m
//  XZMocoa
//
//  Created by Xezun on 2023/7/24.
//

#import "XZMocoaCollectionView.h"

@implementation XZMocoaCollectionView

@dynamic viewModel, contentView;

//- (instancetype)initWithFrame:(CGRect)frame {
//    [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:nil];
//}

- (instancetype)initWithCoder:(NSCoder *)coder {
    return [super initWithCoder:coder];
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

- (instancetype)initWithCollectionViewClass:(Class)collectionViewClass layout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:UIScreen.mainScreen.bounds];
    if (self) {
        UICollectionView *contentView = [[collectionViewClass alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        [super setContentView:contentView];
    }
    return self;
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
//    contentView.contentInset   = UIEdgeInsetsZero;
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
    UICollectionView * const tableView = self.contentView;
    if (@available(iOS 11.0, *)) {
        if (tableView && !tableView.hasUncommittedUpdates) {
            [tableView reloadData];
        }
    } else {
        [tableView reloadData];
    }
}

- (void)registerModule:(XZMocoaModule *)module {
    UICollectionView * const collectionView = self.contentView;
    if (!module || !collectionView) {
        return;
    }
    { // 注册一个默认的 Cell
        NSString * const identifier = XZMocoaReuseIdentifier(XZMocoaNameNone, XZMocoaNameNone);
        [collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:identifier];
    }
    
    [module enumerateSubmodulesUsingBlock:^(XZMocoaModule *submodule, XZMocoaKind kind, XZMocoaName section, BOOL *stop) {
        if (![kind isEqualToString:XZMocoaKindSection]) {
            return; // 不是 section 的 module 不需要处理
        }

        [submodule enumerateSubmodulesUsingBlock:^(XZMocoaModule *submodule, XZMocoaKind kind, XZMocoaName name, BOOL *stop) {
            if ([kind isEqualToString:XZMocoaKindCell]) {
                NSString * const identifier = XZMocoaReuseIdentifier(section, name);
                if (submodule.viewNibName != nil) {
                    UINib *viewNib = [UINib nibWithNibName:submodule.viewNibName bundle:submodule.viewNibBundle];
                    [collectionView registerNib:viewNib forCellWithReuseIdentifier:identifier];
                } else if (submodule.viewClass != Nil) {
                    [collectionView registerClass:submodule.viewClass forCellWithReuseIdentifier:identifier];
                }
            } else if ([kind isEqualToString:XZMocoaKindHeader]) {
                NSString * const identifier = XZMocoaReuseIdentifier(section, name);
                if (submodule.viewNibName != nil) {
                    UINib *viewNib = [UINib nibWithNibName:submodule.viewNibName bundle:submodule.viewNibBundle];
                    [collectionView registerNib:viewNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
                } else if (submodule.viewClass != Nil) {
                    [collectionView registerClass:submodule.viewClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
                }
            } else if ([kind isEqualToString:XZMocoaKindFooter]) {
                NSString * const identifier = XZMocoaReuseIdentifier(section, name);
                if (submodule.viewNibName != Nil) {
                    UINib *viewNib = [UINib nibWithNibName:submodule.viewNibName bundle:submodule.viewNibBundle];
                    [collectionView registerNib:viewNib forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
                } else if (submodule.viewClass != Nil) {
                    [collectionView registerClass:submodule.viewClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
                }
            }
        }];
    }];
}

- (void)unregisterModule:(XZMocoaModule *)module {
    
}

@end


@implementation XZMocoaCollectionView (UICollectionViewDelegate)



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
    UICollectionViewCell<XZMocoaView> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:viewModel.identifier forIndexPath:indexPath];
    cell.viewModel = viewModel;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    XZMocoaCollectionSectionViewModel *section = [self.viewModel sectionViewModelAtIndex:indexPath.section];
    
    XZMocoaKind mocoaKind = kind;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        mocoaKind = XZMocoaKindHeader;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        mocoaKind = XZMocoaKindFooter;
    }
    
    XZMocoaListitySectionSupplementaryViewModel *vm = [section viewModelForSupplementaryKind:mocoaKind atIndex:indexPath.item];
    if (vm == nil) {
        return nil;
    }
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:vm.identifier forIndexPath:indexPath];
    return view;
}

// TODO: Not IMP

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    
}

- (nullable NSArray<NSString *> *)indexTitlesForCollectionView:(UICollectionView *)collectionView {
    return nil;
}

/// Returns the index path that corresponds to the given title / index. (e.g. "B",1)
/// Return an index path with a single index to indicate an entire section, instead of a specific item.
- (NSIndexPath *)collectionView:(UICollectionView *)collectionView indexPathForIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return nil;
}

@end
