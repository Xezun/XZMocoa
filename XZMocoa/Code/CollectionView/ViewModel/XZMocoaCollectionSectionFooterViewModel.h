//
//  XZMocoaCollectionSectionFooterViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2023/7/22.
//

#import <XZMocoa/XZMocoaListitySectionFooterViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZMocoaCollectionSectionFooterViewModel : XZMocoaListitySectionFooterViewModel
@property (nonatomic) CGSize size;
- (void)sizeDidChange;
@end

NS_ASSUME_NONNULL_END
