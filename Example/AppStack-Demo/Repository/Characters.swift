//
//  Characters.swift
//  AppStack-Demo
//
//  Created by Marius Gutoi on 21/2/22.
//  Copyright © 2022 AppStack. All rights reserved.
//

import Foundation

struct CharacterList: Decodable {
    let info: PaginationInfo
    let results: [CharacterEntity]
}

struct PaginationInfo: Decodable {
    let count: Int
    let pages: Int
    let nextPageUrl: URL?
    let prevPageUrl: URL?
    
    private enum CodingKeys: String, CodingKey {
        case count
        case pages
        case nextPageUrl = "next"
        case prevPageUrl = "prev"
    }
}

struct CharacterEntity: Decodable {
    let name: String
    let image: URL
}
