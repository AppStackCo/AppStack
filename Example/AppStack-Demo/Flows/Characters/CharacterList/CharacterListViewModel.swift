//
//  CharacterListViewModel.swift
//  AppStack
//
//  Created by Marius Gutoi on 21/2/22.
//  Copyright (c) 2022 AppStack. All rights reserved.
//

import AppStack
import RxCocoa
import RxDataSources
import RxRelay
import RxSwift

enum CharacterListCellModelType {
    case character(CharacterEntity)
}

final class CharacterListViewModel: ViewModel {
    
    let route: CharacterListRoute
    let data: CharacterListData?

    private let disposeBag = DisposeBag()
    
    // additional properties go here

    private let charactersRelay = BehaviorRelay<[CharacterEntity]>(value: [])
    
    private let characterListInteractor = CharacterListInteractor()
    
    var charactersDriver: Driver<[SectionOfCharacterListCellModels]> {
        charactersRelay
            .map { characters in
                [SectionOfCharacterListCellModels(header: "", items: characters.map { .character($0) })]
            }
            .asDriver(onErrorJustReturn: [])
    }
    
    init(route: CharacterListRoute, data: CharacterListData?) {

        self.route = route
        self.data = data
        
        // additional init go here
        
        characterListInteractor.getFirstPage()
            .subscribe(onSuccess: { [weak self] characters in
                print(characters)
                self?.charactersRelay.accept(characters)
            })
            .disposed(by: disposeBag)
    }
    
    func getNextPageIfAny() {
        
        guard characterListInteractor.hasMorePages else { return }
        
        // start animation
        
        characterListInteractor.getNextPage()
            .subscribe(
                onSuccess: { [weak self] newCharacters in
                    
                    guard var characters = self?.charactersRelay.value else { return }
                    characters.append(contentsOf: newCharacters)
                    self?.charactersRelay.accept(characters)
                    
                }, onFailure: { _ in

                    // handle error
                    
                },onDisposed: {
                    
                    // stop animation
                    
                })
            .disposed(by: disposeBag)
    }
}

// MARK: - CharacterListData

struct CharacterListData {
}

struct SectionOfCharacterListCellModels {
    var header: String
    var items: [Item]
}

extension SectionOfCharacterListCellModels: SectionModelType {
    typealias Item = CharacterListCellModelType
    
    init(original: SectionOfCharacterListCellModels, items: [Item]) {
        self = original
        self.items = items
    }
}
