//
//  PagingInteractor.swift
//  AppStack-Demo
//
//  Created by Marius Gutoi on 21/2/22.
//  Copyright © 2022 AppStack. All rights reserved.
//

import RxRelay
import RxSwift

struct PaginationInput {
    
    /// reloads first page and dumps all other cached pages.
    let refresh: Observable<Void>
    
    /// loads next page
    let loadNextPage: Observable<Void>
}

/// Dependency
struct PageProvider<T> {
    let getPage: (Int?) -> Single<([T], Bool)>
}

final class PagingInteractor<T> {
    
    /// Pagination Output
    
    /// true if network loading is in progress
    let isLoading: Observable<Bool>
    
    /// elements from all loaded pages
    let elements: Observable<[T]>
    
    /// fires once for each error
    let error: Observable<Error>
    
    public init(input: PaginationInput, pageProvider: PageProvider<T>) {
        
        let loadResults = BehaviorSubject<[Int: [T]]>(value: [:])
        
        let maxPage = loadResults
            .map { $0.keys }
            .map { $0.max() ?? 1 }
        
        let reload = input.refresh
            .map { -1 }
        
        let loadNext = input.loadNextPage
            .withLatestFrom(maxPage)
            .map { $0 + 1 }
        
        let start = Observable.merge(reload, loadNext, Observable.just(1))
        
        let page = start
            .flatMap { page -> Observable<Event<(pageNumber: Int, items: [T])>> in
                
                let getPage = pageProvider.getPage(page == -1 ? 1 : page)
                    .asObservable()
                    .map { $0.0 }
                
                return Observable
                    .combineLatest(Observable.just(page), getPage) { (pageNumber: $0, items: $1) }
                    .materialize()
                    .filter { $0.isCompleted == false }
            }
            .share() // Event<(pageNumber: Int, items: [T])>
        
        // merge results
        _ = page
            .compactMap { $0.element }
            .withLatestFrom(loadResults) { (pages: $1, newPage: $0) }
            .filter { $0.newPage.pageNumber == -1 || !$0.newPage.items.isEmpty }
            .map {
                $0.newPage.pageNumber == -1
                ? [1: $0.newPage.items]
                : $0.pages.merging([$0.newPage], uniquingKeysWith: { $1 }) }
            .subscribe(loadResults)
        
        let _isLoading = Observable.merge(start.map { _ in 1 }, page.map { _ in -1 })
            .scan(0, accumulator: +)
            .map { $0 > 0 }
            .distinctUntilChanged()
        
        let _elements = loadResults
            .map { $0.sorted(by: { $0.key < $1.key }).flatMap { $0.value } }
            .skip(1) // skip first value (empty)
        
        let _error = page
            .map { $0.error }
            .filter { $0 != nil }
            .map { $0! }
        
        isLoading = _isLoading
        elements = _elements
        error = _error
    }
}
