//
//  Example30Group103SectionModel.h
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import <XZMocoa/XZMocoa.h>
#import "Example30Group103CellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Example30Group103SectionModel : XZMocoaTableViewSectionModel
@property (nonatomic, strong) Example30Group103CellModel *model;
@end

NS_ASSUME_NONNULL_END
