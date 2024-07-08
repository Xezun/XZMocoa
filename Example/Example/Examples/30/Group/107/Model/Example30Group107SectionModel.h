//
//  Example30Group107SectionModel.h
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import <XZMocoa/XZMocoa.h>
#import "Example30Group107CellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Example30Group107SectionModel : XZMocoaTableViewSectionModel
@property (nonatomic, strong) Example30Group107CellModel *model;
@end

NS_ASSUME_NONNULL_END
