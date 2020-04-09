//
//  AlertConnector.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

class AlertConnector: BaseConnector {
    typealias ViewController = AlertViewController
    typealias Navigator = AlertNavigatorImplementation
    
    var viewModel: AlertViewModel?
    
    func buildViewModel(navigator: AlertNavigatorImplementation, inputData: AlertControllerModel) -> AlertViewModel {
        AlertViewModel(navigator: navigator, inputData: inputData)
    }
}
