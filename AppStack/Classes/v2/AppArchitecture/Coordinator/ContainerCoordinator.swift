//
//  ContainerCoordinator.swift
//  AppStack
//
//  Created by Marius Gutoi on 22.07.2021.
//

open class ContainerCoordinator<T: UIViewController>: Coordinator<T> {
        
    public override init() {
        super.init()
        debugPrint("++++ CONTAINER COORDINATOR - \(self) - (\(address))")
    }

    deinit {
        debugPrint("---- CONTAINER COORDINATOR - \(self) - (\(address))")
    }
}
