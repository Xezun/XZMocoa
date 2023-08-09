//
//  XZMocoaCollectionSectionViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import <XZMocoa/XZMocoaListitySectionViewModel.h>
#import <XZMocoa/XZMocoaCollectionCellViewModel.h>
#import <XZMocoa/XZMocoaCollectionSectionHeaderViewModel.h>
#import <XZMocoa/XZMocoaCollectionSectionFooterViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZMocoaCollectionSectionViewModel : XZMocoaListitySectionViewModel<XZMocoaCollectionCellViewModel *>

@end

NS_ASSUME_NONNULL_END
