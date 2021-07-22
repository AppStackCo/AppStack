//
//  Repository.swift
//  AppStack-Demo
//
//  Created by Marius Gutoi on 22.07.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import RxRelay
import RxSwift

enum DemoAppState {
    case idle
    case loggedOut
    case loggedIn
}

final class Repository {
    
    static let shared = Repository()
    
    private let disposeBag = DisposeBag()
    
    // network layer
    
    // local storage
    
    //
    private let appStateRelay = BehaviorRelay<DemoAppState>(value: .idle)
    lazy var appStateObservable = appStateRelay.asObservable()
    
    private init() {
        
        // start
        Observable<DemoAppState>
            .just(.loggedOut)
            .delay(.seconds(3), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] appState in
                self?.appStateRelay.accept(appState)
            })
            .disposed(by: disposeBag)
    }
    
}

extension Repository {
    
    func login() -> Completable {
        
        Completable
            .empty()
            .delay(.seconds(4), scheduler: MainScheduler.instance)
            .do(onCompleted: { [weak self] in
                self?.appStateRelay.accept(.loggedIn)
            })
    }
    
    func logout() {
        
        appStateRelay.accept(.loggedOut)
    }
}
