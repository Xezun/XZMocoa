//
//  Module.swift
//  XZMocoa
//
//  Created by 徐臻 on 2024/12/29.
//

import Foundation

/// 记录了 Mocoa MVVM 模块信息的对象。
///
/// 在 Mocoa 中，由 Model-View-ViewModel 组成的单元被称为 XZMocoaModule 模块。
public class Module {
    
    /// 模块地址，每个模块都应该有唯一的地址。
    ///
    /// - Note: 在开发中，根据业务的分类和分层，将模块设计成 URL 的管理方式很常见，所以 Mocoa 也采取了这种方式。
    ///
    /// |:-:|:-:|:-:|
    /// | domain | 不同类型的业务模块，使用 domain 进行区分。 |
    /// | path   | 相同类型的业务模块，使用 path 表示模块的层级关系。 |
    /// | query  | 模块传值。 |
    ///
    /// 模块在 path 中的名称，由模块的 kind 和 name 组成，格式如下：
    /// |:-:|:-:|:-:|
    /// | kind:name | 表示模块的 Mocoa Kind 和 Mocoa Name 都不为空。 |
    /// | kind:     | 表示模块的 Mocoa Name 为空。 |
    /// | name      | 表示模块的 Mocoa Kind 为空。 |
    public let url: URL
    
    public init(url: URL) {
        self.url = url
    }
    
    static public func module(for url: URL) -> Module? {
        guard let host = url.host else { return nil }
        
        let domain = Domain.named(host)
        
        let path = ({ (url: URL) -> String in
            if #available(iOS 16.0, *) {
                let path = url.path(percentEncoded: false)
                return path.count == 0 ? "/" : path
            } else if let path = url.path.removingPercentEncoding {
                return path.count == 0 ? "/" : path
            } else {
                return "/"
            }
        })(url)
        
        if let module = domain.module(forPath: path) {
            return module
        }
        
        return nil
    }
    
    /// MVVM 中 Model 的 class 对象。
    public var modelClass: AnyClass?
    
    /// MVVM 中 View 的 class 对象。
    public var viewClass: AnyClass? {
        didSet {
            viewNibClass = nil
            viewNibBundle = nil
        }
    }
    /// MVVM 中 View 的 class 对象，但是应该使用 nib 初始化。
    public var viewNibClass: AnyClass? {
        get {
            return viewClass
        }
        set {
            setViewNib(with: newValue)
        }
    }
    /// MVVM 中 View 的 nib 的名称，优先级比属性 viewClass 高。
    public var viewNibName: String?
    /// MVVM 中 View 的 nib 所在的包。
    public var viewNibBundle: Bundle?
    
    /// 设置 View 的 nib 信息。
    /// - Parameters:
    ///   - viewClass: 视图的 class 对象
    ///   - name: 视图 nib 名称
    ///   - bundle: 视图 nib 所在的包
    public func setViewNib(with viewClass: AnyClass?, name: String? = nil, bundle: Bundle? = nil) {
        self.viewClass = viewClass
        self.viewNibName = name
        self.viewNibBundle = bundle
    }
    
    /// MVVM 中 ViewModel 的 class 对象。
    public var viewModelClass: AnyClass?
    
    /// 子模块。
    private var submodules = [Kind: SubmoduleCollection]()
    
    /// 获取指定分类下的子模块的 XZMocoaModule 对象。
    /// - Note: 该方法为懒加载。
    /// - Parameters:
    ///   - name: 名称
    ///   - kind: 分类
    /// - Returns: 子模块
    public func submodule(for name: Name, for kind: Kind = .default) -> Module {
        var namedModules: SubmoduleCollection! = self.submodules[kind]
        if namedModules == nil {
            namedModules = SubmoduleCollection()
            submodules[kind] = namedModules;
        }
        
        var submodule: Module! = namedModules[name]
        if submodule == nil {
            let url = self.url.appendingPathComponent(kind & name)
            submodule = Module.init(url: url)
            namedModules[name] = submodule
            
            if #available(iOS 16.0, *) {
                if let host = url.host(percentEncoded: false) {
                    let domain = Domain.named(host)
                    domain.setModule(submodule, forPath: url.path)
                }
            } else if let host = url.host {
                let domain = Domain.named(host)
                domain.setModule(submodule, forPath: url.path)
            }
        }
        return submodule
    }
    
    /// 设置或删除指定分类下指定名称的子模块的 XZMocoaModule 对象。
    /// - Note: 该方法一般用于删除下级，添加下级请用懒加载方法。
    /// - Parameters:
    ///   - newSubmodule: 子模块的 XZMocoaModule 对象
    ///   - name: 名称
    ///   - kind: 分类
    public func setSubmodule(_ newSubmodule: Module?, for name: Name, for kind: Kind = .default) {
        if let newSubmodule = newSubmodule {
            if submodules.isEmpty {
                let namedModules = SubmoduleCollection.init()
                namedModules[name] = newSubmodule
                submodules[kind] = namedModules
            } else if let namedModules = submodules[kind] {
                namedModules[name] = newSubmodule
            } else {
                let namedModules = SubmoduleCollection.init()
                namedModules[name] = newSubmodule
                submodules[kind] = namedModules
            }
        } else if submodules.isEmpty {
            return
        } else if let namedModules = submodules[kind] {
            namedModules[name] = nil
        }
    }
    
    /// 获取指定分类下的子模块的的 XZMocoaModule 对象，非懒加载。
    /// - Parameters:
    ///   - name: 名称
    ///   - kind: 分类
    /// - Returns: 子模块
    public func submoduleIfLoaded(for name: Name, for kind: Kind = .default) -> Module? {
        return submodules[kind]?[name]
    }
    
    /// 获取指定路径的子模块，这是一个懒加载方法。
    /// - Parameter path: 子模块的路径
    /// - Returns: 子模块
    public func submodule(forPath path: String) -> Module {
        var submodule = self
        for subpath in path.components(separatedBy: "/") {
            if subpath.isEmpty {
                continue
            }
            let info = ~path;
            submodule = submodule.submodule(for: info.name, for: info.kind)
        }
        return submodule
    }
    
}

