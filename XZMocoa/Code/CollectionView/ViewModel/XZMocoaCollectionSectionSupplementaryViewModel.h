//
//  XZMocoaCollectionSectionSupplementaryViewModel.h
//  XZMocoa
//
//  Created by Xezun on 2023/8/9.
//

#import <XZMocoa/XZMocoaListitySectionSupplementaryViewModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZMocoaCollectionSectionSupplementaryViewModel : XZMocoaListitySectionSupplementaryViewModel
@property (nonatomic) CGSize size;
- (void)sizeDidChange;
@end

NS_ASSUME_NONNULL_END
