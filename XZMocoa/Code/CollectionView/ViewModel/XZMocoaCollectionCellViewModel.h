//
//  XZMocoaCollectionCellViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import <XZMocoa/XZMocoaListityCellViewModel.h>

@class XZMocoaCollectionView;

NS_ASSUME_NONNULL_BEGIN

/// UICollectionViewCell 视图模型基类。
@interface XZMocoaCollectionCellViewModel : XZMocoaListityCellViewModel

@property (nonatomic) CGSize size;

- (void)wasSelectedInCollectionView:(XZMocoaCollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
- (void)willBeDisplayedInCollectionView:(XZMocoaCollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
- (void)didEndBeingDisplayedInCollectionView:(XZMocoaCollectionView *)collectionView atIndexPath:(NSIndexPath*)indexPath;
@end

NS_ASSUME_NONNULL_END
