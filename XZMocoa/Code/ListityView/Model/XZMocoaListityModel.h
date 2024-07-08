//
//  XZMocoaListityModel.h
//  XZMocoa
//
//  Created by Xezun on 2021/4/10.
//

#import <XZMocoa/XZMocoaModel.h>
#import <XZMocoa/XZMocoaListitySectionModel.h>

NS_ASSUME_NONNULL_BEGIN

/// 以 Section 作为子视图的视图的数据模型，例如 UITableView、UICollectionView 等。
/// @note 试图 ListityView 表示 UITableView、UICollectionView 抽象合集，表示具有列表特性的一般视图，并非实际视图。
@protocol XZMocoaListityModel <XZMocoaModel>
@optional
/// section 的数量。
@property (nonatomic, readonly) NSInteger numberOfSectionModels;
/// section 的数据。
/// - Parameter index: section 的位置
- (nullable id<XZMocoaListitySectionModel>)modelForSectionAtIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
