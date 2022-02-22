//
//  CharacterListInteractor.swift
//  AppStack-Demo
//
//  Created by Marius Gutoi on 21/2/22.
//  Copyright © 2022 AppStack. All rights reserved.
//

import RxRelay
import RxSwift

// TODO: handle errors
// TODO: handle loading animations

typealias CharactersProvider = (Int?) -> Single<([CharacterEntity], Bool)>

final class CharacterListInteractor {
    
    public lazy var charactersObservable = charactersRelay.asObservable().skip(1)
    private let charactersRelay = BehaviorRelay<[CharacterEntity]>(value: [])
    
    private let disposeBag = DisposeBag()
        
    private var isRequestingPage = false
    private var nextPage: Int?

    private let charactersProvider: CharactersProvider
    
    public init(charactersProvider: @escaping CharactersProvider) {
        self.charactersProvider = charactersProvider
    }
    
    public func getFirstPage() {
        
        // start animation
        
        getPage(page: nil)
            .subscribe(
                onSuccess: { [weak self] characters in
                    
                    self?.charactersRelay.accept(characters)
                    
                }, onDisposed: {
                    
                    // stop animation
                    
                })
            .disposed(by: disposeBag)
    }
    
    public func getNextPage() {
        
        guard nextPage != nil else { return }
        
        // start animation
        
        return getPage(page: nextPage)
            .subscribe(
                onSuccess: { [weak self] newCharacters in
                    
                    guard var characters = self?.charactersRelay.value else { return }
                    characters.append(contentsOf: newCharacters)
                    self?.charactersRelay.accept(characters)
                    
                }, onFailure: { _ in
                    
                    // handle error
                    
                }, onDisposed: {
                    
                    // stop animation
                    
                })
            .disposed(by: disposeBag)
    }
        
    private func getPage(page: Int?) -> Single<[CharacterEntity]> {
        
        guard !isRequestingPage else { return .just([]) }
        isRequestingPage = true
        
        let currentPage = nextPage
        
        return charactersProvider(currentPage)
            .do(
                onSuccess: { [weak self] _, hasNextPage in
                    if hasNextPage {
                        self?.nextPage = currentPage ?? 1 + 1
                    } else {
                        self?.nextPage = nil
                    }
                }, onDispose: { [weak self] in
              
                    self?.isRequestingPage = false
                    
                })
            .map { $0.0 }
    }
}
