//
//  SplashCoordinator.swift
//  AppStack-Demo
//
//  Created by Marius Gutoi on 19.07.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import AppStack

final class SplashCoordinator: NavigationCoordinator {
    
    var coordinatorDidEnd: (() -> Void)?
        
    override func buildRoot() -> UIViewController {
        let rootViewController = SplashBuilder.build(route: self)
        return rootViewController
    }
}

extension SplashCoordinator: SplashRoute {
    func splashAnimationDidEnd() {
        coordinatorDidEnd?()
    }
}
