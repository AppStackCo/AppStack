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
// TODO: handle loading animations

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
    public lazy var allElementsObservable = allElementsRelay.asObservable().skip(1)
    
    // error
    
    // is loading
    
    private let disposeBag = DisposeBag()

    private let allElementsRelay = BehaviorRelay<[T]>(value: [])

    private var isRequestingPage = false
    
    private var nextPage: Int?

    private let pageProvider: PageProvider<T>
    
    public init(
        input: PaginationInput,
        pageProvider: PageProvider<T>) {
            
        self.pageProvider = pageProvider
    }
    
    public func getFirstPage() {
        
        NSLog("getFirstPage")
        
        // start animation
        
        getPage(page: nil)
            .subscribe(
                onSuccess: { [weak self] elements in
                    
                    self?.allElementsRelay.accept(elements)
                    
                }, onDisposed: {
                    
                    // stop animation
                    print("get first page - disposed")
                    
                })
            .disposed(by: disposeBag)
    }
    
    public func getNextPage() {
        
        guard nextPage != nil else { return }
        
        // start animation
        
        return getPage(page: nextPage)
            .subscribe(
                onSuccess: { [weak self] newElements in
                    
                    guard var allElements = self?.allElementsRelay.value else { return }
                    allElements.append(contentsOf: newElements)
                    self?.allElementsRelay.accept(allElements)
                    
                }, onFailure: { _ in
                    
                    // handle error
                    
                }, onDisposed: {
                    
                    // stop animation
                    
                })
            .disposed(by: disposeBag)
    }
        
    private func getPage(page: Int?) -> Single<[T]> {

        print("get page - 1 - is requesting page: \(isRequestingPage)")

        guard !isRequestingPage else { return .never() }
        isRequestingPage = true
        print("get page - 2 - is requesting page: true")

        
        let currentPage = nextPage
        
        return pageProvider.getPage(currentPage)
            .do(
                onSuccess: { [weak self] _, hasNextPage in
                    if hasNextPage {
                        self?.nextPage = currentPage ?? 1 + 1
                    } else {
                        self?.nextPage = nil
                    }
                    
                    self?.isRequestingPage = false
                    print("onSuccess - is requesting page: false")

                }, onError: { [weak self] _ in
                    
                    self?.isRequestingPage = false
                    print("onError - is requesting page: false")

                }, onDispose: { [weak self] in
              
//                    self?.isRequestingPage = false
                    
                    print("dispose - is requesting page: false")
                    
                })
            .map { $0.0 }
    }
}
