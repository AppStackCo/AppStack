//
//  Coordinator.swift
//  DemoArchitecture
//
//  Created by Marius Gutoi on 07/02/2019.
//  Copyright © 2019 Marius Gutoi. All rights reserved.
//

import RxSwift
import UIKit

//enum ContainerType {
//    case window
//    case navigation
//    case tabbar
//    case modalPresenter
//    case containerView
//    case split
//}


//enum CoordinatorPresentationType {
//    case useNavigation
//    case modal
//    case container ??
//}

public protocol CoordinatorType: AnyObject {
    var childCoordinators: [CoordinatorType] { get }
    var parentCoordinator: CoordinatorType? { get set }
    
//    func start()
    func start(coordinator: CoordinatorType)
//    func didFinish(coordinator: CoordinatorType)
//    func removeChildCoordinators()
    
    // debug
    func dump(depth: Int)
}

public protocol Containable {
    associatedtype Container: AnyObject
    var container: Container! { get set }
}

open class Coordinator<Container: AnyObject>: CoordinatorType, Containable {
    
    public let disposeBag = DisposeBag()
    
    public weak var container: Container! // TODO - check if we can remove implicit unwrap
    
    open var childCoordinators: [CoordinatorType] {
        fatalError("You should override childCoordinators in \(String(describing: self)) !!!")
    }
    public weak var parentCoordinator: CoordinatorType?
    
//    func start() {
//        fatalError("Start method should be implemented.")
//    }
    
    public func start(coordinator: CoordinatorType) {
        coordinator.parentCoordinator = self
//        coordinator.start()
    }
    
//    func removeChildCoordinators() {
//        self.childCoordinators.forEach { $0.removeChildCoordinators() }
//        self.childCoordinators.removeAll()
//    }
    
//    func didFinish(coordinator: CoordinatorType) {
//        if let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) {
//            self.childCoordinators.remove(at: index)
//        }
//    }
}

extension Coordinator where Container: UIViewController {

    /// end current coordinator if it was presented modally
    func endModal() {
        guard let presenter = container.presentingViewController else {
            print("this coordinator was not presented modally")
            return
        }
        presenter.dismiss(animated: true) {
            /// break link to container
            self.container = nil
        }
    }
}

// DEBUG

//extension Coordinator: CustomDebugStringConvertible {
//    var debugDescription: String {
//        return "(\(String(describing:self)))"
//    }
//}

extension Coordinator {
    
    var address: String {
        return "\(Unmanaged.passUnretained(self).toOpaque())"
    }
    
    public func dump(depth: Int = 0) {
        var indentation: String = ""
        (0..<depth).forEach { _ in indentation += "    " }
        print("\(indentation)\(self)")
        
        childCoordinators.forEach { coordinator in
            coordinator.dump(depth: depth + 1)
        }
    }
}

/// AppCoordinator

open class AppCoordinator: Coordinator<UIWindow> {

    public private(set) weak var rootCoordinator: CoordinatorType?
    
    public override var childCoordinators: [CoordinatorType] {
        return [rootCoordinator].compactMap { $0 }
    }
    
    public init(container: UIWindow) {
        super.init()
        
        debugPrint("++++ APP COORDINATOR - \(self) - (\(address))")
        self.container = container
    }
        
    deinit {
        debugPrint("---- APP COORDINATOR - \(self) - (\(address))")
    }
}

/// present other coordinators

public extension AppCoordinator {
    func present<Container: UIViewController>(coordinator: Coordinator<Container>) {
        super.start(coordinator: coordinator)
        
        rootCoordinator = coordinator
        
        container.rootViewController = coordinator.container
        container.makeKeyAndVisible()
    }
}

/// NavigationCoordinator

public enum NavigationCoordinatorOption {
    case newNavigation
    case useNavigation(UINavigationController)
}

open class NavigationCoordinator: Coordinator<UINavigationController> {

    public weak var rootViewController: UIViewController!
    
    public override init() {
        super.init()
        debugPrint("++++ NAVIGATION COORDINATOR - \(self) - (\(address))")
    }

    deinit {
        debugPrint("---- NAVIGATION COORDINATOR - \(self) - (\(address))")
    }

    open func setup(navigationOption: NavigationCoordinatorOption) {
        rootViewController = buildRoot()
        
        let container: Container
        
        switch navigationOption {
        case .newNavigation:
            container = UINavigationController(rootViewController: rootViewController)
        case .useNavigation(let navigationController):
            container = navigationController
        }
        
        self.container = container
    }
    
    // TODO: change to completion on constructors
    open func buildRoot() -> UIViewController {
        fatalError("You should override buildRoot in \(String(describing: self)) !!!")
    }
    
    /// present view controller
    
