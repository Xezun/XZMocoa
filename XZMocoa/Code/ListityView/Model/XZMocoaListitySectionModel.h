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
/// cell 数量。
@property (nonatomic, readonly) NSInteger numberOfCellModels;
/// cell 数据。
/// @param index 在 section 中 cell 的位置
- (nullable id)modelForCellAtIndex:(NSInteger)index;

/// 附加视图的类型，默认 XZMocoaKindHeader、XZMocoaKindFooter 两种。
@property (nonatomic, readonly) NSArray<XZMocoaKind> *supplementaryKinds;
/// 附加视图的数量，默认1。
/// - Parameter kind: 附加视图的类型
- (NSInteger)numberOfModelsForSupplementaryKind:(XZMocoaKind)kind;
/// 附加视图的数据。
/// - Parameters:
///   - kind: 附加视图的类型
///   - index: 附加视图的位置
- (nullable id)modelForSupplementaryKind:(XZMocoaKind)kind atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
