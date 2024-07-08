//
//  XZMocoaTableCellModel.h
//  XZMocoa
//
//  Created by Xezun on 2023/7/27.
//

#import <Foundation/Foundation.h>
#import <XZMocoa/XZMocoaModel.h>

NS_ASSUME_NONNULL_BEGIN

/// UITableView 的 cell 的数据模型。
@protocol XZMocoaTableCellModel <XZMocoaModel>
@end

/// 因一致性而提供，非必须基类。
/// @note 任何遵循 XZMocoaTableCellModel 协议的对象都可以作为数据模型，而非必须基于此类。
@interface XZMocoaTableCellModel : NSObject <XZMocoaTableCellModel>
@end

NS_ASSUME_NONNULL_END
