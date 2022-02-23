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

struct PageProvider<T> {
    let provider: (Int?) -> Single<([T], Bool)>
}

final class PagingInteractor<T> {
    
    public lazy var allElementsObservable = allElementsRelay.asObservable().skip(1)
    private let allElementsRelay = BehaviorRelay<[T]>(value: [])
    
    private let disposeBag = DisposeBag()
        
    private var isRequestingPage = false
    private var nextPage: Int?

    private let pageProvider: PageProvider<T>
    
    public init(pageProvider: PageProvider<T>) {
        self.pageProvider = pageProvider
    }
    
    public func getFirstPage() {
        
        // start animation
        
        getPage(page: nil)
            .subscribe(
                onSuccess: { [weak self] elements in
                    
                    self?.allElementsRelay.accept(elements)
                    
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
        
        guard !isRequestingPage else { return .just([]) }
        isRequestingPage = true
        
        let currentPage = nextPage
        
        return pageProvider.provider(currentPage)
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
