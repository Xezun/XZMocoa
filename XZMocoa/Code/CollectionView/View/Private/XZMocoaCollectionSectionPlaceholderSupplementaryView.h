//
//  XZMocoaCollectionSectionPlaceholderSupplementaryView.h
//  XZMocoa
//
//  Created by Xezun on 2023/8/19.
//

#import <XZMocoa/XZMocoa.h>

NS_ASSUME_NONNULL_BEGIN

#if DEBUG
@interface XZMocoaCollectionSectionPlaceholderSupplementaryView : XZMocoaCollectionSectionSupplementaryView
@end
#else
typedef XZMocoaCollectionSectionSupplementaryView XZMocoaCollectionSectionPlaceholderSupplementaryView;
#endif

NS_ASSUME_NONNULL_END
