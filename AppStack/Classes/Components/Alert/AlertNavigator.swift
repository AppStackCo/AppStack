//
//  AlertNavigator.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import UIKit

protocol AlertNavigator: ScreenFlowNavigator {
    func presentAlert(using model: AlertControllerModel)
}

class AlertNavigatorImplementation: BaseNavigatorImplementation<UIViewController>, AlertNavigator {
    private var animatorPresenter: AnimatorPresenter?
    
    func presentAlert(using model: AlertControllerModel) {
        let alertViewController: AlertViewController = AlertConnector().buildViewController(navigator: self, storyboard: .common, inputData: model)
        
        self.animatorPresenter = AnimatorPresenter(controller: self.baseController)
        self.animatorPresenter?.performCoverPresentation(animatorController: alertViewController,
                                                         height: alertViewController.getInitialContentHeight(),
                                                         isTapBackgroundToDismissEnabled: true)
    }
}
