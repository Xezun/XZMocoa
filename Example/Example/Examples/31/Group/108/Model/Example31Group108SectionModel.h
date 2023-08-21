//
//  Example31Group108SectionModel.h
//  Example
//
//  Created by Xezun on 2023/8/20.
//

#import <XZMocoa/XZMocoa.h>
#import "Example31Group108CellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Example31Group108SectionModel : XZMocoaCollectionViewSectionModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *notes;
@property (nonatomic, strong) Example31Group108CellModel *model;
@end

NS_ASSUME_NONNULL_END
