//
//  Example30Group105SectionModel.h
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import <XZMocoa/XZMocoa.h>
#import "Example30Group105CellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Example30Group105SectionModel : XZMocoaTableViewSectionModel
@property (nonatomic, strong) Example30Group105CellModel *model;
@end

NS_ASSUME_NONNULL_END
