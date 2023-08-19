//
//  XZMocoaTableViewPlaceholderHeaderFooterView.h
//  XZMocoa
//
//  Created by Xezun on 2023/8/19.
//

#import <XZMocoa/XZMocoa.h>

NS_ASSUME_NONNULL_BEGIN

#if DEBUG
@interface XZMocoaTableViewPlaceholderHeaderFooterView : XZMocoaTableViewHeaderFooterView
@end
#else
typedef XZMocoaTableSectionHeaderFooter XZMocoaTableViewPlaceholderHeaderFooterView;
#endif

NS_ASSUME_NONNULL_END