    public func push(_ viewController: UIViewController) {
        container.pushViewController(viewController, animated: true)
    }
}

/// present other coordinators

extension NavigationCoordinator {

    /// will present the navigation coordinator using the same navigation controller
    public func prepare(otherNavigationCoordinator: NavigationCoordinator) {
        super.start(coordinator: otherNavigationCoordinator)
        
        otherNavigationCoordinator.setup(navigationOption: .useNavigation(container))
    }
    
    /// will present the navigation coordinator using the same navigation controller
    public func present(otherNavigationCoordinator: NavigationCoordinator) {
        super.start(coordinator: otherNavigationCoordinator)
        
        otherNavigationCoordinator.setup(navigationOption: .useNavigation(container))
        container.pushViewController(otherNavigationCoordinator.rootViewController, animated: true)
    }
    
    /**
     will present the navigation coordinator using the same navigation controller, all view controllers which are in the stack after **startViewController**, will be popped
     */
    public func present<T: UIViewController>(otherNavigationCoordinator: NavigationCoordinator, startViewContollerType: T.Type) {
        super.start(coordinator: otherNavigationCoordinator)
        
        otherNavigationCoordinator.setup(navigationOption: .useNavigation(container))
        
        var viewControllers = container.viewControllers
        guard let startIndex = viewControllerIndex(of: startViewContollerType) else { fatalError() }
        viewControllers.removeSubrange((startIndex + 1)...)
        
        viewControllers.append(otherNavigationCoordinator.rootViewController)
                
        container.setViewControllers(viewControllers, animated: true)
    }
    
    /// will present modally the navigation coordinator. Presenter will be the current navigation controller
    public func presentModal(otherNavigationCoordinator: NavigationCoordinator) {
        super.start(coordinator: otherNavigationCoordinator)

        otherNavigationCoordinator.setup(navigationOption: .newNavigation)
        container.present(otherNavigationCoordinator.container, animated: true, completion: nil)
    }
}

extension NavigationCoordinator {
    
    public func popTo<T: UIViewController>(type: T.Type) {
        
        guard let viewController = viewController(of: type) else {
            print("🛑 ERROR: UIViewController(\(type)) not in navigation stack")
            return
        }
        
        container.popToViewController(viewController, animated: true)
    }
    
    private func viewController<T: UIViewController>(of type: T.Type) -> T? {
        return container.viewControllers.first(where: { $0.isKind(of: type) }) as? T
    }
    
    private func viewControllerIndex<T: UIViewController>(of type: T.Type) -> Int? {
        return container.viewControllers.firstIndex(where: { $0.isKind(of: type) })
    }
}

extension NavigationCoordinator {
    
    /// end current coordinator if it was presented modally
    ///
    /// Navigation coordinators can share the same container (NavigationController) and when one coordinator decides to end modal,
    /// then all navigation coordinators that are sharing the same container should unlink fom container
    ///
    public func endModal() {

//        guard let presenter = container.presentingViewController else {
//            print("this coordinator was not presented modally")
//            return
//        }
//        presenter.dismiss(animated: true) {
//            /// break link to container
//            self.container.coordinators?.forEach { $0?.container = nil }
//        }

        
        guard let presenter = container.presentingViewController else {
            fatalError("This coordinator was not presented modally")
        }
        presenter.dismiss(animated: true) {
//            self.parentCoordinator?.didFinish(coordinator: self)
        }
    }
}

/// TabbarCoordinator

open class TabbarCoordinator: Coordinator<UITabBarController> {

    public override init() {
        super.init()
        debugPrint("++++ TABBAR COORDINATOR: \(self) - (\(address))")
        
        let container = UITabBarController()
        self.container = container
        container.viewControllers = buildViewControllers()
    }

    deinit {
        debugPrint("---- TABBAR COORDINATOR: \(self) - (\(address))")
    }
    
    // TODO: change to completion on constructor
    open func buildViewControllers() -> [UIViewController] {
        fatalError("You should override buildViewControllers in \(String(describing: self)) !!!")
    }
//
//    func addCoordinator(coordinator: NavigationCoordinator, title: String, tag: Int) -> UIViewController {
//
//        coordinator.setup(navigationOption: .newNavigation)
//        coordinator.container.tabBarItem = UITabBarItem(title: title, image: nil, tag: tag)
//
//        return coordinator.container
//    }
    
}

/// ContainerCoordinator

open class ContainerCoordinator<T: UIViewController>: Coordinator<T> {
        
    public override init() {
        super.init()
        debugPrint("++++ CONTAINER COORDINATOR - \(self) - (\(address))")
    }

    deinit {
        debugPrint("---- CONTAINER COORDINATOR - \(self) - (\(address))")
    }
}
