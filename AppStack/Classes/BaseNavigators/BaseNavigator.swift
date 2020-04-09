//
//  BaseNavigator.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 09/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

public protocol BaseNavigator {
    associatedtype VC: UIViewController
    
    var baseController: VC! { get }
    
    init(baseController: VC)
    
    func buildRoot() -> UIViewController
}

extension BaseNavigator where VC: UINavigationController {
    func setRoot() {
        baseController.viewControllers = [buildRoot()]
    }
}

open class BaseNavigatorImplementation<VC: UIViewController>: BaseNavigator {
    public weak var baseController: VC!
    
    public required init(baseController: VC) {
        self.baseController = baseController
    }
    
    open func buildRoot() -> UIViewController {
        UIViewController()
    }
}

public protocol TabBarViewControllerNavigator {
    func setupRoot()
}

extension TabBarViewControllerNavigator where Self: BaseNavigator, Self.VC: UINavigationController {
    public func setupRoot() {
        setRoot()
    }
}
