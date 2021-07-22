//
//  NavigationCoordinator.swift
//  AppStack
//
//  Created by Marius Gutoi on 22.07.2021.
//

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
