//
//  XZMocoaCollectionViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import <XZMocoa/XZMocoaListityViewModel.h>
#import <XZMocoa/XZMocoaCollectionCellViewModel.h>
#import <XZMocoa/XZMocoaCollectionSectionViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZMocoaCollectionViewModel : XZMocoaListityViewModel <XZMocoaCollectionCellViewModel *, XZMocoaCollectionSectionViewModel *>

@end

NS_ASSUME_NONNULL_END
