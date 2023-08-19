//
//  XZMocoaCollectionCellViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import <XZMocoa/XZMocoaListityViewCellViewModel.h>

@class XZMocoaCollectionView;

NS_ASSUME_NONNULL_BEGIN

/// UICollectionViewCell 视图模型基类。
@interface XZMocoaCollectionCellViewModel : XZMocoaListityViewCellViewModel

@property (nonatomic) CGSize size;

- (void)collectionView:(XZMocoaCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(XZMocoaCollectionView *)collectionView willDisplayItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(XZMocoaCollectionView *)collectionView didEndDisplayingItemAtIndexPath:(NSIndexPath*)indexPath;
@end

NS_ASSUME_NONNULL_END
