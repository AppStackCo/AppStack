//
//  AlertControllerNavigator.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

public protocol AlertControllerNavigator {
    func showAlert(using model: AlertControllerModel)
}

extension AlertControllerNavigator where Self: BaseNavigator {
    public func showAlert(using model: AlertControllerModel) {
        let alertNavigator = AlertNavigatorImplementation(baseController: self.baseController)
        alertNavigator.presentAlert(using: model)
    }
}
