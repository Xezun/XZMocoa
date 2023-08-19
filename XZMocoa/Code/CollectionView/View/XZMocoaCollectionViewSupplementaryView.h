//
//  XZMocoaCollectionViewSupplementaryView.h
//  XZMocoa
//
//  Created by Xezun on 2023/8/9.
//

#import <UIKit/UIKit.h>
#import <XZMocoa/XZMocoaView.h>
#import <XZMocoa/XZMocoaCollectionViewSupplementaryViewModel.h>

@class XZMocoaCollectionView;

NS_ASSUME_NONNULL_BEGIN

@protocol XZMocoaCollectionViewSupplementaryView <XZMocoaView>
@optional
@property (nonatomic, strong, nullable) __kindof XZMocoaCollectionViewSupplementaryViewModel *viewModel;
- (void)collectionView:(XZMocoaCollectionView *)collectionView willDisplaySupplementaryViewAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(XZMocoaCollectionView *)collectionView didEndDisplayingSupplementaryViewAtIndexPath:(NSIndexPath*)indexPath;
@end

@interface XZMocoaCollectionViewSupplementaryView : UICollectionReusableView <XZMocoaCollectionViewSupplementaryView>

@end

NS_ASSUME_NONNULL_END
