//
//  XZMocoaTableSectionPlaceholderHeader.h
//  XZMocoa
//
//  Created by Xezun on 2023/8/19.
//

#import <XZMocoa/XZMocoa.h>

NS_ASSUME_NONNULL_BEGIN

#if DEBUG
@interface XZMocoaTableSectionPlaceholderHeader : XZMocoaTableSectionHeaderFooter
@end
#else
typedef XZMocoaTableSectionHeaderFooter XZMocoaTableSectionPlaceholderHeader;
#endif

NS_ASSUME_NONNULL_END
