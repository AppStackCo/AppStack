//
//  CharacterListInteractor.swift
//  AppStack-Demo
//
//  Created by Marius Gutoi on 21/2/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import RxSwift

final class CharacterListInteractor {

    var hasMorePages = false
    
    private var isRequestingPage = false
    private var nextPage: Int?
    
    func getFirstPage() -> Single<[CharacterEntity]> {
        Repository.shared.getCharacters()
    }
    
    func getNextPage() -> Single<[CharacterEntity]> {
        .just([])
    }
    
    private func getPage(page: Int?) -> Single<[CharacterEntity]> {
        Repository.shared.getCharacters(page: page)
    }
}