extension Module {
    
    /// 为 XZMocoaModule 提供下标式访问的协议。
    /// ```objc
    /// // 常规方式获取下级
    /// let submodule = module.submodule(for: "name", for: "kind");
    /// // 下标方式来获取下级
    /// let submodule = module["kind"]["name"];
    /// ```
    public subscript(for kind: Kind) -> SubmoduleCollection {
        if let nameModules = submodules[kind] {
            return nameModules
        }
        let namedModules = SubmoduleCollection.init()
        submodules[kind] = namedModules
        return namedModules
    }
    
}

extension Module: CustomStringConvertible, Sequence {
    
    public var description: String {
        return description(with: 0, kind: .default, name: .default)
    }
    
    public typealias Element = (submodule: Module, kind: Kind, name: Name)
    
    public typealias Iterator = AnyIterator<Element>
    
    public func makeIterator() -> AnyIterator<Element> {
        var kindIterator = submodules.makeIterator()
        var kindItem: Dictionary<Kind, SubmoduleCollection>.Element! = kindIterator.next();
        
        var nameIterator: Dictionary<Name, Module>.Iterator! = nil;
        return AnyIterator.init({ () -> Element? in
            while (kindItem != nil) {
                if nameIterator == nil {
                    nameIterator = kindItem.value.makeIterator()
                }
                if let nameItem = nameIterator.next() {
                    return (nameItem.value, kindItem.key, nameItem.key)
                }
                kindItem = kindIterator.next()
            }
            return nil
        })
    }
    
    private func description(with padding: Int, kind: Kind, name: Name) -> String {
        let tab = String.init(repeating: " ", count: padding * 4)
        
        var strings = [String]()
        strings.append("{")
        
        strings.append("\(tab)    self: <\(type(of: self))>")
        strings.append("\(tab)    url: \(url)");
        strings.append("\(tab)    kind: \(kind)");
        strings.append("\(tab)    name: \(name)");
        
        strings.append("\(tab)    model: \(String(describing: modelClass))");
        strings.append("\(tab)    view: \(viewNibName ?? (viewClass != nil ? NSStringFromClass(viewClass!) : "nil") )");
        strings.append("\(tab)    viewModel: \(String(describing: viewModelClass))");
        
        if !submodules.isEmpty {
            strings.append("\(tab)    submodules: [")
            
            for (submodule, kind, name) in self {
                let string = submodule.description(with: padding + 2, kind: kind, name: name)
                strings.append(string)
            }
            
            strings.append("\(tab)    ]")
        }
        
        strings.append("\(tab)}")
        return strings.joined(separator: "\n")
    }
}

extension Module {
    
    // section
    
