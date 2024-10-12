//
//  XZMocoaDefines.h
//  XZMocoa
//
//  Created by Xezun on 2021/11/5.
//

#import <UIKit/UIKit.h>
@import XZDefines;

NS_ASSUME_NONNULL_BEGIN

/// 合法的视图最小宽度或最小高度，实际值为 0.000001 百万分之一。
/// @note
/// 在 iOS 14.x 系统中，设置 UITableView 中 Section 的 Header/Footer 高度为 `CGFLOAT_MIN` 能正常显示，但是在调用如下方法时，会触发 NaN 崩溃。
/// @code
/// [tableView reloadSections:indexes withRowAnimation:(UITableViewRowAnimationTop)]
/// @endcode
UIKIT_EXTERN CGFloat const XZMocoaViewMinimumDimension NS_SWIFT_NAME(XZMocoaView.minimumDimension);

/// 合法的最小视图大小。
/// @discussion
/// 在某些情形中，直接设置大小为 0 会显示不正常。比如在 UICollectionView 中，Cell 的宽度或高度为 0 或 `CGFLOAT_MIN` 值，会造成普通的 cell 不能正常展示。
UIKIT_EXTERN CGSize  const XZMocoaViewMinimumSize NS_SWIFT_NAME(XZMocoaView.minimumSize);

UIKIT_EXTERN CGFloat const XZMocoaTableViewHeaderFooterHeight XZ_API_RENAMED("XZMocoaViewMinimumDimension", ios(1.0, 12.0));
UIKIT_EXTERN CGSize  const XZMocoaCollectionViewItemSize XZ_API_RENAMED("XZMocoaViewMinimumSize", ios(1.0, 12.0));

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
