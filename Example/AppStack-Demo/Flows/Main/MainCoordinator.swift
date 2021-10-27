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
        
        let settingsViewController = SettingsBuilder().build(route: self)
        settingsViewController.tabBarItem = UITabBarItem(title: "First", image: nil, tag: 1)

        let settingsViewController2 = SettingsBuilder().build(route: self)
        settingsViewController2.tabBarItem = UITabBarItem(title: "Second", image: nil, tag: 2)

        return [settingsViewController, settingsViewController2]
        
    }
}

extension MainCoordinator: SettingsRoute {
    
}
