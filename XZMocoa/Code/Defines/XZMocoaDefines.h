//
//  XZMocoaDefines.h
//  XZMocoa
//
//  Created by Xezun on 2021/11/5.
//

#import <UIKit/UIKit.h>
@import XZDefines;

NS_ASSUME_NONNULL_BEGIN

/// UITableView 的 Header/Footer 的默认高度，值 0.00001 。
/// @discussion
/// iOS14.x，在 UITableView 中，如果 Section 的 Header/Footer 高度为 CGFLOAT\_MIN 时，
/// 那么在移除 Section 的所有 cell 时，使用 -reloadSections:withRowAnimation: 更新局部视图，会触发NaN崩溃。
UIKIT_EXTERN CGFloat const XZMocoaTableViewHeaderFooterHeight;


/// 模块的名称。
/// @attention 字符`:`、`/`为保留字符，不可在 XZMocoaName 中使用。
typedef NSString *XZMocoaName;

/// 模块的分类。
/// @attention 字符`:`、`/`为保留字符，不可在 XZMocoaKind 中使用。
typedef NSString *XZMocoaKind;

/// 默认名称，或者没有名称。
/// @discussion
/// 在 tableView/collectionView 中，具名的 section 在查询 cell 子模块时，会查询 XZMocoaNameNone 的 section 模块。
FOUNDATION_EXPORT XZMocoaName const XZMocoaNameNone;
/// 默认分类，或者没有分类。
FOUNDATION_EXPORT XZMocoaKind const XZMocoaKindNone;
/// 用于表示 Header 的分类。
FOUNDATION_EXPORT XZMocoaKind const XZMocoaKindHeader;
/// 用于表示 Footer 的分类。
FOUNDATION_EXPORT XZMocoaKind const XZMocoaKindFooter;
/// 用于表示 Section 的分类。
FOUNDATION_EXPORT XZMocoaKind const XZMocoaKindSection;
/// 用于表示 Cell 的分类。
FOUNDATION_EXPORT XZMocoaKind const XZMocoaKindCell;

/// 占位视图的名称。
FOUNDATION_EXPORT XZMocoaName const XZMocoaNamePlaceholder;

/// 构造重用标识符。
/// - Parameters:
///   - section: 要构造标识符对象的上级
///   - kind: 要构造标识符对象的分类
///   - name: 要构造标识符对象的名字
FOUNDATION_STATIC_INLINE NSString *XZMocoaReuseIdentifier(XZMocoaName _Nullable section, XZMocoaKind _Nullable kind, XZMocoaName _Nullable name) {
    return [NSString stringWithFormat:@"%@:%@:%@", (section ?: XZMocoaNameNone), (kind ?: XZMocoaKindNone), (name ?: XZMocoaNameNone)];
}

NS_ASSUME_NONNULL_END
