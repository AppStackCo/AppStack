//
//  AlertNavigator.swift
//  AppointmentsBO
//
//  Created by Alin Popa on 22/03/2020.
//  Copyright © 2020 AppStack. All rights reserved.
//

import Action
import UIKit

public protocol AlertNavigator {
    func presentAlert(using model: AlertControllerModel)
    func presentErrorAlert(using error: Error, action: CocoaAction?)
    func presentErrorAlert(using error: Error, completionHandler: (() -> Void)?)
    func dismiss(completionHandler: (() -> Void)?)
}

//class AlertNavigatorImplementation: BaseNavigatorImplementation<UIViewController> {
//    private var animatorPresenter: AnimatorPresenter?
//
//    func presentAlert(using model: AlertControllerModel) {
//        let alertViewController: AlertViewController = AlertConnector().buildViewController(navigator: self, storyboard: .common, inputData: model)
//
//        animatorPresenter = AnimatorPresenter(controller: baseController)
//        animatorPresenter?.performCoverPresentation(animatorController: alertViewController,
//                                                    height: alertViewController.getInitialContentHeight(),
//                                                    isTapBackgroundToDismissEnabled: true)
//    }
//
//    func dismiss(completionHandler: (() -> Void)?) {
//        baseController.dismiss(animated: true)
//    }
//}
