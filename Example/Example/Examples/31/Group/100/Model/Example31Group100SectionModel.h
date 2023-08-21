//
//  Example31Group100SectionModel.h
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import <XZMocoa/XZMocoa.h>
#import "Example31Group100CellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Example31Group100SectionModel : XZMocoaCollectionViewSectionModel
@property (nonatomic, strong) Example31Group100CellModel *model;
@end

NS_ASSUME_NONNULL_END
