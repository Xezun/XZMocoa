//
//  XZMocoaListitySectionModel.h
//  XZMocoa
//
//  Created by Xezun on 2021/8/21.
//

#import <XZMocoa/XZMocoaModel.h>

NS_ASSUME_NONNULL_BEGIN

/// 以 Cell 作为子视图的视图的数据模型。在iOS开发中，视图UITableView、UICollectionView的Section为抽象层，而没有实际的视图层，但在数据或逻辑上，该层不可少。
@protocol XZMocoaListitySectionModel <XZMocoaModel>

@optional
/// header 数据，nil 表示无 header 视图。
@property (nonatomic, readonly, nullable) id headerModel;

/// footer 数据，nil 表示无 footer 视图。
@property (nonatomic, readonly, nullable) id footerModel;

/// Cell 的数量。
@property (nonatomic, readonly) NSInteger numberOfCellModels;

/// Cell 的数据。
/// @param index Cell 的位置
- (nullable id)modelForCellAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
