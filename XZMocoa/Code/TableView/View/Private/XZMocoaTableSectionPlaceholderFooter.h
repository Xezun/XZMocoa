//
//  XZMocoaTableSectionPlaceholderFooter.h
//  XZMocoa
//
//  Created by Xezun on 2023/8/19.
//

#import <XZMocoa/XZMocoa.h>

NS_ASSUME_NONNULL_BEGIN

#if DEBUG
@interface XZMocoaTableSectionPlaceholderFooter : XZMocoaTableSectionHeaderFooter
@end
#else
typedef XZMocoaTableSectionHeaderFooter XZMocoaTableSectionPlaceholderFooter;
#endif

NS_ASSUME_NONNULL_END
