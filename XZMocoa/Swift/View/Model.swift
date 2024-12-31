//
//  Model.swift
//  XZMocoa
//
//  Created by 徐臻 on 2024/12/30.
//

public protocol ModelProtocol {
    
    var mocoaName: Name { get }
    
}

extension ModelProtocol where Self: AnyObject {
    
    public var mocoaName: Name {
        return .default
    }
    
}
