//
//  XZMocoaAssembleView.h
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import <XZMocoa/XZMocoaView.h>
#import <XZMocoa/XZMocoaDefines.h>
#import <XZMocoa/XZMocoaAssembleViewModel.h>

NS_ASSUME_NONNULL_BEGIN

/// 抽象类，封装 UITableView、UICollectionView 的基类视图。
@interface XZMocoaAssembleView : UIView <XZMocoaView, XZMocoaAssembleViewModelDelegate>

/// 承载内容的视图，为 UICollectionView 或 UITableView 视图，由子类提供。
/// @note 在 IB 中使用时，直接将视图关联到此属性即可。
@property (nonatomic, strong) __kindof UIScrollView *contentView;

/// super does nothing
- (void)contentViewWillChange;
/// super does nothing
- (void)contentViewDidChange;

@property (nonatomic, strong, nullable) __kindof XZMocoaAssembleViewModel *viewModel;
- (void)viewModelWillChange;
- (void)viewModelDidChange;

- (void)unregisterModule:(nullable XZMocoaModule *)module;
- (void)registerModule:(nullable XZMocoaModule *)module;

@end

NS_ASSUME_NONNULL_END
