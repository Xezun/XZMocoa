//
//  Kind.swift
//  XZMocoa
//
//  Created by 徐臻 on 2024/12/29.
//

/// 模块的分类。
/// - Attention: 字符`:`、`/`为保留字符，不可在 XZMocoaKind 中使用。
public struct Kind: RawRepresentable, ExpressibleByStringLiteral, Hashable {
    
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

extension Kind {
    /// 默认分类，或者没有分类。
    public static let `default` = Kind.init(rawValue: "")
    /// 用于表示 Header 的分类。
    public static let header    = Kind.init(rawValue: "header")
    /// 用于表示 Footer 的分类。
    public static let footer    = Kind.init(rawValue: "footer")
    /// 用于表示 Section 的分类。
    public static let section   = Kind.init(rawValue: "")
    /// 用于表示 Cell 的分类。
    public static let cell      = Kind.init(rawValue: "")
}
