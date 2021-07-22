//
//  TabbarCoordinator.swift
//  AppStack
//
//  Created by Marius Gutoi on 22.07.2021.
//

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
