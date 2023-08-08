//
//  XZMocoaCollectionView.h
//  XZMocoa
//
//  Created by Xezun on 2023/7/24.
//

#import <XZMocoa/XZMocoaListityView.h>
#import <XZMocoa/XZMocoaCollectionViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZMocoaCollectionView : XZMocoaListityView

@property (nonatomic, strong, nullable) __kindof XZMocoaCollectionViewModel *viewModel;
@property (nonatomic, strong) IBOutlet UICollectionView *contentView;

@end

@interface XZMocoaCollectionView (UICollectionViewDelegate) <UICollectionViewDelegate>

@end

@interface XZMocoaCollectionView (UICollectionViewDataSource) <UICollectionViewDataSource>

@end

NS_ASSUME_NONNULL_END
