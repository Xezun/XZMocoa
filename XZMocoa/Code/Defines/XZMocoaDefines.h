//
//  XZMocoaDefines.h
//  XZMocoa
//
//  Created by Xezun on 2021/11/5.
//

#import <UIKit/UIKit.h>
@import XZDefines;

/// UITableView 的 Header/Footer 的默认高度，值 0.00001 。
/// @discussion
/// iOS14.x，在 UITableView 中，如果 Section 的 Header/Footer 高度为 CGFLOAT\_MIN 时，
/// 那么在移除 Section 的所有 cell 时，使用 -reloadSections:withRowAnimation: 更新局部视图，会触发NaN崩溃。
UIKIT_EXTERN CGFloat const XZMocoaTableViewHeaderFooterHeight;
