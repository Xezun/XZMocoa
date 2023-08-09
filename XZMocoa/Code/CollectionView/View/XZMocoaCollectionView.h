//
//  XZMocoaCollectionView.h
//  XZMocoa
//
//  Created by Xezun on 2023/7/24.
//

#import <XZMocoa/XZMocoaListityView.h>
#import <XZMocoa/XZMocoaCollectionViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZMocoaCollectionViewDelegate;

@interface XZMocoaCollectionView : XZMocoaListityView
@property (nonatomic, strong, nullable) __kindof XZMocoaCollectionViewModel *viewModel;
@property (nonatomic, strong) IBOutlet UICollectionView *contentView;
@property (nonatomic, weak) id<XZMocoaCollectionViewDelegate> delegate;
@end


@interface XZMocoaCollectionView (UIScrollViewDelegate) <UIScrollViewDelegate>
@end
@interface XZMocoaCollectionView (UICollectionViewDelegate) <UICollectionViewDelegate>
@end
@interface XZMocoaCollectionView (UICollectionViewDataSource) <UICollectionViewDataSource>
@end
@interface XZMocoaCollectionView (UICollectionViewDelegateFlowLayout) <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
@end

@interface XZMocoaCollectionView (XZMocoaCollectionViewModelDelegate) <XZMocoaCollectionViewModelDelegate>
@end

@protocol XZMocoaCollectionView <UICollectionViewDelegate, UICollectionViewDataSource>
@end

NS_ASSUME_NONNULL_END
