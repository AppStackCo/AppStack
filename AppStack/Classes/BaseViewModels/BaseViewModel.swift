//
//  BaseViewModel.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 09/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import RxCocoa
import RxSwift

public protocol ViewModelProtocol {
    associatedtype N
    var navigator: N { get }
    init(navigator: N)
}

open class BaseViewModel<N>: ViewModelProtocol {
    public var navigator: N
    
    public required init(navigator: N) {
        self.navigator = navigator
    }
}
