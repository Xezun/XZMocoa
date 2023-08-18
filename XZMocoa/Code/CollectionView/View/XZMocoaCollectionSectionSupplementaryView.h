//
//  XZMocoaCollectionSectionSupplementaryView.h
//  XZMocoa
//
//  Created by Xezun on 2023/8/9.
//

#import <UIKit/UIKit.h>
#import <XZMocoa/XZMocoaView.h>
#import <XZMocoa/XZMocoaCollectionSectionSupplementaryViewModel.h>

@class XZMocoaCollectionView;

NS_ASSUME_NONNULL_BEGIN

@protocol XZMocoaCollectionSectionSupplementaryView <XZMocoaView>
@optional
@property (nonatomic, strong, nullable) __kindof XZMocoaCollectionSectionSupplementaryViewModel *viewModel;
- (void)collectionView:(XZMocoaCollectionView *)collectionView willDisplaySupplementaryViewAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(XZMocoaCollectionView *)collectionView didEndDisplayingSupplementaryViewAtIndexPath:(NSIndexPath*)indexPath;
@end

@interface XZMocoaCollectionSectionSupplementaryView : UICollectionReusableView <XZMocoaCollectionSectionSupplementaryView>

@end

NS_ASSUME_NONNULL_END
