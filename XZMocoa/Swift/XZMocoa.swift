//
//  File.swift
//  XZMocoa
//
//  Created by 徐臻 on 2024/12/29.
//

import Foundation
import UIKit

/// 视图最小宽度或最小高度，实际值为千万分之一。
/// - Note: 在 iOS 14.x 系统中，设置 UITableView 中 Section 的 Header/Footer 高度为 `CGFLOAT_MIN` 能正常显示，但是在调用如下方法时，会触发 NaN 崩溃。
/// ```objc
/// [tableView reloadSections:indexes withRowAnimation:(UITableViewRowAnimationTop)]
/// ```
public let minimumViewDimension = CGFloat(0.0000001)

/// 视图最小尺寸。
///
/// 在某些情形中，设置大小为 0 会显示不正常。比如在 UICollectionView 中，Cell 的宽度或高度为 0 或 `CGFLOAT_MIN` 值，会造成普通的 cell 不能正常展示。
public let minimumViewSize = CGSize(width: minimumViewDimension, height: minimumViewDimension)

/// 构造重用标识符。
/// - Parameters:
///   - section: 要构造标识符对象的上级
///   - kind: 要构造标识符对象的分类
///   - name: 要构造标识符对象的名字
public func reuseIdentifier(forView name: Name, kind: Kind = .cell, inSection section: Name = .default) -> String {
    return "\(section):\(kind):\(name)"
}






