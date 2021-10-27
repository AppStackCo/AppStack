//
//  SplashViewModel.swift
//  AppStack
//
//  Created by Marius Gutoi on 19.07.2021.
//  Copyright (c) 2021 CocoaPods. All rights reserved.
//

import AppStack

final class SplashViewModel: ViewModel {

    let route: SplashRoute
    let data: SplashData?

    // additional properties go here

    init(route: SplashRoute, data: SplashData?) {

        self.route = route
        self.data = data
        
        // additional init go here
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
        
            self?.route.splashAnimationDidEnd()
        }
        
    }
}

// MARK: - SplashData

struct SplashData {
}
