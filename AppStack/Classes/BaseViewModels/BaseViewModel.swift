//
//  BaseViewModel.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 09/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import RxCocoa
import RxSwift

public enum LoadingStatus {
    case loading
    case idle
}

public protocol ViewModelProtocol {
    associatedtype N
    var navigator: N { get }
    init(navigator: N)
}

public protocol LoadingStateViewModel {
    var loadingStatusDriver: Driver<LoadingStatus> { get }
}

open class BaseViewModel<N>: ViewModelProtocol, LoadingStateViewModel {
    public var navigator: N
    
    public var loadingStatusSubject = PublishSubject<LoadingStatus>()
    
    public var loadingStatusDriver: Driver<LoadingStatus> {
        loadingStatusSubject.asDriver(onErrorJustReturn: .idle)
    }
    
    public required init(navigator: N) {
        self.navigator = navigator
    }
}
