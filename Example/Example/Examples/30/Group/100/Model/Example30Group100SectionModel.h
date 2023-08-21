//
//  Example30Group100SectionModel.h
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import <XZMocoa/XZMocoa.h>
#import "Example30Group100CellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Example30Group100SectionModel : XZMocoaTableViewSectionModel
@property (nonatomic, strong) Example30Group100CellModel *model;
@end

NS_ASSUME_NONNULL_END
