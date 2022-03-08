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
    
    /// INPUTS
    
    /// reloads first page and dumps all other cached pages.
    private let refresh = PublishRelay<Void>()
    
    /// loads next page
    private let loadNextPage = PublishRelay<Void>()
    
    /// Dependency
    
    private lazy var characterListInteractor: PagingInteractor<CharacterEntity> = {
        
        let paginationInput = PaginationInput(
            refresh: refresh.asObservable(),
            loadNextPage: loadNextPage.asObservable())
        
        return PagingInteractor(
            input: paginationInput,
            pageProvider: PageProvider(getPage: Repository.shared.getCharacters))
    }()
    
    /// OUTPUTS
    
    var charactersDriver: Driver<[SectionOfCharacterListCellModels]> {
        characterListInteractor.elements
            .map { characters in
                [SectionOfCharacterListCellModels(header: "", items: characters.map { .character($0) })]
            }
            .asDriver(onErrorJustReturn: [])
    }
    
    var isLoadingDriver: Driver<Bool> {
        characterListInteractor.isLoading
            .asDriver(onErrorJustReturn: false)
    }
    
    init(route: CharacterListRoute, data: CharacterListData?) {

        self.route = route
        self.data = data
        
        // additional init go here
        
    }
    
    func bind(loadNextPage: Observable<Void>) {
        loadNextPage.bind(to: self.loadNextPage).disposed(by: disposeBag)
    }
    
//    func loadFirstPage() {
//        refresh.accept(())
//    }
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
