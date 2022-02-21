//
//  MainCoordinator.swift
//  AppStack-Demo
//
//  Created by Marius Gutoi on 22.07.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import AppStack

final class MainCoordinator: TabbarCoordinator {
    
    override func buildViewControllers() -> [UIViewController] {
        
        let charactersCoordinator = CharactersCoordinator()
        charactersCoordinator.setup(navigationOption: .newNavigation)
        charactersCoordinator.container.tabBarItem = UITabBarItem(title: "Chatacters", image: nil, tag: 1)

        let settingsViewController2 = SettingsBuilder.build(route: self)
        settingsViewController2.tabBarItem = UITabBarItem(title: "Second", image: nil, tag: 2)

        return [charactersCoordinator.container, settingsViewController2]
        
    }
}

extension MainCoordinator: SettingsRoute {
    
}
