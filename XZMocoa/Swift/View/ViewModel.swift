//
//  ViewModel.swift
//  XZMocoa
//
//  Created by 徐臻 on 2024/12/30.
//

import UIKit

public protocol ViewModelProtocol {
    associatedtype Model: ModelProtocol
    init(model: Model)
}


open class ViewModel<Model: ModelProtocol>: ViewModelProtocol {
    
    public var model: Model
    public var index: Int
    public required init(model: Model) {
        self.index = 0
        self.model = model
        self.isReady = false
    }
    
    public convenience init(model: Model, ready synchronously: Bool) {
        self.init(model: model)
        if synchronously {
            self.ready()
        } else {
            RunLoop.main.perform {
                self.ready()
            }
        }
    }
    
    public var isReady: Bool
    public fileprivate(set) var subViewModels = [ViewModel]()
    
    public func ready() {
        if (isReady) {
            return
        }
        prepare()
        isReady = true
        for subViewModel in subViewModels {
            subViewModel.ready()
        }
    }
    
    open func prepare() {
        
    }
    
}

extension ViewModel: CustomStringConvertible {
    
    public var description: String {
        let name = type(of: self)
        let addr = unsafeBitCast(self, to: Int.self)
        return "<\(name): \(addr), isReady = \(isReady), subViewModels = (\(subViewModels.count) objects)>"
    }
    
}

extension ViewModel {
    
}
