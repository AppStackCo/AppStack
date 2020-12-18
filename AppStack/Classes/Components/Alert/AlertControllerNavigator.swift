//
//  AlertControllerNavigator.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import Action

public protocol AlertControllerNavigator {
    func presentAlert(using model: AlertControllerModel)
    func presentErrorAlert(using error: Error, action: CocoaAction?)
    func presentErrorAlert(using error: Error, completionHandler: (() -> Void)?)
}

extension AlertControllerNavigator where Self: BaseNavigator {
    public func presentAlert(using model: AlertControllerModel) {
        let alertNavigator = BaseNavigatorImplementation(baseController: baseController)
        alertNavigator.presentAlert(using: model)
    }
    
    func presentErrorAlert(using error: Error, action: CocoaAction?) {
        let alertNavigator = BaseNavigatorImplementation(baseController: baseController)
        alertNavigator.presentErrorAlert(using: error, action: action)
    }
    
    func presentErrorAlert(using error: Error, completionHandler: (() -> Void)?) {
        let alertNavigator = BaseNavigatorImplementation(baseController: baseController)
        alertNavigator.presentErrorAlert(using: error, completionHandler: completionHandler)
    }
}
