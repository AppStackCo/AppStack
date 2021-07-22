//
//  SettingsViewModel.swift
//  AppStack
//
//  Created by Marius Gutoi on 22.07.2021.
//  Copyright (c) 2021 CocoaPods. All rights reserved.
//

import AppStack

final class SettingsViewModel: ViewModel {

    let route: SettingsRoute
    let data: SettingsData?

    // additional properties go here

    init(route: SettingsRoute, data: SettingsData?) {

        self.route = route
        self.data = data
        
        // additional init go here
        
    }
}

// MARK: - SettingsData

struct SettingsData {
}
