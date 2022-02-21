//
//  CharacterListInteractor.swift
//  AppStack-Demo
//
//  Created by Marius Gutoi on 21/2/22.
//  Copyright © 2022 AppStack. All rights reserved.
//

import RxSwift

final class CharacterListInteractor {
    
    private var isRequestingPage = false
    private var nextPage: Int?
    
    func getFirstPage() -> Single<[CharacterEntity]> {
        getPage(page: nil)
    }
    
    func getNextPage() -> Single<[CharacterEntity]> {
        guard nextPage != nil else { return .just([]) }
        return getPage(page: nextPage)
    }
    
    private func getPage(page: Int?) -> Single<[CharacterEntity]> {
        let currentPage = nextPage
        return Repository.shared.getCharacters(page: currentPage)
            .do(onSuccess: { [weak self] _, hasNextPage in
                if hasNextPage {
                    let requestedPage = currentPage ?? 1
                    self?.nextPage = requestedPage + 1
                } else {
                    self?.nextPage = nil
                }
            })
            .map { $0.0 }
    }
}
