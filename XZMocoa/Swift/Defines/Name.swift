//
//  Name.swift
//  XZMocoa
//
//  Created by 徐臻 on 2024/12/29.
//

/// 模块的名称。
/// - Attention: 字符`:`、`/`为保留字符，不可在 XZMocoaName 中使用。
public struct Name: RawRepresentable, ExpressibleByStringLiteral, Hashable {
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public var rawValue: String
    
    public typealias RawValue = String
    
    public typealias StringLiteralType = String
    
    public init(stringLiteral value: String) {
        self.rawValue = value;
    }
    
}

extension Name {
    /// 默认名称，或者没有名称。
    ///
    /// 在 tableView/collectionView 中，具名的 section 在查询 cell 子模块时，会查询 XZMocoaNameNone 的 section 模块。
    public static let `default` = Name.init(rawValue: "")
    
    /// 占位视图的名称。
    public static let placeholder = Name.init(rawValue: "XZMocoaNamePlaceholder")
}