    /// UITableView 或 UICollectionView 模块的默认的 section 模块。
    ///
    /// Section 是 UITableView 或 UICollectionView 的直接下级，Header/Cell/Footer 是 Section 的直接下级。
    ///
    /// 此属性仅用于表示 UITableView 或 UICollectionView 模块的 XZMocoaModule 对象。
    ///
    /// 此属性等同于`[table submoduleForName:XZMocoaNameNone forKind:XZMocoaKindNone]`。
    public var section: Module {
        get {
            return submodule(for: .default, for: .section)
        }
        set {
            setSubmodule(newValue, for: .default, for: .section)
        }
    }
    
    /// 获取 UITableView 或 UICollectionView 模块的指定名称 section 模块。
    ///
    /// Section 是 UITableView 或 UICollectionView 的直接下级，Header/Cell/Footer 是 Section 的直接下级。
    ///
    /// 此方法仅用于表示 UITableView 或 UICollectionView 模块的 XZMocoaModule 对象。
    ///
    /// - Parameter name: 模块名称
    /// - Returns: 子模块
    public func section(for name: Name) -> Module {
        return submodule(for: name, for: .section)
    }
    
    /// 设置 section 模块为 UITableView 或 UICollectionView 模块的下级模块。
    /// 
    /// Section 是 UITableView 或 UICollectionView 的直接下级，Header/Cell/Footer 是 Section 的直接下级。
    /// 
    /// - Attention: 此方法仅用于表示 UITableView 或 UICollectionView 模块的 XZMocoaModule 对象。
    /// 
    /// - Parameter module: 模块对象
    /// - Parameter name: 模块名称
    public func setSection(_ module: Module, for name: Name) {
        setSubmodule(module, for: name, for: .section)
    }
    
    // header
    
    /// UITableView 或 UICollectionView 的 Section 模块的默认的 Header 模块。
    ///
    /// Section 是 UITableView 或 UICollectionView 的直接下级，Header/Cell/Footer 是 Section 的直接下级。
    ///
    /// 此属性仅用于表示 UITableView 或 UICollectionView 的 Section 模块的 XZMocoaModule 对象。
    ///
    /// 此属性等同于`[section submoduleForKind:XZMocoaKindHeader forName:XZMocoaNameNone]`。
    public var header: Module {
        get {
            return submodule(for: .default, for: .header)
        }
        set {
            setSubmodule(newValue, for: .default, for: .header)
        }
    }
    
    /// 获取 UITableView 或 UICollectionView 的 Section 模块的指定名称的 Header 模块。
    /// 
    /// Section 是 UITableView 或 UICollectionView 的直接下级，Header/Cell/Footer 是 Section 的直接下级。
    /// 
    /// 此方法仅用于表示 UITableView 或 UICollectionView 的 Section 模块的 XZMocoaModule 对象。
    /// 
    /// 此方法等同于`[section submoduleForKind:XZMocoaKindHeader forName:name]`。
    ///
    /// - Parameter name: 下级的名称
    /// - Returns: 子模块
    public func header(for name: Name) -> Module {
        return submodule(for: name, for: .header)
    }
    
    /// 设置 UITableView 或 UICollectionView 的 Section 模块的指定名称的 Header 模块。
    /// 
    /// Section 是 UITableView 或 UICollectionView 的直接下级，Header/Cell/Footer 是 Section 的直接下级。
    /// 
    /// 此方法仅用于表示 UITableView 或 UICollectionView 的 Section 模块的 XZMocoaModule 对象。
    /// 
    /// 此方法等同于`[section setSubmodule:header forKind:XZMocoaKindHeader forName:name]`。
    /// - Parameter module: 模块对象
    /// - Parameter name: 模块名称
    public func setHeader(_ module: Module, for name: Name) {
        setSubmodule(module, for: name, for: .header)
    }
    
    // footer
    
    /// UITableView 或 UICollectionView 的 Section 模块的默认的 Footer 模块。
    /// @discussion
    /// Section 是 UITableView 或 UICollectionView 的直接下级，Header/Cell/Footer 是 Section 的直接下级。
    /// @attention
    /// 此属性仅用于表示 UITableView 或 UICollectionView 的 Section 模块的 XZMocoaModule 对象。
    /// @discussion 此方法等同于`[section submoduleForKind:XZMocoaKindFooter forName:XZMocoaNameNone]`。
    public var footer: Module {
        get {
            return submodule(for: .default, for: .footer)
        }
        set {
            setSubmodule(newValue, for: .default, for: .footer)
        }
    }
    
    /// 获取 UITableView 或 UICollectionView 的 Section 模块的指定名称的 Footer 模块。
    /// @discussion
    /// Section 是 UITableView 或 UICollectionView 的直接下级，Header/Cell/Footer 是 Section 的直接下级。
    /// @attention
    /// 此属性仅用于表示 UITableView 或 UICollectionView 的 Section 模块的 XZMocoaModule 对象。
    /// @discussion
    /// 此方法等同于`[section submoduleForKind:XZMocoaKindFooter forName:name]`。
    /// @param name 模块名称
    public func footer(for name: Name) -> Module {
        return submodule(for: name, for: .footer)
    }
    
