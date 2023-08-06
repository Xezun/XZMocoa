//
//  XZMocoaCollectionCellViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import <XZMocoa/XZMocoaListityCellViewModel.h>

NS_ASSUME_NONNULL_BEGIN

/// UICollectionViewCell 视图模型基类。
@interface XZMocoaCollectionCellViewModel : XZMocoaListityCellViewModel

@property (nonatomic) CGSize size;
- (void)sizeDidChange;

/// 当前 ViewModel 对应的 Cell 将要被选中时，会触发此方法。
/// @param indexPath Cell 所在的位置
- (void)collectonView:(UICollectionView *)collectonView didSelectRow:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
/// 当前 ViewModel 对应的 Cell 将要被展示时，会触发此方法。
/// @param indexPath Cell 所在的位置
- (void)collectonView:(UICollectionView *)collectonView willDisplayRow:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
/// 当前 ViewModel 对应的 Cell 将要被移除屏幕时，会触发此方法。
/// @param indexPath Cell 所在的位置
- (void)collectonView:(UICollectionView *)collectonView didEndDisplayingRow:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath*)indexPath;
@end

NS_ASSUME_NONNULL_END
