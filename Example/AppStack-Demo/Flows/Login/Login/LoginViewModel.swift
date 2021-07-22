//
//  LoginViewModel.swift
//  AppStack
//
//  Created by Marius Gutoi on 22.07.2021.
//  Copyright (c) 2021 CocoaPods. All rights reserved.
//

import Action
import AppStack

final class LoginViewModel: ViewModel {

    let route: LoginRoute
    let data: LoginData?

    // additional properties go here

    var loginAction: CocoaAction {
        CocoaAction {
            Repository.shared.login()
                .asObservable()
                .map { _ in () }
        }
    }
    
    init(route: LoginRoute, data: LoginData?) {

        self.route = route
        self.data = data
        
        // additional init go here
        
    }
}

// MARK: - LoginData

struct LoginData {
}
