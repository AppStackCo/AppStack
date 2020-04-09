//
//  ScreenFlowViewModel.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 11/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import Action

public protocol ScreenFlowViewModel {
    var leftBarButtonItemAction: CocoaAction { get }
    var rightBarButtonItemAction: CocoaAction { get }
}

extension ScreenFlowViewModel where Self: ViewModelProtocol {
    public var leftBarButtonItemAction: CocoaAction {
        CocoaAction {
            (self.navigator as? ScreenFlowNavigator)?.navigateBack()
            
            return .empty()
        }
    }
    
    public var rightBarButtonItemAction: CocoaAction {
        CocoaAction { .empty() }
    }
}
