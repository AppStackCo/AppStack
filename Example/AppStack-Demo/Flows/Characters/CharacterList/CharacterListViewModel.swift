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
    
    private lazy var characterListInteractor =
        PagingInteractor(pageProvider: PageProvider(provider: Repository.shared.getCharacters))
    
    var charactersDriver: Driver<[SectionOfCharacterListCellModels]> {
        characterListInteractor.allElementsObservable
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
    }
    
    func getNextPageIfAny() {
                
        // start animation
        
        characterListInteractor.getNextPage()
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
