//
//  PagingInteractor.swift
//  AppStack-Demo
//
//  Created by Marius Gutoi on 21/2/22.
//  Copyright © 2022 AppStack. All rights reserved.
//

import RxRelay
import RxSwift

// TODO: handle errors

struct PaginationInput {
    /// reloads first page and dumps all other cached pages.
    let refresh: Observable<Void>
    /// loads next page
    let loadNextPage: Observable<Void>
}

// dependency
struct PageProvider<T> {
    let getPage: (Int?) -> Single<([T], Bool)>
}

final class PagingInteractor<T> {
    
    /// Pagination Output
    
    // elements
//    lazy var allElementsObservable = allElementsRelay.asObservable().skip(1)
        
    /// true if network loading is in progress
    let isLoading: Observable<Bool>
    
    /// elements from all loaded pages
    let elements: Observable<[T]>
    
    /// fires once for each error
    let error: Observable<Error>
    
//    private let disposeBag = DisposeBag()

    private let allElementsRelay = BehaviorRelay<[T]>(value: [])

//    private var isRequestingPage = false
    
//    private var nextPage: Int?

//    private let pageProvider: PageProvider<T>
    
    public init(
        input: PaginationInput,
        pageProvider: PageProvider<T>) {
            
//        self.pageProvider = pageProvider
            
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
       
       let _error = page
           .map { $0.error }
           .filter { $0 != nil }
           .map { $0! }
       
       isLoading = _isLoading
       elements = _elements
       error = _error
    }
    
//    public func getFirstPage() {
//
//        NSLog("getFirstPage")
//
//        // start animation
//
//        getPage(page: nil)
//            .subscribe(
//                onSuccess: { [weak self] elements in
//
//                    self?.allElementsRelay.accept(elements)
//
//                }, onDisposed: {
//
//                    // stop animation
//                    print("get first page - disposed")
//
//                })
//            .disposed(by: disposeBag)
//    }
//
//    public func getNextPage() {
//
//        guard nextPage != nil else { return }
//
//        // start animation
//
//        return getPage(page: nextPage)
//            .subscribe(
//                onSuccess: { [weak self] newElements in
//
//                    guard var allElements = self?.allElementsRelay.value else { return }
//                    allElements.append(contentsOf: newElements)
//                    self?.allElementsRelay.accept(allElements)
//
//                }, onFailure: { _ in
//
//                    // handle error
//
//                }, onDisposed: {
//
//                    // stop animation
//
//                })
//            .disposed(by: disposeBag)
//    }
        
//    private func getPage(page: Int?) -> Single<[T]> {
//
//        print("get page - 1 - is requesting page: \(isRequestingPage)")
//
//        guard !isRequestingPage else { return .never() }
//        isRequestingPage = true
//        print("get page - 2 - is requesting page: true")
//
//
//        let currentPage = nextPage
//
//        return pageProvider.getPage(currentPage)
//            .do(
//                onSuccess: { [weak self] _, hasNextPage in
//                    if hasNextPage {
//                        self?.nextPage = currentPage ?? 1 + 1
//                    } else {
//                        self?.nextPage = nil
//                    }
//
//                    self?.isRequestingPage = false
//                    print("onSuccess - is requesting page: false")
//
//                }, onError: { [weak self] _ in
//
//                    self?.isRequestingPage = false
//                    print("onError - is requesting page: false")
//
//                }, onDispose: { [weak self] in
//
////                    self?.isRequestingPage = false
//
//                    print("dispose - is requesting page: false")
//
//                })
//            .map { $0.0 }
//    }
}
