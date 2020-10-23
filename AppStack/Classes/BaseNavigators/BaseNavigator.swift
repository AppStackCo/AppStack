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
    
    var rootViewController: UIViewController! { get }
    
    init(baseController: VC)
    
    func buildRoot() -> UIViewController
}

extension BaseNavigator where VC: UINavigationController {
    func setRoot() {
        baseController.viewControllers = [buildRoot()]
    }
    
    public func endFlow(_ animated: Bool = true) {
        var viewControllers = baseController.viewControllers
        guard let rootIndex = viewControllers.firstIndex(of: rootViewController) else { fatalError() }
        viewControllers.removeSubrange(rootIndex...)
        baseController.setViewControllers(viewControllers, animated: animated)
    }
}

open class BaseNavigatorImplementation<VC: UIViewController>: BaseNavigator {
    public weak var baseController: VC!
    public weak var rootViewController: UIViewController!
    
    public required init(baseController: VC) {
        self.baseController = baseController
    }
    
    open func buildRoot() -> UIViewController {
        fatalError()
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