    /// 设置 UITableView 或 UICollectionView 的 Section 模块的指定名称的 Footer 模块。
    /// @discussion
    /// Section 是 UITableView 或 UICollectionView 的直接下级，Header/Cell/Footer 是 Section 的直接下级。
    /// @attention
    /// 此属性仅用于表示 UITableView 或 UICollectionView 的 Section 模块的 XZMocoaModule 对象。
    /// @discussion
    /// 此方法等同于`[section setSubmodule:footer forKind:XZMocoaKindFooter forName:name]`。
    /// @param footer 模块对象
    /// @param name 模块名称
    public func setFooter(_ module: Module, for name: Name) {
        setSubmodule(module, for: name, for: .footer)
    }
    
    // cell
    
    /// UITableView 或 UICollectionView 的 Section 模块的默认的 Cell 模块。
    /// @discussion
    /// Section 是 UITableView 或 UICollectionView 的直接下级，Header/Cell/Footer 是 Section 的直接下级。
    /// @attention
    /// 此属性仅用于表示 UITableView 或 UICollectionView 的 Section 模块的 XZMocoaModule 对象。
    /// @discussion
    /// 此属性等同于`[section submoduleForKind:XZMocoaKindCell forName:XZMocoaNameNone]`。
    public var cell: Module {
        get {
            return submodule(for: .default, for: .cell)
        }
        set {
            setSubmodule(newValue, for: .default, for: .cell)
        }
    }
    
    /// 获取 UITableView 或 UICollectionView 的 Section 模块的指定名称的 Cell 模块。
    /// @discussion
    /// Section 是 UITableView 或 UICollectionView 的直接下级，Header/Cell/Footer 是 Section 的直接下级。
    /// @attention
    /// 此属性仅用于表示 UITableView 或 UICollectionView 的 Section 模块的 XZMocoaModule 对象。
    /// @discussion
    /// 此属性等同于`[section submoduleForKind:XZMocoaKindCell forName:name]`。
    /// @param name 模块名称
    public func cell(for name: Name) -> Module {
        return submodule(for: name, for: .cell)
    }
    
    /// 设置 UITableView 或 UICollectionView 的 Section 模块的指定名称的 Cell 模块。
    /// @discussion
    /// Section 是 UITableView 或 UICollectionView 的直接下级，Header/Cell/Footer 是 Section 的直接下级。
    /// @attention
    /// 此属性仅用于表示 UITableView 或 UICollectionView 的 Section 模块的 XZMocoaModule 对象。
    /// @discussion
    /// 此属性等同于`[section setSubmodule:cell forKind:XZMocoaKindCell forName:name]`。
    /// @param name 模块名称
    public func setCell(_ module: Module, for name: Name) {
        setSubmodule(module, for: name, for: .cell)
    }
    
    /// 为 XZMocoaModule 提供下标式访问的中间对象。
    public class SubmoduleCollection: Sequence {
        
        private var modules: [Name: Module]
        
        fileprivate init() {
            self.modules = [Name: Module]()
        }
        
        public subscript(name: Name) -> Module? {
            get {
                return modules[name]
            }
            set {
                modules[name] = newValue
            }
        }
        
        public typealias Element = Dictionary<Name, Module>.Element
        
        public typealias Iterator = Dictionary<Name, Module>.Iterator
        
        public func makeIterator() -> Dictionary<Name, Module>.Iterator {
            return modules.makeIterator()
        }
        
        public var underestimatedCount: Int {
            return modules.underestimatedCount
        }
        
    }
}



/// 将模块的 kind 和 name 名称，合并为模块在 domain 中的路径。
public func &(kind: Kind, name: Name) -> String {
    if kind.rawValue.count > 0 {
        return "\(kind):\(name)"
    }
    if name.rawValue.count > 0 {
        return name.rawValue
    }
    return ":"
}

/// 将模块在 domain 中的路径，反解为模块的 name 和 kind 名称。
public prefix func ~(path: String) -> (kind: Kind, name: Name) {
    if let range = path.range(of: ":") {
        let kind = String(path[..<range.lowerBound])
        let name = String(path[range.upperBound...])
        return (Kind.init(rawValue: kind), Name.init(rawValue: name))
    }
    return (.default, Name.init(rawValue: path))
}
