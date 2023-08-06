//
//  Example20Group101CellViewModel.h
//  Example
//
//  Created by Xezun on 2023/7/24.
//

#import <XZMocoa/XZMocoa.h>
#import "Example20Group101EditorViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Example20Group101CellViewModel : XZMocoaTableCellViewModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *details;
@property (nonatomic, copy) NSArray<NSURL *> *images;

@property (nonatomic, strong) Example20Group101EditorViewModel *editorViewModel;
@end

NS_ASSUME_NONNULL_END
