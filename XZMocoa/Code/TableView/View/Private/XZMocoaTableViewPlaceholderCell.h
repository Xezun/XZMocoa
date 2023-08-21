//
//  XZMocoaTableViewPlaceholderCell.h
//  XZMocoa
//
//  Created by Xezun on 2023/8/19.
//

#import <XZMocoa/XZMocoaTableViewCell.h>

NS_ASSUME_NONNULL_BEGIN

#if DEBUG
@interface XZMocoaTableViewPlaceholderCell : XZMocoaTableViewCell
+ (NSString *)reasonByCheckingModule:(nullable XZMocoaModule *)module;
+ (void)showAlertForView:(id<XZMocoaView>)view model:(id)model reason:(NSString *)reason detail:(NSString *)detail;
@end
#else
typedef XZMocoaTableViewCell XZMocoaTableViewPlaceholderCell;
#endif

NS_ASSUME_NONNULL_END
