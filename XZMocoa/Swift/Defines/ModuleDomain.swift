//
//  Domain.swift
//  XZMocoa
//
//  Created by 徐臻 on 2024/12/29.
//

import Foundation

extension Module {
    
    /// 模块所在的域，一种基于 URL 的模块管理方式。
    public class Domain {
        /// 域名。
        public let name: String
        
        private var modules = [String: Module]()
        
        private init(name: String) {
            self.name = name;
        }
        
        /// 模块由外部提供懒加载，强引用。
        public var provider: Module.Provider?
    }
    
    /// 提供模块的对象，需要实现的协议。
    public protocol Provider {
        /// 获取指定路径的模块。
        /// - Parameters:
        ///   - domain: 调用此方法的模块管理对象，即模块所在的域
        ///   - path: 模块的路径，一定是合法的。
        func domain(_ domain: Module.Domain, moduleForPath path: String) -> Module?
    }
}


extension Module.Domain: Module.Provider {
    
    private static var table = [String: Module.Domain]()
    
    static public func named(_ name: String) -> Module.Domain {
        if let domain = Module.Domain.table[name] {
            return domain
        }
        let domain = Module.Domain.init(name: name)
        Module.Domain.table[name] = domain
        return domain
    }
    
    public func module(forPath path: String) -> Module? {
        assert(Module.Domain.isPathValid(path), "参数 path=\(path) 不合法")
        
        if let module = modules[path] {
            return module
        }
        
        let provider = self.provider ?? self
        
        let module = provider.domain(self, moduleForPath: path)
        modules[path] = module
        return module
    }
    
    public func setModule(_ module: Module?, forPath path: String) {
        assert(Module.Domain.isPathValid(path), "参数 path=\(path) 不合法")
        modules[path] = module
    }
    
    private static let regularExpression = try! NSRegularExpression.init(pattern: "^((/\\w+\\:\\w*)|(/\\w+)|(/\\:))+$")
    
    private static func isPathValid(_ path: String) -> Bool {
        switch path.count {
        case 0:
            return false;
        case 1:
            return path == "/"
        default:
            break
        }
        
        let search = NSMakeRange(0, (path as NSString).length)
        let result = Module.Domain.regularExpression.rangeOfFirstMatch(in: path, range: search)
        return result.location == 0 && result.length == search.length
    }
    
}


extension URL {
    
    public init?(_ domain: Module.Domain, path: String) {
        self.init(string: "mocoa://\(domain.name)\(path.count > 0 ? path : "/")")
    }
    
}

extension Module.Provider {

    public func domain(_ domain: Module.Domain, moduleForPath path: String) -> Module? {
        guard let url = URL.init(domain, path: path) else {
            return nil
        }
        
        let currPath = url.path;
        
        if currPath == "/" {
            return Module.init(url: url)
        }
        
        let superPath = (currPath as NSString).deletingLastPathComponent
        let superModule = domain.module(forPath: superPath)
        
        let info = ~((currPath as NSString).lastPathComponent)
        
        var module = superModule?.submoduleIfLoaded(for: info.name, for: info.kind)
        if module == nil {
            module = Module.init(url: url)
            superModule?.setSubmodule(module, for: info.name, for: info.kind)
        }
        return module
    }
    
}
