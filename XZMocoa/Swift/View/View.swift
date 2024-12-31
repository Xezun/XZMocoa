//
//  File.swift
//  XZMocoa
//
//  Created by 徐臻 on 2024/12/30.
//

import Foundation
import UIKit

public protocol ViewProtocol {
    
    var viewModel: any ViewModelProtocol { get set }
}


extension ViewProtocol where Self: UIView {
    
    
    public var viewController: UIViewController? {
        // TODO: imp for method
        return nil
    }
    
    public var navigationController: UINavigationController? {
        return viewController?.navigationController
    }
    
    public var tabBarController: UITabBarController? {
        return viewController?.tabBarController
    }
    
}
