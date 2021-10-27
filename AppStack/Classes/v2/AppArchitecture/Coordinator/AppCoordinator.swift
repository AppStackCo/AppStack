//
//  AppCoordinator.swift
//  AppStack
//
//  Created by Marius Gutoi on 22.07.2021.
//

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
