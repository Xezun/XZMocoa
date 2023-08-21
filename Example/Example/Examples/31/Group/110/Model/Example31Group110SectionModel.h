//
//  Example31Group110SectionModel.h
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import <XZMocoa/XZMocoa.h>
#import "Example31Group110CellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Example31Group110SectionModel : XZMocoaCollectionViewSectionModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *notes;
@property (nonatomic, strong) Example31Group110CellModel *model;
@end

NS_ASSUME_NONNULL_END
