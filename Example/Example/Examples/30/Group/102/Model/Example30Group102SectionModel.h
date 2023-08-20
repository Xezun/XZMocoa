//
//  Example30Group102SectionModel.h
//  Example
//
//  Created by Xezun on 2023/8/20.
//
// 模拟 cell 模块 Model 没有注册的情况

#import <XZMocoa/XZMocoa.h>
#import "Example30Group102CellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Example30Group102SectionModel : XZMocoaTableViewSectionModel
@property (nonatomic, strong) Example30Group102CellModel *model;
@end

NS_ASSUME_NONNULL_END
