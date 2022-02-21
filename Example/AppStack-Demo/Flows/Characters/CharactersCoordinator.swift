//
//  CharactersCoordinator.swift
//  AppStack-Demo
//
//  Created by Marius Gutoi on 21/2/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import AppStack

extension UIStoryboard {
    static let characters = UIStoryboard(name: "Characters", bundle: nil)
}

final class CharactersCoordinator: NavigationCoordinator {
    
    override func buildRoot() -> UIViewController {
        CharacterListBuilder.build(route: self)
    }
}

extension CharactersCoordinator: CharacterListRoute {
    
}
