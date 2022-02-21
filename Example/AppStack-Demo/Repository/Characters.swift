//
//  Characters.swift
//  AppStack-Demo
//
//  Created by Marius Gutoi on 21/2/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

struct CharacterList: Decodable {
    let results: [CharacterEntity]
}


struct CharacterEntity: Decodable {
    let name: String
    let image: URL
}
