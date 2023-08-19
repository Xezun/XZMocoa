//
//  XZMocoaTablePlaceholderCell.h
//  XZMocoa
//
//  Created by Xezun on 2023/8/19.
//

#import <XZMocoa/XZMocoa.h>

NS_ASSUME_NONNULL_BEGIN

#if DEBUG
@interface XZMocoaTablePlaceholderCell : XZMocoaTableViewCell
@end
#else
typedef XZMocoaTableCell XZMocoaTablePlaceholderCell;
#endif

NS_ASSUME_NONNULL_END
