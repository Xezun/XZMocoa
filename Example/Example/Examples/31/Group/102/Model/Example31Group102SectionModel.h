//
//  Example31Group102SectionModel.h
//  Example
//
//  Created by Xezun on 2023/8/20.
//
// 模拟 cell 模块 Model 没有注册的情况

#import <XZMocoa/XZMocoa.h>
#import "Example31Group102CellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Example31Group102SectionModel : XZMocoaCollectionViewSectionModel
@property (nonatomic, strong) Example31Group102CellModel *model;
@end

NS_ASSUME_NONNULL_END
