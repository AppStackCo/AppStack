//
//  LoginViewModel.swift
//  AppStack
//
//  Created by Marius Gutoi on 22.07.2021.
//  Copyright (c) 2021 CocoaPods. All rights reserved.
//

import AppStack

final class LoginViewModel: ViewModel {

    let route: LoginRoute
    let data: LoginData?

    // additional properties go here

    init(route: LoginRoute, data: LoginData?) {

        self.route = route
        self.data = data
        
        // additional init go here
        
    }
}

// MARK: - LoginData

struct LoginData {
}
