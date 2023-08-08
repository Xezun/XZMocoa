//
//  XZMocoaCollectionCellModel.h
//  XZMocoa
//
//  Created by Xezun on 2023/8/8.
//

#import <XZMocoa/XZMocoaModel.h>

NS_ASSUME_NONNULL_BEGIN

/// UICollectionView 的 cell 的数据模型。
@protocol XZMocoaCollectionCellModel <XZMocoaModel>
@end

/// 因一致性而提供，非必须基类。
/// @note 任何遵循 XZMocoaCollectionCellModel 协议的对象都可以作为数据模型，而非必须基于此类。
@interface XZMocoaCollectionCellModel : NSObject <XZMocoaCollectionCellModel>
@end

NS_ASSUME_NONNULL_END
