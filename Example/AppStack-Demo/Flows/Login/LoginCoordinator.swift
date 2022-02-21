//
//  LoginCoordinator.swift
//  AppStack-Demo
//
//  Created by Marius Gutoi on 22.07.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import AppStack

final class LoginCoordinator: NavigationCoordinator {
    
    override func buildRoot() -> UIViewController {
        let rootViewController = LoginBuilder.build(route: self)
        return rootViewController
    }
}

extension LoginCoordinator: LoginRoute {
    
}
