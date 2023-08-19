//
//  XZMocoaCollectionSectionModel.h
//  Pods
//
//  Created by Xezun on 2023/7/23.
//

#import <XZMocoa/XZMocoaListityViewSectionModel.h>

/// UICollectionView 的 section 层（抽象层）的数据模型。
@protocol XZMocoaCollectionSectionModel <XZMocoaListityViewSectionModel>
@end

/// 因一致性而提供，非必须基类。
/// @note 任何遵循 XZMocoaCollectionSectionModel 协议的对象都可以作为数据模型，而非必须基于此类。
@interface XZMocoaCollectionSectionModel : NSObject <XZMocoaCollectionSectionModel>
@end
